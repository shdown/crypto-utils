#pragma once

#include <stdint.h>
#include <string.h>
#include <stdio.h>

namespace fi
{

template<int W> struct Field_traits;

template<int W>
struct Field
{
    uint64_t n[W];

    uint64_t barrett_r[W + 1];

    uint64_t mont_n1[W];
    uint64_t mont_rmodn[W];
    uint64_t mont_r2modn[W];
};

template<int W>
inline void add(uint64_t *a, const uint64_t *b, const Field<W> &f)
{
    Field_traits<W>::add(a, b);
    uint64_t mask = Field_traits<W>::cmple(f.n, a);
    Field_traits<W>::sub_masked(a, f.n, mask);
}

template<int W>
inline void sub(uint64_t *a, const uint64_t *b, const Field<W> &f)
{
    uint64_t mask = Field_traits<W>::sub(a, b);
    Field_traits<W>::add_masked(a, f.n, mask);
}

template<int W>
inline void mul(const uint64_t *a, const uint64_t *b, uint64_t *r, const Field<W> &f)
{
    // Barrett reduction.

    uint64_t x[W*2];
    Field_traits<W>::mul(a, b, x);

    uint64_t y[W*2 + W+1];
    Field_traits<W>::mul_barrett(x, f.barrett_r, y);

    uint64_t z[W];
    Field_traits<W>::mul_lo(f.n, y + W*2, z);

    Field_traits<W>::sub(x, z);

    Field_traits<W>::copyfw(r, x);

    uint64_t mask = Field_traits<W>::cmple(f.n, r);
    Field_traits<W>::sub_masked(r, f.n, mask);
}

template<int W>
inline void redc(const uint64_t *t, uint64_t *r, const Field<W> &f)
{
    // Montgomery reduction.

    uint64_t m[W];
    Field_traits<W>::mul_lo(t, f.mont_n1, m);

    uint64_t mn[W*2];
    Field_traits<W>::mul(m, f.n, mn);

    Field_traits<W>::add_montgomery(t, mn, r);

    uint64_t mask = Field_traits<W>::cmple(f.n, r);
    Field_traits<W>::sub_masked(r, f.n, mask);
}

template<int W>
using TabEntry = uint64_t[W];

struct TabselPolicy_leaky
{
    template<int W>
    static inline void select(uint64_t *dst, const TabEntry<W> *tab, uint64_t segment)
    {
        ::memcpy(dst, &tab[segment], sizeof(uint64_t) * W);
    }
};

struct TabselPolicy_secure
{
    template<int W>
    static inline void select(uint64_t *dst, const TabEntry<W> *tab, uint64_t segment)
    {
        Field_traits<W>::tabsel(dst, reinterpret_cast<const uint64_t *>(tab), segment);
    }
};

template<int W, class TabselPolicy>
void montgomery_pow(
        uint64_t *b,
        const uint64_t *e, const uint64_t *e_end,
        const Field<W> &f)
{
    enum { K = 4 };
    enum { NTAB = 1 << K };

    TabEntry<W> tab[NTAB];

    uint64_t t[W*2];

    Field_traits<W>::copyfw(tab[0], f.mont_rmodn);

    for (int i = 1; i < NTAB; ++i) {
        Field_traits<W>::mul(tab[i - 1], b, t);
        redc(t, tab[i], f);
    }

    while (e_end != e) {

        uint64_t elimb = *--e_end;

        for (int i = 0; i < (64 / K); ++i) {

            for (int j = 0; j < K; ++j) {
                Field_traits<W>::sqr(b, t);
                redc(t, b, f);
            }

            uint64_t segment = elimb >> (64 - K);
            elimb <<= K;

            TabEntry<W> entry;
            TabselPolicy::select(entry, tab, segment);

            Field_traits<W>::mul(b, entry, t);
            redc(t, b, f);
        }
    }
}

template<int W>
inline void montgomery_to(uint64_t *a, const Field<W> &f)
{
    uint64_t t[W*2];
    Field_traits<W>::mul(a, f.mont_r2modn, t);
    redc(t, a, f);
}

template<int W>
inline void montgomery_from(uint64_t *a, const Field<W> &f)
{
    uint64_t t[W*2] = {};
    Field_traits<W>::copyfw(t, a);
    redc(t, a, f);
}

template<int W, class TabselPolicy>
inline void pow(
        uint64_t *b,
        const uint64_t *e, const uint64_t *e_end,
        const Field<W> &f)
{
    montgomery_to(b, f);
    montgomery_pow<W, TabselPolicy>(b, e, e_end, f);
    montgomery_from(b, f);
}

template<int W>
inline void invert(uint64_t *a, const Field<W> &f)
{
    const uint64_t two[W] = {2};

    uint64_t e[W];
    Field_traits<W>::copyfw(e, f.n);
    Field_traits<W>::sub(e, two);

    pow<W, TabselPolicy_leaky>(a, e, e + W, f);
}

} // namespace fi
