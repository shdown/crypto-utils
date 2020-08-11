#!/usr/bin/env python3
import sys
from typing import List, Union, Optional


class RegList:
    def __init__(self, names: List[str]):
        self._names = names

    def name_by_index(self, index: int) -> str:
        return self._names[index]

    def index_by_name(self, name: str) -> int:
        return self._names.index(name)

    def names(self) -> List[str]:
        return self._names

    def __len__(self) -> int:
        return len(self._names)


SCRATCH_REGS = RegList('rax rdi rsi rdx rcx r8 r9 r10 r11'.split())


CALLEE_SAVED_REGS = RegList('rbx r12 r13 r14 r15'.split())


ALL_REGS = RegList(SCRATCH_REGS.names() + CALLEE_SAVED_REGS.names())


# First 6 function args are passed in: rdi rsi rdx rcx r8 r9


class Reg:
    def __init__(self, index: int):
        self.index = index

    def __str__(self):
        return f'%{ALL_REGS.name_by_index(self.index)}'


class NoVacantReg(BaseException):
    pass


class RegStore:
    def __init__(self, reg_list: RegList=SCRATCH_REGS):
        self.free_indices = [ALL_REGS.index_by_name(name) for name in reg_list.names()]

    def take(self) -> Reg:
        # TODO this heuristic works for now, but could be made configurable
        where = -1
        try:
            return Reg(self.free_indices.pop(where))
        except IndexError:
            raise NoVacantReg()

    def untake(self, reg: Reg) -> None:
        # TODO this heuristic works for now, but could be made configurable
        where = 0
        self.free_indices.insert(where, reg.index)

    def take_by_index(self, index: int) -> Reg:
        self.free_indices.remove(index)
        return Reg(index)

    def take_by_name(self, name: str) -> Reg:
        return self.take_by_index(ALL_REGS.index_by_name(name))


class PointerReg:
    def __init__(self, reg: Reg, offset: int=0):
        self.reg = reg
        self.offset = offset

    def __str__(self):
        if self.offset:
            return f'{self.offset * 8}({self.reg})'
        else:
            return f'({self.reg})'

    def displace(self, offset: int):
        return PointerReg(reg=self.reg, offset=self.offset + offset)


#------------------------------------------------------------------------------


# Multiply 'src[0]...src[n]' by 'mulby', writing/adding result to 'dst[0]...dst[n]'.
#
# If 'i >= undef_from', then the value of 'dst[i]' is assumed to be "undefined" (but implicitly
# contain the value of zero), otherwise 'dst[i]' is added to.
#
# 'zero' must be either a register with value of zero, or constant "$0".
#
# If 'drop_last_carry' is False (default), returns register with last carry; you must "untake" it.
# Otherwise, returns None.
def mul_aux(
        RS: RegStore,
        n: int,
        undef_from: int,
        src: PointerReg,
        mulby: Union[Reg, PointerReg],
        dst: PointerReg,
        zero: Union[Reg, str],
        drop_last_carry: bool=False) -> Optional[Reg]:

    rax = RS.take_by_name('rax')
    rdx = RS.take_by_name('rdx')

    reg_carry = RS.take()

    for i in range(n):
        drop_following_carry = drop_last_carry and (i + 1 == n)

        if i:
            print(f'movq {rdx}, {reg_carry}')

        print(f'movq {mulby}, {rax}')
        print(f'mulq {src.displace(i)}')

        if i:
            print(f'addq {reg_carry}, {rax}')
            if not drop_following_carry:
                print(f'adcq {zero}, {rdx}')

        if i >= undef_from:
            print(f'movq {rax}, {dst.displace(i)}')
        else:
            print(f'addq {rax}, {dst.displace(i)}')
            if not drop_following_carry:
                print(f'adcq {zero}, {rdx}')

    RS.untake(reg_carry)
    RS.untake(rax)
    if drop_last_carry:
        RS.untake(rdx)
        return None
    else:
        return rdx


def mul_aux_auto(
        RS: RegStore,
        n: int,
        undef_from: int,
        src: PointerReg,
        b: PointerReg,
        dst: PointerReg,
        zero: Union[Reg, str],
        drop_last_carry: bool=False) -> Optional[Reg]:

    if n == 1:
        return mul_aux(RS, n, undef_from, src, b, dst, zero, drop_last_carry)
    else:
        reg_mulby = RS.take()
        print(f'movq {b}, {reg_mulby}')
        result = mul_aux(RS, n, undef_from, src, reg_mulby, dst, zero, drop_last_carry)
        RS.untake(reg_mulby)
        return result


# Multiply 'src[0]...src[n]' by 'b[0]', writing/adding result to 'dst[0]...dst[n+1]'.
#
# If 'i >= undef_from', then the value of 'dst[i]' is assumed to be "undefined" (but implicitly
# contain the value of zero), otherwise 'dst[i]' is added to.
def long_mul_step(
        RS: RegStore,
        n: int,
        undef_from: int,
        src: PointerReg,
        b: PointerReg,
        dst: PointerReg,
        zero: Union[Reg, str]) -> None:

    reg_last_carry = mul_aux_auto(
        RS,
        n, undef_from,
        src, b, dst,
        zero)

    if n >= undef_from:
        print(f'movq {reg_last_carry}, {dst.displace(n)}')
    else:
        print(f'addq {reg_last_carry}, {dst.displace(n)}')

    RS.untake(reg_last_carry)


def move_around(RS: RegStore, x: Reg) -> Reg:
    x_copy = RS.take()
    print(f'movq {x}, {x_copy}')
    RS.untake(x)
    return x_copy


#------------------------------------------------------------------------------


def FUNC_mul(n: int, m: int) -> None:
    if n < m:
        raise ValueError('expected n >= m')

    RS = RegStore()
    reg_a = RS.take_by_name('rdi') # param 1
    reg_b = RS.take_by_name('rsi') # param 2
    reg_dst = RS.take_by_name('rdx') # param 3

    # we need to move it around because 'mul_aux' gonna need rdx.
    reg_dst = move_around(RS, reg_dst)

    a = PointerReg(reg_a)
    b = PointerReg(reg_b)
    dst = PointerReg(reg_dst)

    reg_zero = RS.take()
    print(f'xorq {reg_zero}, {reg_zero}')

    for i in range(m):
        if i:
            undef_from = n
        else:
            undef_from = 0

        long_mul_step(
            RS,
            n, undef_from,
            a, b.displace(i), dst.displace(i),
            zero=reg_zero)

    RS.untake(reg_zero)


def FUNC_mul_lo(n: int) -> None:
    RS = RegStore()
    reg_a = RS.take_by_name('rdi') # param 1
    reg_b = RS.take_by_name('rsi') # param 2
    reg_dst = RS.take_by_name('rdx') # param 3

    # we need to move it around because 'mul_aux' gonna need rdx.
    reg_dst = move_around(RS, reg_dst)

    a = PointerReg(reg_a)
    b = PointerReg(reg_b)
    dst = PointerReg(reg_dst)

    reg_zero = RS.take()
    print(f'xorq {reg_zero}, {reg_zero}')

    for i in range(n):
        if i:
            undef_from = n
        else:
            undef_from = 0

        mul_aux_auto(
            RS,
            n - i, undef_from,
            a, b.displace(i), dst.displace(i),
            zero=reg_zero,
            drop_last_carry=True)

    RS.untake(reg_zero)


def FUNC_mul_q(n: int) -> None:
    RS = RegStore()
    reg_src = RS.take_by_name('rdi') # param 1
    reg_m = RS.take_by_name('rsi') # param 2
    reg_dst = RS.take_by_name('rdx') # param 3

    # we need to move it around because 'mul_aux' gonna need rdx.
    reg_dst = move_around(RS, reg_dst)

    src = PointerReg(reg_src)
    dst = PointerReg(reg_dst)

    reg_last_carry = mul_aux(
        RS,
        n, 0,
        src, reg_m, dst,
        zero='$0')

    rax = RS.take_by_name('rax') # return value
    print(f'movq {reg_last_carry}, {rax}')


def FUNC_div_leaky_q(n: int) -> None:
    RS = RegStore()
    reg_a = RS.take_by_name('rdi') # param 1
    reg_m = RS.take_by_name('rsi') # param 2
    reg_dst = RS.take_by_name('rdx') # param 3

    # we need to move it around because we gonna need rdx.
    reg_dst = move_around(RS, reg_dst)

    a = PointerReg(reg_a)
    dst = PointerReg(reg_dst)

    rax = RS.take_by_name('rax')
    rdx = RS.take_by_name('rdx')

    print(f'xorq {rdx}, {rdx}')

    for i in reversed(range(n)):
        print(f'movq {a.displace(i)}, {rax}')
        print(f'divq {reg_m}')
        print(f'movq {rax}, {dst.displace(i)}')

    print(f'movq {rdx}, {rax}')


class AORS_ADD:
    ADDSUB = 'add'
    ADCSBB = 'adc'


class AORS_SUB:
    ADDSUB = 'sub'
    ADCSBB = 'sbb'


def FUNC_aors(n, aors):
    RS = RegStore()
    reg_a = RS.take_by_name('rdi') # param 1
    reg_b = RS.take_by_name('rsi') # param 2

    reg_tmp = RS.take()

    a = PointerReg(reg_a)
    b = PointerReg(reg_b)

    for i in range(n):
        print(f'movq {b.displace(i)}, {reg_tmp}')
        if i:
            print(f'{aors.ADCSBB}q {reg_tmp}, {a.displace(i)}')
        else:
            print(f'{aors.ADDSUB}q {reg_tmp}, {a.displace(i)}')

    RS.untake(reg_tmp)

    rax = RS.take_by_name('rax') # return value
    print(f'sbbq {rax}, {rax}')


def FUNC_aors_montgomery(n, aors):
    RS = RegStore()
    reg_a = RS.take_by_name('rdi') # param 1
    reg_b = RS.take_by_name('rsi') # param 2
    reg_dst = RS.take_by_name('rdx') # param 3

    reg_tmp = RS.take()

    a = PointerReg(reg_a)
    b = PointerReg(reg_b)
    dst = PointerReg(reg_dst)

    for i in range(n):
        print(f'movq {a.displace(i)}, {reg_tmp}')
        if i:
            print(f'{aors.ADCSBB}q {b.displace(i)}, {reg_tmp}')
        else:
            print(f'{aors.ADDSUB}q {b.displace(i)}, {reg_tmp}')

    for i in range(n, 2*n):
        print(f'movq {a.displace(i)}, {reg_tmp}')
        print(f'{aors.ADCSBB}q {b.displace(i)}, {reg_tmp}')
        print(f'movq {reg_tmp}, {dst.displace(i - n)}')

    RS.untake(reg_tmp)

    rax = RS.take_by_name('rax') # return value
    print(f'sbbq {rax}, {rax}')


def FUNC_aors_masked(n, aors):
    RS = RegStore()
    reg_a = RS.take_by_name('rdi') # param 1
    reg_b = RS.take_by_name('rsi') # param 2
    reg_m = RS.take_by_name('rdx') # param 3

    a = PointerReg(reg_a)
    b = PointerReg(reg_b)

    tmp_regs = []

    for i in range(n):
        cur_reg = RS.take()
        print(f'movq {b.displace(i)}, {cur_reg}')
        print(f'andq {reg_m}, {cur_reg}')
        tmp_regs.append(cur_reg)

    for i in range(n):
        if i:
            print(f'{aors.ADCSBB}q {tmp_regs[i]}, {a.displace(i)}')
        else:
            print(f'{aors.ADDSUB}q {tmp_regs[i]}, {a.displace(i)}')

    for reg in tmp_regs:
        RS.untake(reg)

    rax = RS.take_by_name('rax') # return value
    print(f'sbbq {rax}, {rax}')


def FUNC_cmplt(n):
    RS = RegStore()
    reg_a = RS.take_by_name('rdi') # param 1
    reg_b = RS.take_by_name('rsi') # param 2

    reg_tmp = RS.take()

    a = PointerReg(reg_a)
    b = PointerReg(reg_b)

    for i in range(n):
        print(f'movq {a.displace(i)}, {reg_tmp}')
        if i:
            print(f'sbbq {b.displace(i)}, {reg_tmp}')
        else:
            print(f'subq {b.displace(i)}, {reg_tmp}')

    RS.untake(reg_tmp)

    rax = RS.take_by_name('rax') # return value
    print(f'sbbq {rax}, {rax}')


def FUNC_cmple(n):
    RS = RegStore()
    reg_a = RS.take_by_name('rdi') # param 1
    reg_b = RS.take_by_name('rsi') # param 2

    reg_tmp = RS.take()

    a = PointerReg(reg_a)
    b = PointerReg(reg_b)

    for i in range(n):
        print(f'movq {b.displace(i)}, {reg_tmp}')
        if i:
            print(f'sbbq {a.displace(i)}, {reg_tmp}')
        else:
            print(f'subq {a.displace(i)}, {reg_tmp}')

    RS.untake(reg_tmp)

    rax = RS.take_by_name('rax') # return value
    print(f'sbbq {rax}, {rax}')
    print(f'notq {rax}')


def FUNC_copy_generic(index_range):
    RS = RegStore()
    reg_a = RS.take_by_name('rdi') # param 1
    reg_b = RS.take_by_name('rsi') # param 2

    reg_tmp = RS.take()

    a = PointerReg(reg_a)
    b = PointerReg(reg_b)

    for i in index_range:
        print(f'movq {b.displace(i)}, {reg_tmp}')
        print(f'movq {reg_tmp}, {a.displace(i)}')

    RS.untake(reg_tmp)


def FUNC_cmpeq(n):
    RS = RegStore()
    reg_a = RS.take_by_name('rdi') # param 1
    reg_b = RS.take_by_name('rsi') # param 2

    rax = RS.take_by_name('rax') # return value

    reg_tmp = RS.take()

    a = PointerReg(reg_a)
    b = PointerReg(reg_b)

    for i in range(n):
        if i:
            print(f'movq {a.displace(i)}, {reg_tmp}')
            print(f'xorq {b.displace(i)}, {reg_tmp}')
            print(f'orq {reg_tmp}, {rax}')
        else:
            print(f'movq {a.displace(i)}, {rax}')
            print(f'xorq {b.displace(i)}, {rax}')

    RS.untake(reg_tmp)

    print(f'subq $1, {rax}')
    print(f'sbbq {rax}, {rax}')


def FUNC_setzlow(n):
    RS = RegStore()
    reg_a = RS.take_by_name('rdi') # param 1
    reg_low = RS.take_by_name('rsi') # param 2

    a = PointerReg(reg_a)

    print(f'movq {reg_low}, {a}')
    for i in range(1, n):
        print(f'movq $0, {a.displace(i)}')


def FUNC_tabsel(n, k):
    RS = RegStore()
    RS_2 = RegStore(reg_list=CALLEE_SAVED_REGS)

    reg_dst = RS.take_by_name('rdi') # param 1
    reg_tab = RS.take_by_name('rsi') # param 2
    reg_idx = RS.take_by_name('rdx') # param 3

    dst = PointerReg(reg_dst)
    tab = PointerReg(reg_tab)

    reg_mask = RS.take()
    reg_tmp = RS.take()

    regs_result = []
    pushed_regs = []

    for j in range(n):
        try:
            reg = RS.take()
        except NoVacantReg:
            reg = RS_2.take()
            print(f'pushq {reg}')
            pushed_regs.append(reg)

        regs_result.append(reg)

    ntab = 1 << k
    for i in range(ntab):
        print(f'subq $1, {reg_idx}')
        print(f'sbbq {reg_mask}, {reg_mask}')

        for j in range(n):
            if i:
                print(f'movq {tab.displace(i*n+j)}, {reg_tmp}')
                print(f'andq {reg_mask}, {reg_tmp}')
                print(f'orq {reg_tmp}, {regs_result[j]}')
            else:
                print(f'movq {tab.displace(i*n+j)}, {regs_result[j]}')
                print(f'andq {reg_mask}, {regs_result[j]}')

    for j in range(n):
        print(f'movq {regs_result[j]}, {dst.displace(j)}')

    for reg in reversed(pushed_regs):
        print(f'popq {reg}')


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
            callback=lambda: FUNC_aors(n, AORS_ADD)),
        GeneratedFunc(
            name=f'teki_sub_{n}',
            proto='L*, @L* -> L',
            short_name='sub',
            callback=lambda: FUNC_aors(n, AORS_SUB)),
        GeneratedFunc(
            name=f'teki_add_montgomery_{n}',
            proto='@L*, @L*, L* -> L',
            short_name='add_montgomery',
            callback=lambda: FUNC_aors_montgomery(n, AORS_ADD)),
        GeneratedFunc(
            name=f'teki_add_masked_{n}',
            proto='L*, @L*, L -> L',
            short_name='add_masked',
            callback=lambda: FUNC_aors_masked(n, AORS_ADD)),
        GeneratedFunc(
            name=f'teki_sub_masked_{n}',
            proto='L*, @L*, L -> L',
            short_name='sub_masked',
            callback=lambda: FUNC_aors_masked(n, AORS_SUB)),
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
            short_name='mul',
            callback=lambda: FUNC_mul(n, n)),
        GeneratedFunc(
            name=f'teki_mul_q_{n}',
            proto='@L*, L, L* -> L',
            short_name='mul_q',
            callback=lambda: FUNC_mul_q(n)),
        GeneratedFunc(
            name=f'teki_div_leaky_q_{n}',
            proto='@L*, L, L* -> L',
            short_name='div_leaky_q',
            callback=lambda: FUNC_div_leaky_q(n)),
        GeneratedFunc(
            name=f'teki_mul_lo_{n}',
            proto='@L*, @L*, L* -> void',
            short_name='mul_lo',
            callback=lambda: FUNC_mul_lo(n)),
        GeneratedFunc(
            name=f'teki_mul_barrett_{n}',
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
        GeneratedFunc(
            name=f'teki_tabsel_{n}',
            proto='L*, @L*, L -> void',
            short_name='tabsel',
            callback=lambda: FUNC_tabsel(n, k=4)),
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
        print('retq')


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

    print('namespace fi')
    print('{')
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

    print(' static inline void sqr(const uint64_t *a, uint64_t *b) { return mul(a, a, b); }')

    print('};')
    print('} // namespace fi')


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
