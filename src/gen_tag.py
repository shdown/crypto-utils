#!/usr/bin/env python3
import sys


def limb_to_cvalue(x):
    return f'UINT64_C({x})'


def n_to_limbs(n):
    MASK_64 = (1 << 64) - 1

    r = []
    while n:
        r.append(n & MASK_64)
        n >>= 64
    return r


def print_clist(limbs):
    print(' {')
    for x in limbs:
        print(f'  {limb_to_cvalue(x)},')
    print(' },')


def egcd(a, b):
    s = 0
    old_s = 1
    r = b
    old_r = a

    while r:
        q = old_r // r
        old_r, r = r, old_r - q * r
        old_s, s = s, old_s - q * s

    if b:
        bz_t = (old_r - old_s * a) // b
    else:
        bz_t = 0

    return old_s, bz_t


def canonical_mod(a, b):
    a %= b
    if a < 0:
        a += b
    return a


def gen_field_struct(p):
    p_limbs = n_to_limbs(p)
    width_bits = 64 * len(p_limbs)

    print(f'// width: {len(p_limbs)} limbs')
    print('{')

    print_clist(p_limbs)

    barrett_r = (1 << (width_bits * 2)) // p
    print_clist(n_to_limbs(barrett_r))

    neg_mont_n1, _ = egcd(p, 1 << width_bits)
    mont_n1 = canonical_mod(-neg_mont_n1, 1 << width_bits)

    print('//', mont_n1)

    print_clist(n_to_limbs(mont_n1))

    mont_rmodn = (1 << (width_bits)) % p
    print_clist(n_to_limbs(mont_rmodn))

    mont_r2modn = (1 << (width_bits * 2)) % p
    print_clist(n_to_limbs(mont_r2modn))

    print('}')


def print_usage_and_exit(msg=None):
    if msg is not None:
        print(msg, file=sys.stderr)
    print(f'USAGE: {sys.argv[0]} <prime modulo>', file=sys.stderr)
    exit(2)


def main():
    if len(sys.argv) != 2:
        print_usage_and_exit(msg='Expected exactly one argument.')

    try:
        p = int(sys.argv[1])
    except ValueError:
        print_usage_and_exit(msg='Invalid prime modulo.')

    gen_field_struct(p)


if __name__ == '__main__':
    main()
