#define _POSIX_C_SOURCE 200809L
#include "my_field.hpp"
#include "value_list_reader.hpp"
#include "circuit_reader.hpp"
#include "common.hpp"
#include <string>
#include <vector>
#include <stdio.h>
#include <inttypes.h>
#include <stdlib.h>
#include <unistd.h>

#define LIKELY(e)   __builtin_expect((e), 1)
#define UNLIKELY(e) __builtin_expect((e), 0)

#define CHECK(e) \
    do { \
        if (UNLIKELY(!(e))) { \
            check_failed(#e, __FILE__, __LINE__); \
        } \
    } while (0)

static void check_failed(const char *expr, const char *file, int line)
{
    fprintf(stderr, "CHECK(%s) failed at %s:%d.\n", expr, file, line);
    abort();
}

static void print_bits(FILE *f, uint64_t x)
{
    char buf[64 + 1 + 1];
    buf[64 + 0] = '\n';
    buf[64 + 1] = '\0';

    for (int i = 64 - 1; i >= 0; --i) {
        int bit = (x >> i) & 1;
        buf[64 - 1 - i] = '0' + bit;
    }

    fputs(buf, f);
}

static inline void putnc(FILE *f, int n, char c)
{
    for (; n; --n)
        fputc(c, f);
}

static void overflow_check_failed(const char *what, unsigned from, const My_Elem &e)
{
    fprintf(stderr, "%s: expected value fitting into %u bit(s), found:\n", what, from);

    unsigned limb_i = from / 64;
    unsigned bit_i = from % 64;

    for (unsigned i = 0; i < fi::Elem_traits<My_Elem>::W; ++i) {
        fprintf(stderr, "word #%u:\n   ", i);
        print_bits(stderr, e.limbs[i]);

        if (i == limb_i) {
            fputs("   ", stderr);
            putnc(stderr, bit_i, ' ');
            fputc('^', stderr);
            putnc(stderr, 64 - bit_i - 1, '~');

        } else if (i > limb_i) {
            fputs("...", stderr);
            putnc(stderr, 64, '~');
        }
        fputc('\n', stderr);
    }

    exit(1);
}

static inline bool elem_bit_at(const My_Elem &e, unsigned pos)
{
    unsigned limb_i = pos / 64;
    unsigned bit_i = pos % 64;

    if (limb_i >= fi::Elem_traits<My_Elem>::W)
        return false;

    uint64_t limb = e.limbs[limb_i];
    return (limb >> bit_i) & 1;
}

static inline void elem_print_bits(const My_Elem &e, uint64_t mask)
{
    print_bits(stdout, e.limbs[0] & mask);
}

// Assumes width <= 64.
static inline uint64_t make_mask(unsigned width)
{
    if (width == 64)
        return -1;
    return (static_cast<uint64_t>(1) << width) - 1;
}

// Assumes width < 64 (otherwise the answer is always false).
static inline bool overflows_width(uint64_t x, unsigned width)
{
    return x & ~((static_cast<uint64_t>(1) << width) - 1);
}

static void elem_check_bits(const My_Elem &e, unsigned from, const char *what)
{
    unsigned limb_i = from / 64;
    unsigned bit_i = from % 64;

    if (limb_i >= fi::Elem_traits<My_Elem>::W)
        return;

    if (UNLIKELY(overflows_width(e.limbs[limb_i], bit_i)))
        overflow_check_failed(what, from, e);

    for (unsigned i = limb_i + 1; i < fi::Elem_traits<My_Elem>::W; ++i)
        if (UNLIKELY(e.limbs[i]))
            overflow_check_failed(what, from, e);
}

// Assumes width <= 64.
static uint64_t elem_to_uint_check(const My_Elem &e, unsigned width, const char *what)
{
    uint64_t x = e.limbs[0];

    if (UNLIKELY(width != 64 && overflows_width(x, width)))
        overflow_check_failed(what, width, e);

    for (unsigned i = 1; i < fi::Elem_traits<My_Elem>::W; ++i)
        if (UNLIKELY(e.limbs[i]))
            overflow_check_failed(what, width, e);

    return x;
}

static void print_usage_and_exit(const std::string &msg = "")
{
    if (!msg.empty())
        fprintf(stderr, "Error: %s.\n", msg.c_str());
    fprintf(stderr, "USAGE: judge [-w <width>] [-c <fd>] [-s <width>] <arithmetic circuit file>\n");
    exit(2);
}

int main(int argc, char **argv)
{
    uint64_t output_mask = make_mask(64);
    unsigned cost_fd = 2; // stderr
    for (int c; (c = getopt(argc, argv, "w:c:s:")) != -1;) {
        switch (c) {
        case 'w':
            {
                unsigned w;
                parse_uint_until_nul(optarg, w, /*base=*/10);
                if (w > 64)
                    print_usage_and_exit("output width ('-w' arg) must be <= 64");
                output_mask = make_mask(w);
            }
            break;
        case 'c':
            parse_uint_until_nul(optarg, cost_fd, /*base=*/10);
            break;
        case 's':
            // ignore
            break;
        default:
            print_usage_and_exit();
        }
    }

    int nposarg = argc - optind;
    if (nposarg != 1)
        print_usage_and_exit("expected exactly one positional argument");

    std::string arci_filename = argv[optind];

    std::vector<My_Elem> wires;
    {
        ValueListReader reader(arci_filename + ".in");
        while (auto value = reader.next_value()) {
            My_Elem e;
            parse_uint_until_nul(value.hex, e, /*base=*/16);
            wires.emplace_back(e);
        }
    }

    CircuitReader reader(arci_filename);
    wires.resize(reader.total());
    uint64_t cost = 0;
    while (auto command = reader.next_command()) {
        switch (command.opcode) {
        case Opcode::INPUT:
        case Opcode::NIZK_INPUT:
            // do nothing
            break;
        case Opcode::ADD:
            CHECK(command.inputs.size() == 2);
            CHECK(command.outputs.size() == 1);
            wires.at(command.outputs[0]) = wires.at(command.inputs[0]) + wires.at(command.inputs[1]);
            break;
        case Opcode::MUL:
            CHECK(command.inputs.size() == 2);
            CHECK(command.outputs.size() == 1);
            wires.at(command.outputs[0]) = wires.at(command.inputs[0]) * wires.at(command.inputs[1]);
            ++cost;
            break;
        case Opcode::CONST_MUL:
            {
                CHECK(command.inputs.size() == 1);
                CHECK(command.outputs.size() == 1);
                My_Elem e;
                parse_uint_until_nul(command.inline_hex, e, /*base=*/16);
                wires.at(command.outputs[0]) = wires.at(command.inputs[0]) * e;
            }
            break;
        case Opcode::CONST_MUL_NEG:
            {
                CHECK(command.inputs.size() == 1);
                CHECK(command.outputs.size() == 1);
                My_Elem e;
                parse_uint_until_nul(command.inline_hex, e, /*base=*/16);
                wires.at(command.outputs[0]) = wires.at(command.inputs[0]) * -e;
            }
            break;
        case Opcode::ZEROP:
            cost += 2;
            CHECK(command.inputs.size() == 1);
            CHECK(command.outputs.size() == 2);
            wires.at(command.outputs[1]) = !!wires.at(command.inputs[0]);
            break;
        case Opcode::SPLIT:
            {
                CHECK(command.inputs.size() == 1);
                My_Elem e = wires.at(command.inputs[0]);
                unsigned noutputs = command.outputs.size();
                for (unsigned i = 0; i < noutputs; ++i) {
                    wires.at(command.outputs[i]) = elem_bit_at(e, i);
                }
                elem_check_bits(e, noutputs, "split");
                cost += noutputs + 1;
            }
            break;
        case Opcode::OUTPUT:
            CHECK(command.inputs.size() == 1);
            elem_print_bits(wires.at(command.inputs[0]), output_mask);
            break;
        case Opcode::DLOAD:
            {
                CHECK(command.inputs.size() > 1);
                CHECK(command.outputs.size() == 1);
                My_Elem e = wires.at(command.inputs[0]);
                uint64_t u = elem_to_uint_check(e, 63, "dload");
                CHECK(u + 1 < command.inputs.size());
                wires.at(command.outputs[0]) = wires.at(command.inputs[u + 1]);
            }
            break;
        case Opcode::ASPLIT:
            {
                CHECK(command.inputs.size() == 1);
                My_Elem e = wires.at(command.inputs[0]);
                unsigned noutputs = command.outputs.size();
                for (unsigned i = 0; i < noutputs; ++i) {
                    wires.at(command.outputs[i]) = !!(e == i);
                }
            }
            break;
        case Opcode::INT_DIV:
            {
                CHECK(command.inputs.size() == 3);
                CHECK(command.outputs.size() == 2);
                unsigned w = command.inputs[0];
                CHECK(w <= 64);
                My_Elem a = wires.at(command.inputs[1]);
                My_Elem b = wires.at(command.inputs[2]);
                uint64_t x = elem_to_uint_check(a, w, "div_N");
                uint64_t y = elem_to_uint_check(b, w, "div_N");
                CHECK(y);
                wires.at(command.outputs[0]) = x / y;
                wires.at(command.outputs[1]) = x % y;
            }
            break;
        case Opcode::FIELD_DIV:
            {
                CHECK(command.inputs.size() == 2);
                CHECK(command.outputs.size() == 1);
                My_Elem a = wires.at(command.inputs[0]);
                My_Elem b = wires.at(command.inputs[1]);
                CHECK(b);
                wires.at(command.outputs[0]) = a / b;
            }
            break;
        }
    }
    dprintf(cost_fd, "Cost: %" PRIu64 "\n", cost);
}
