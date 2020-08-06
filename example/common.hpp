#pragma once

#include <exception>
#include <string>
#include <string.h>
#include <stddef.h>

class UnexpectedInput : public std::exception
{
    std::string what_;
public:
    UnexpectedInput(const std::string &found, const std::string &expected)
        : what_("Found: '")
    {
        what_.append(found).append("', expected: ").append(expected);
    }

    explicit UnexpectedInput(const std::string &msg) : what_(msg) {}

    const char *what() const noexcept override { return what_.c_str(); }
};

static inline bool is_ws(char c)
{
    return c == ' ' || c == '\t';
}

static inline bool is_printable(unsigned char c)
{
    return c > 32;
}

static inline bool maybe_slurp(char *&s, const char *prefix, bool only_with_ws = false)
{
    const size_t nprefix = strlen(prefix);

    for (size_t i = 0; i < nprefix; ++i)
        if (s[i] != prefix[i])
            return false;

    s += nprefix;
    if (only_with_ws) {
        if (!is_ws(*s)) {
            s -= nprefix;
            return false;
        }
        do {
            ++s;
        } while (is_ws(*s));
    }
    return true;
}

static inline void slurp(char *&s, const char *prefix)
{
    if (!maybe_slurp(s, prefix))
        throw UnexpectedInput(/*found=*/s, /*expected=*/prefix);
}

static inline unsigned parse_digit(char c)
{
    if ('0' <= c && c <= '9')
        return c - '0';
    if ('a' <= c && c <= 'z')
        return c - 'a' + 10;
    if ('A' <= c && c <= 'Z')
        return c - 'A' + 10;
    return 255;
}

template<class T>
static inline void slurp_uint(char *&s, T &out, unsigned base)
{
    out = 0;
    bool got_digits = false;
    for (; ; ++s, got_digits = true) {
        const unsigned digit = parse_digit(*s);
        if (digit >= base)
            break;
        out *= base;
        out += digit;
    }
    if (!got_digits)
        throw UnexpectedInput(/*found=*/s, /*expected=*/"(digit)");
}

static inline void slurp_any_ws(char *&s)
{
    while (is_ws(*s))
        ++s;
}

static inline void slurp_any_printable(char *&s)
{
    while (is_printable(*s))
        ++s;
}

static inline void slurp_some_ws(char *&s)
{
    if (!is_ws(*s))
        throw UnexpectedInput(/*found=*/s, /*expected=*/"(whitespace)");
    do {
        ++s;
    } while (is_ws(*s));
}

template<class T>
static inline void parse_uint_until_nul(char *s, T &out, unsigned base)
{
    slurp_uint(s, out, base);
    if (*s != '\0')
        throw UnexpectedInput(/*found=*/s, /*expected=*/"(end of string)");
}
