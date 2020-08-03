#pragma once

#include <stdint.h>

template<int W> struct Field_traits;

template<int W>
struct Field
{
    uint64_t n[W];
    uint64_t r[W + 1];
};

template<int W>
void field_add(uint64_t *a, const uint64_t *b, const Field<W> &f)
{
    Field_traits<W>::add(a, b);
    uint64_t mask = Field_traits<W>::cmple(f.n, a);
    Field_traits<W>::sub_masked(a, f.n, mask);
}

template<int W>
void field_sub(uint64_t *a, const uint64_t *b, const Field<W> &f)
{
    uint64_t mask = Field_traits<W>::sub(a, b);
    Field_traits<W>::add_masked(a, f.n, mask);
}

template<int W>
void field_mul(const uint64_t *a, const uint64_t *b, uint64_t *r, const Field<W> &f)
{
    // Barrett reduction.

    uint64_t x[W*2];
    Field_traits<W>::mul_normal(a, b, x);

    uint64_t y[W*2 + W+1];
    Field_traits<W>::mul_barrett(x, f.r, y);

    uint64_t z[W];
    Field_traits<W>::mul_lo(f.n, y + W*2, z);

    Field_traits<W>::sub(x, z);

    Field_traits<W>::copyfw(r, x);

    uint64_t mask = Field_traits<W>::cmple(f.n, r);
    Field_traits<W>::sub_masked(r, f.n, mask);
}

template<int W>
void field_inv(uint64_t *b, const Field<W> &f)
{
    uint64_t two[W] = {2};

    uint64_t elimbs[W];
    Field_traits<W>::copyfw(elimbs, f.n);
    Field_traits<W>::sub(elimbs, two);

    uint64_t r[W] = {1};

    for (int i = 0; i < W; ++i) {
        uint64_t e = elimbs[i];
        for (int j = 0; j < 64; ++j) {
            if ((e >> j) & 1) {
                field_mul(r, b, r, f);
            }
            field_mul(b, b, b, f);
        }
    }

    Field_traits<W>::copyfw(b, r);
}
