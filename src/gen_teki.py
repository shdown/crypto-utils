#!/usr/bin/env python3
import sys


SCRATCH_REG_NAMES = 'rax rdi rsi rdx rcx r8 r9 r10 r11'.split()


PARAM_REG_NAMES = 'rdi rsi rdx rcx r8 r9'.split()


ALL_REG_NAMES = SCRATCH_REG_NAMES


def resolve_reg_index(name):
    return ALL_REG_NAMES.index(name)


class Reg:
    def __init__(self, index):
        self.index = index

    def __str__(self):
        return f'%{ALL_REG_NAMES[self.index]}'


class RegStore:
    def __init__(self):
        self.free_indices = list(range(len(SCRATCH_REG_NAMES)))

    def take(self):
        # TODO this heuristic works for now, but could be made configurable
        where = -1
        return Reg(self.free_indices.pop(where))

    def untake(self, reg):
        # TODO this heuristic works for now, but could be made configurable
        where = 0
        self.free_indices.insert(where, reg.index)

    def take_by_index(self, index):
        self.free_indices.remove(index)
        return Reg(index)

    def take_by_name(self, name):
        return self.take_by_index(resolve_reg_index(name))


class PointerReg:
    def __init__(self, reg, disp=0):
        self.reg = reg
        self.disp = disp

    def __str__(self):
        if self.disp:
            return f'{self.disp * 8}({self.reg})'
        else:
            return f'({self.reg})'

    def displace(self, offset):
        return PointerReg(reg=self.reg, disp=self.disp + offset)


#------------------------------------------------------------------------------


# Returns register with last carry; you must "untake" it.
def mul_aux(RS, n, undef_from, ptrreg_src, reg_mulby, ptrreg_dst, zero):
    rax = RS.take_by_name('rax')
    rdx = RS.take_by_name('rdx')

    reg_carry = RS.take()

    for i in range(n):

        if i:
            print(f'movq {rdx}, {reg_carry}')

        print(f'movq {reg_mulby}, {rax}')
        print(f'mulq {ptrreg_src.displace(i)}')

        if i:
            print(f'addq {reg_carry}, {rax}')
            print(f'adcq {zero}, {rdx}')

        if i >= undef_from:
            print(f'movq {rax}, {ptrreg_dst.displace(i)}')
        else:
            print(f'addq {rax}, {ptrreg_dst.displace(i)}')
            print(f'adcq {zero}, {rdx}')

    RS.untake(reg_carry)
    RS.untake(rax)
    return rdx


def long_mul_step(RS, n, undef_from, ptrreg_src, reg_mulby, ptrreg_dst, zero):
    reg_last_carry = mul_aux(
        RS,
        n, undef_from,
        ptrreg_src, reg_mulby, ptrreg_dst,
        zero)

    if n >= undef_from:
        print(f'movq {reg_last_carry}, {ptrreg_dst.displace(n)}')
    else:
        print(f'addq {reg_last_carry}, {ptrreg_dst.displace(n)}')

    RS.untake(reg_last_carry)


#------------------------------------------------------------------------------


def FUNC_mul(n, m):
    RS = RegStore()
    reg_pa = RS.take_by_name('rdi') # param 1
    reg_pb = RS.take_by_name('rsi') # param 2
    reg_dst = RS.take_by_name('rdx') # param 3

    # we need to move it around because 'mul_aux' gonna need rdx.
    reg_dst_copy = RS.take()
    print(f'movq {reg_dst}, {reg_dst_copy}')
    RS.untake(reg_dst)

    ptrreg_a = PointerReg(reg_pa)
    ptrreg_b = PointerReg(reg_pb)
    ptrreg_dst = PointerReg(reg_dst_copy)

    reg_zero = RS.take()
    print(f'xorq {reg_zero}, {reg_zero}')

    reg_tmp = RS.take()

    if n < m:
        raise ValueError('expected n >= m')

    for i in range(m):
        print(f'movq {ptrreg_b.displace(i)}, {reg_tmp}')

        if i:
            undef_from = n
        else:
            undef_from = 0

        long_mul_step(
            RS,
            n, undef_from,
            ptrreg_a, reg_tmp, ptrreg_dst.displace(i),
            zero=reg_zero)

    RS.untake(reg_tmp)
    RS.untake(reg_zero)


def FUNC_mul_lo(n):
    RS = RegStore()
    reg_pa = RS.take_by_name('rdi') # param 1
    reg_pb = RS.take_by_name('rsi') # param 2
    reg_dst = RS.take_by_name('rdx') # param 3

    # we need to move it around because 'mul_aux' gonna need rdx.
    reg_dst_copy = RS.take()
    print(f'movq {reg_dst}, {reg_dst_copy}')
    RS.untake(reg_dst)

    ptrreg_a = PointerReg(reg_pa)
    ptrreg_b = PointerReg(reg_pb)
    ptrreg_dst = PointerReg(reg_dst_copy)

    reg_zero = RS.take()
    print(f'xorq {reg_zero}, {reg_zero}')

    reg_tmp = RS.take()

    for i in range(n):
        print(f'movq {ptrreg_b.displace(i)}, {reg_tmp}')

        if i:
            undef_from = n
        else:
            undef_from = 0

        taken_reg = mul_aux(
            RS,
            n - i, undef_from,
            ptrreg_a, reg_tmp, ptrreg_dst,
            zero=reg_zero)

        RS.untake(taken_reg)

    RS.untake(reg_tmp)
    RS.untake(reg_zero)


def FUNC_mul_q(n):
    RS = RegStore()
    reg_pa = RS.take_by_name('rdi') # param 1
    reg_b = RS.take_by_name('rsi') # param 2
    reg_dst = RS.take_by_name('rdx') # param 3

    # we need to move it around because 'mul_aux' gonna need rdx.
    reg_dst_copy = RS.take()
    print(f'movq {reg_dst}, {reg_dst_copy}')
    RS.untake(reg_dst)

    ptrreg_a = PointerReg(reg_pa)
    ptrreg_dst = PointerReg(reg_dst_copy)

    reg_last_carry = mul_aux(RS, n, 0, ptrreg_a, reg_b, ptrreg_dst, zero='$0')

    rax = RS.take_by_name('rax') # return value
    print(f'movq {reg_last_carry}, {rax}')


def FUNC_add(n):
    RS = RegStore()
    reg_pa = RS.take_by_name('rdi') # param 1
    reg_pb = RS.take_by_name('rsi') # param 2

    reg_tmp = RS.take()

    ptrreg_a = PointerReg(reg_pa)
    ptrreg_b = PointerReg(reg_pb)

    for i in range(n):
        print(f'movq {ptrreg_b.displace(i)}, {reg_tmp}')
        if i:
            print(f'adcq {reg_tmp}, {ptrreg_a.displace(i)}')
        else:
            print(f'addq {reg_tmp}, {ptrreg_a.displace(i)}')

    RS.untake(reg_tmp)

    rax = RS.take_by_name('rax') # return value
    print(f'sbbq {rax}, {rax}')


def FUNC_sub(n):
    RS = RegStore()
    reg_pa = RS.take_by_name('rdi') # param 1
    reg_pb = RS.take_by_name('rsi') # param 2

    reg_tmp = RS.take()

    ptrreg_a = PointerReg(reg_pa)
    ptrreg_b = PointerReg(reg_pb)

    for i in range(n):
        print(f'movq {ptrreg_b.displace(i)}, {reg_tmp}')
        if i:
            print(f'sbbq {reg_tmp}, {ptrreg_a.displace(i)}')
        else:
            print(f'subq {reg_tmp}, {ptrreg_a.displace(i)}')

    RS.untake(reg_tmp)

    rax = RS.take_by_name('rax') # return value
    print(f'sbbq {rax}, {rax}')


def FUNC_sub_masked(n):
    RS = RegStore()
    reg_pa = RS.take_by_name('rdi') # param 1
    reg_pb = RS.take_by_name('rsi') # param 2
    reg_m = RS.take_by_name('rdx') # param 3

    ptrreg_a = PointerReg(reg_pa)
    ptrreg_b = PointerReg(reg_pb)

    tmp_regs = []

    for i in range(n):
        cur_reg = RS.take()
        print(f'movq {ptrreg_b.displace(i)}, {cur_reg}')
        print(f'andq {reg_m}, {cur_reg}')
        tmp_regs.append(cur_reg)

    for i in range(n):
        if i:
            print(f'sbbq {tmp_regs[i]}, {ptrreg_a.displace(i)}')
        else:
            print(f'subq {tmp_regs[i]}, {ptrreg_a.displace(i)}')

    for reg in tmp_regs:
        RS.untake(reg)

    rax = RS.take_by_name('rax') # return value
    print(f'sbbq {rax}, {rax}')


def FUNC_add_masked(n):
    RS = RegStore()
    reg_pa = RS.take_by_name('rdi') # param 1
    reg_pb = RS.take_by_name('rsi') # param 2
    reg_m = RS.take_by_name('rdx') # param 3

    ptrreg_a = PointerReg(reg_pa)
    ptrreg_b = PointerReg(reg_pb)

    tmp_regs = []

    for i in range(n):
        cur_reg = RS.take()
        print(f'movq {ptrreg_b.displace(i)}, {cur_reg}')
        print(f'andq {reg_m}, {cur_reg}')
        tmp_regs.append(cur_reg)

    for i in range(n):
        if i:
            print(f'adcq {tmp_regs[i]}, {ptrreg_a.displace(i)}')
        else:
            print(f'addq {tmp_regs[i]}, {ptrreg_a.displace(i)}')

    for reg in tmp_regs:
        RS.untake(reg)

    rax = RS.take_by_name('rax') # return value
    print(f'sbbq {rax}, {rax}')


def FUNC_cmplt(n):
    RS = RegStore()
    reg_pa = RS.take_by_name('rdi') # param 1
    reg_pb = RS.take_by_name('rsi') # param 2

    reg_tmp = RS.take()

    ptrreg_a = PointerReg(reg_pa)
    ptrreg_b = PointerReg(reg_pb)

    for i in range(n):
        print(f'movq {ptrreg_a.displace(i)}, {reg_tmp}')
        if i:
            print(f'sbbq {ptrreg_b.displace(i)}, {reg_tmp}')
        else:
            print(f'subq {ptrreg_b.displace(i)}, {reg_tmp}')

    RS.untake(reg_tmp)

    rax = RS.take_by_name('rax') # return value
    print(f'sbbq {rax}, {rax}')


def FUNC_cmple(n):
    RS = RegStore()
    reg_pa = RS.take_by_name('rdi') # param 1
    reg_pb = RS.take_by_name('rsi') # param 2

    reg_tmp = RS.take()

    ptrreg_a = PointerReg(reg_pa)
    ptrreg_b = PointerReg(reg_pb)

    for i in range(n):
        print(f'movq {ptrreg_b.displace(i)}, {reg_tmp}')
        if i:
            print(f'sbbq {ptrreg_a.displace(i)}, {reg_tmp}')
        else:
            print(f'subq {ptrreg_a.displace(i)}, {reg_tmp}')

    RS.untake(reg_tmp)

    rax = RS.take_by_name('rax') # return value
    print(f'sbbq {rax}, {rax}')
    print(f'notq {rax}')


def FUNC_copy_generic(index_range):
    RS = RegStore()
    reg_pa = RS.take_by_name('rdi') # param 1
    reg_pb = RS.take_by_name('rsi') # param 2

    reg_tmp = RS.take()

    ptrreg_a = PointerReg(reg_pa)
    ptrreg_b = PointerReg(reg_pb)

    for i in index_range:
        print(f'movq {ptrreg_b.displace(i)}, {reg_tmp}')
        print(f'movq {reg_tmp}, {ptrreg_a.displace(i)}')

    RS.untake(reg_tmp)


def FUNC_cmpeq(n):
    RS = RegStore()
    reg_pa = RS.take_by_name('rdi') # param 1
    reg_pb = RS.take_by_name('rsi') # param 2

    rax = RS.take_by_name('rax') # return value

    reg_tmp = RS.take()

    ptrreg_a = PointerReg(reg_pa)
    ptrreg_b = PointerReg(reg_pb)

    for i in range(n):
        if i:
            print(f'movq {ptrreg_a.displace(i)}, {reg_tmp}')
            print(f'xorq {ptrreg_b.displace(i)}, {reg_tmp}')
            print(f'orq {reg_tmp}, {rax}')
        else:
            print(f'movq {ptrreg_a.displace(i)}, {rax}')
            print(f'xorq {ptrreg_b.displace(i)}, {rax}')

    RS.untake(reg_tmp)

    print(f'subq $1, {rax}')
    print(f'sbbq {rax}, {rax}')


def FUNC_setzlow(n):
    RS = RegStore()
    reg_pa = RS.take_by_name('rdi') # param 1
    reg_low = RS.take_by_name('rsi') # param 2

    ptrreg_a = PointerReg(reg_pa)

    print(f'movq {reg_low}, {ptrreg_a}')
    for i in range(1, n):
        print(f'movq $0, {ptrreg_a.displace(i)}')


#------------------------------------------------------------------------------


class GeneratedFunc:
    def __init__(self, name, proto, short_name, callback):
        # C function name
        self.name = name

        # A string of the following form: "param_list -> return_value", where:
        #  - 'param_list' is comma-delimited,
        #  - 'L' means "limb" (uint64_t),
        #  - 'L*' means pointer to limb,
        #  - '@L*' means constant pointer to limb,
        #  - 'void' means void.
        self.proto = proto

        # 'Field_traits<N>' member name
        self.short_name = short_name

        self.callback = callback


def get_generated_funcs(n):
    return [
        GeneratedFunc(
            name=f'teki_add_{n}',
            proto='L*, @L* -> L',
            short_name='add',
            callback=lambda: FUNC_add(n)),
        GeneratedFunc(
            name=f'teki_sub_{n}',
            proto='L*, @L* -> L',
            short_name='sub',
            callback=lambda: FUNC_sub(n)),
        GeneratedFunc(
            name=f'teki_add_masked_{n}',
            proto='L*, @L*, L -> L',
            short_name='add_masked',
            callback=lambda: FUNC_add_masked(n)),
        GeneratedFunc(
            name=f'teki_sub_masked_{n}',
            proto='L*, @L*, L -> L',
            short_name='sub_masked',
            callback=lambda: FUNC_sub_masked(n)),
        GeneratedFunc(
            name=f'teki_cmplt_{n}',
            proto='@L*, @L* -> L',
            short_name='cmplt',
            callback=lambda: FUNC_cmplt(n)),
        GeneratedFunc(
            name=f'teki_cmple_{n}',
            proto='@L*, @L* -> L',
            short_name='cmple',
            callback=lambda: FUNC_cmple(n)),
        GeneratedFunc(
            name=f'teki_cmpeq_{n}',
            proto='@L*, @L* -> L',
            short_name='cmpeq',
            callback=lambda: FUNC_cmpeq(n)),
        GeneratedFunc(
            name=f'teki_mul_{n}',
            proto='@L*, @L*, L* -> void',
            short_name='mul_normal',
            callback=lambda: FUNC_mul(n, n)),
        GeneratedFunc(
            name=f'teki_mul_lo_{n}',
            proto='@L*, @L*, L* -> void',
            short_name='mul_lo',
            callback=lambda: FUNC_mul_lo(n)),
        GeneratedFunc(
            name=f'teki_mul_{n*2}_{n+1}',
            proto='@L*, @L*, L* -> void',
            short_name='mul_barrett',
            callback=lambda: FUNC_mul(n * 2, n + 1)),
        GeneratedFunc(
            name=f'teki_copyfw_{n}',
            proto='L*, @L* -> void',
            short_name='copyfw',
            callback=lambda: FUNC_copy_generic(range(n))),
        GeneratedFunc(
            name=f'teki_copybw_{n}',
            proto='L*, @L* -> void',
            short_name='copybw',
            callback=lambda: FUNC_copy_generic(reversed(range(n)))),
        GeneratedFunc(
            name=f'teki_setzlow_{n}',
            proto='L*, L -> void',
            short_name='setzlow',
            callback=lambda: FUNC_setzlow(n)),
    ]


def gen_asm(n):
    print('# Auto-generated; do not edit.')
    for func in get_generated_funcs(n):
        print()
        print(f'.global {func.name}')
        print(f'.type {func.name}, @function')
        print(f'.align 16')
        print(f'{func.name}:')
        func.callback()
        print('ret')


def parse_proto(proto_str):
    proto_str = proto_str.replace(' ', '')
    param_list, retval = proto_str.split('->')
    return param_list.split(','), retval


def proto2c_type(s, bother_with_const=False):
    s = s.replace('@', ' const ' if bother_with_const else '')
    s = s.replace('L', 'uint64_t')
    return s.strip()


def gen_c_header(n):
    print('''\
// Auto-generated; do not edit.
#pragma once
#include <stdint.h>
''')

    for func in get_generated_funcs(n):
        param_list, retval = parse_proto(func.proto)

        c_param_list = ', '.join(proto2c_type(x) for x in param_list)
        c_retval = proto2c_type(retval)

        print(f'extern {c_retval} {func.name}({c_param_list});')


def gen_cxx_header(n):
    print('''\
// Auto-generated; do not edit.
#pragma once
#include <stdint.h>
#include "field.hpp"
''')

    print('extern "C" {')
    print(f'#include "teki_{n}.h"')
    print('}')

    print(f'template<> struct Field_traits<{n}>')
    print('{')

    for func in get_generated_funcs(n):
        param_list, retval = parse_proto(func.proto)

        c_retval = proto2c_type(retval)

        cxx_param_list = []
        cxx_callarg_list = []
        for i, x in enumerate(param_list):
            cxx_param_list.append(f'{proto2c_type(x, bother_with_const=True)} a{i}')
            if '@' in x:
                cxx_callarg_list.append(f'const_cast<{proto2c_type(x)}>(a{i})')
            else:
                cxx_callarg_list.append(f'a{i}')

        print(f' static inline {c_retval} {func.short_name}({", ".join(cxx_param_list)})')
        print(' {')
        print(f'  return {func.name}({", ".join(cxx_callarg_list)});')
        print(' }')

    print('}')


def print_usage_and_exit(msg=None):

    if msg is not None:
        print(msg, file=sys.stderr)

    print(f'''
USAGE: {sys.argv[0]} <ACTION> <WIDTH>

Valid <ACTION>s:
 * gen_asm: print assembly to stdout
 * gen_c_header: print C header to stdout
 * gen_cxx_header: print C++ header to stdout
''', file=sys.stderr)

    exit(2)


def main():
    if len(sys.argv) != 3:
        print_usage_and_exit(msg='Expected exactly two arguments.')
    action = sys.argv[1]
    try:
        n = int(sys.argv[2])
    except ValueError:
        print_usage_and_exit(msg='Invalid width.')

    if action == 'gen_asm':
        gen_asm(n)
    elif action == 'gen_c_header':
        gen_c_header(n)
    elif action == 'gen_cxx_header':
        gen_cxx_header(n)
    else:
        print_usage_and_exit(msg='Invalid action.')


if __name__ == '__main__':
    main()
