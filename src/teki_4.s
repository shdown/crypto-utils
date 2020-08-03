# Auto-generated; do not edit.

.global teki_add_4
.type teki_add_4, @function
.align 16
teki_add_4:
movq (%rsi), %r11
addq %r11, (%rdi)
movq 8(%rsi), %r11
adcq %r11, 8(%rdi)
movq 16(%rsi), %r11
adcq %r11, 16(%rdi)
movq 24(%rsi), %r11
adcq %r11, 24(%rdi)
sbbq %rax, %rax
ret

.global teki_sub_4
.type teki_sub_4, @function
.align 16
teki_sub_4:
movq (%rsi), %r11
subq %r11, (%rdi)
movq 8(%rsi), %r11
sbbq %r11, 8(%rdi)
movq 16(%rsi), %r11
sbbq %r11, 16(%rdi)
movq 24(%rsi), %r11
sbbq %r11, 24(%rdi)
sbbq %rax, %rax
ret

.global teki_add_masked_4
.type teki_add_masked_4, @function
.align 16
teki_add_masked_4:
movq (%rsi), %r11
andq %rdx, %r11
movq 8(%rsi), %r10
andq %rdx, %r10
movq 16(%rsi), %r9
andq %rdx, %r9
movq 24(%rsi), %r8
andq %rdx, %r8
addq %r11, (%rdi)
adcq %r10, 8(%rdi)
adcq %r9, 16(%rdi)
adcq %r8, 24(%rdi)
sbbq %rax, %rax
ret

.global teki_sub_masked_4
.type teki_sub_masked_4, @function
.align 16
teki_sub_masked_4:
movq (%rsi), %r11
andq %rdx, %r11
movq 8(%rsi), %r10
andq %rdx, %r10
movq 16(%rsi), %r9
andq %rdx, %r9
movq 24(%rsi), %r8
andq %rdx, %r8
subq %r11, (%rdi)
sbbq %r10, 8(%rdi)
sbbq %r9, 16(%rdi)
sbbq %r8, 24(%rdi)
sbbq %rax, %rax
ret

.global teki_cmplt_4
.type teki_cmplt_4, @function
.align 16
teki_cmplt_4:
movq (%rdi), %r11
subq (%rsi), %r11
movq 8(%rdi), %r11
sbbq 8(%rsi), %r11
movq 16(%rdi), %r11
sbbq 16(%rsi), %r11
movq 24(%rdi), %r11
sbbq 24(%rsi), %r11
sbbq %rax, %rax
ret

.global teki_cmple_4
.type teki_cmple_4, @function
.align 16
teki_cmple_4:
movq (%rsi), %r11
subq (%rdi), %r11
movq 8(%rsi), %r11
sbbq 8(%rdi), %r11
movq 16(%rsi), %r11
sbbq 16(%rdi), %r11
movq 24(%rsi), %r11
sbbq 24(%rdi), %r11
sbbq %rax, %rax
notq %rax
ret

.global teki_cmpeq_4
.type teki_cmpeq_4, @function
.align 16
teki_cmpeq_4:
movq (%rdi), %rax
xorq (%rsi), %rax
movq 8(%rdi), %r11
xorq 8(%rsi), %r11
orq %r11, %rax
movq 16(%rdi), %r11
xorq 16(%rsi), %r11
orq %r11, %rax
movq 24(%rdi), %r11
xorq 24(%rsi), %r11
orq %r11, %rax
subq $1, %rax
sbbq %rax, %rax
ret

.global teki_mul_4
.type teki_mul_4, @function
.align 16
teki_mul_4:
movq %rdx, %r11
xorq %r10, %r10
movq (%rsi), %r9
movq %r9, %rax
mulq (%rdi)
movq %rax, (%r11)
movq %rdx, %r8
movq %r9, %rax
mulq 8(%rdi)
addq %r8, %rax
adcq %r10, %rdx
movq %rax, 8(%r11)
movq %rdx, %r8
movq %r9, %rax
mulq 16(%rdi)
addq %r8, %rax
adcq %r10, %rdx
movq %rax, 16(%r11)
movq %rdx, %r8
movq %r9, %rax
mulq 24(%rdi)
addq %r8, %rax
adcq %r10, %rdx
movq %rax, 24(%r11)
movq %rdx, 32(%r11)
movq 8(%rsi), %r9
movq %r9, %rax
mulq (%rdi)
addq %rax, 8(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 8(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 16(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 16(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 24(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 24(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 32(%r11)
adcq %r10, %rdx
movq %rdx, 40(%r11)
movq 16(%rsi), %r9
movq %r9, %rax
mulq (%rdi)
addq %rax, 16(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 8(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 24(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 16(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 32(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 24(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 40(%r11)
adcq %r10, %rdx
movq %rdx, 48(%r11)
movq 24(%rsi), %r9
movq %r9, %rax
mulq (%rdi)
addq %rax, 24(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 8(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 32(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 16(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 40(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 24(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 48(%r11)
adcq %r10, %rdx
movq %rdx, 56(%r11)
ret

.global teki_mul_lo_4
.type teki_mul_lo_4, @function
.align 16
teki_mul_lo_4:
movq %rdx, %r11
xorq %r10, %r10
movq (%rsi), %r9
movq %r9, %rax
mulq (%rdi)
movq %rax, (%r11)
movq %rdx, %r8
movq %r9, %rax
mulq 8(%rdi)
addq %r8, %rax
adcq %r10, %rdx
movq %rax, 8(%r11)
movq %rdx, %r8
movq %r9, %rax
mulq 16(%rdi)
addq %r8, %rax
adcq %r10, %rdx
movq %rax, 16(%r11)
movq %rdx, %r8
movq %r9, %rax
mulq 24(%rdi)
addq %r8, %rax
adcq %r10, %rdx
movq %rax, 24(%r11)
movq 8(%rsi), %r9
movq %r9, %rax
mulq (%rdi)
addq %rax, (%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 8(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 8(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 16(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 16(%r11)
adcq %r10, %rdx
movq 16(%rsi), %r9
movq %r9, %rax
mulq (%rdi)
addq %rax, (%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 8(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 8(%r11)
adcq %r10, %rdx
movq 24(%rsi), %r9
movq %r9, %rax
mulq (%rdi)
addq %rax, (%r11)
adcq %r10, %rdx
ret

.global teki_mul_8_5
.type teki_mul_8_5, @function
.align 16
teki_mul_8_5:
movq %rdx, %r11
xorq %r10, %r10
movq (%rsi), %r9
movq %r9, %rax
mulq (%rdi)
movq %rax, (%r11)
movq %rdx, %r8
movq %r9, %rax
mulq 8(%rdi)
addq %r8, %rax
adcq %r10, %rdx
movq %rax, 8(%r11)
movq %rdx, %r8
movq %r9, %rax
mulq 16(%rdi)
addq %r8, %rax
adcq %r10, %rdx
movq %rax, 16(%r11)
movq %rdx, %r8
movq %r9, %rax
mulq 24(%rdi)
addq %r8, %rax
adcq %r10, %rdx
movq %rax, 24(%r11)
movq %rdx, %r8
movq %r9, %rax
mulq 32(%rdi)
addq %r8, %rax
adcq %r10, %rdx
movq %rax, 32(%r11)
movq %rdx, %r8
movq %r9, %rax
mulq 40(%rdi)
addq %r8, %rax
adcq %r10, %rdx
movq %rax, 40(%r11)
movq %rdx, %r8
movq %r9, %rax
mulq 48(%rdi)
addq %r8, %rax
adcq %r10, %rdx
movq %rax, 48(%r11)
movq %rdx, %r8
movq %r9, %rax
mulq 56(%rdi)
addq %r8, %rax
adcq %r10, %rdx
movq %rax, 56(%r11)
movq %rdx, 64(%r11)
movq 8(%rsi), %r9
movq %r9, %rax
mulq (%rdi)
addq %rax, 8(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 8(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 16(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 16(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 24(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 24(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 32(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 32(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 40(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 40(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 48(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 48(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 56(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 56(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 64(%r11)
adcq %r10, %rdx
movq %rdx, 72(%r11)
movq 16(%rsi), %r9
movq %r9, %rax
mulq (%rdi)
addq %rax, 16(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 8(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 24(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 16(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 32(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 24(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 40(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 32(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 48(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 40(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 56(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 48(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 64(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 56(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 72(%r11)
adcq %r10, %rdx
movq %rdx, 80(%r11)
movq 24(%rsi), %r9
movq %r9, %rax
mulq (%rdi)
addq %rax, 24(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 8(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 32(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 16(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 40(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 24(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 48(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 32(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 56(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 40(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 64(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 48(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 72(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 56(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 80(%r11)
adcq %r10, %rdx
movq %rdx, 88(%r11)
movq 32(%rsi), %r9
movq %r9, %rax
mulq (%rdi)
addq %rax, 32(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 8(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 40(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 16(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 48(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 24(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 56(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 32(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 64(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 40(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 72(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 48(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 80(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 56(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 88(%r11)
adcq %r10, %rdx
movq %rdx, 96(%r11)
ret

.global teki_copyfw_4
.type teki_copyfw_4, @function
.align 16
teki_copyfw_4:
movq (%rsi), %r11
movq %r11, (%rdi)
movq 8(%rsi), %r11
movq %r11, 8(%rdi)
movq 16(%rsi), %r11
movq %r11, 16(%rdi)
movq 24(%rsi), %r11
movq %r11, 24(%rdi)
ret

.global teki_copybw_4
.type teki_copybw_4, @function
.align 16
teki_copybw_4:
movq 24(%rsi), %r11
movq %r11, 24(%rdi)
movq 16(%rsi), %r11
movq %r11, 16(%rdi)
movq 8(%rsi), %r11
movq %r11, 8(%rdi)
movq (%rsi), %r11
movq %r11, (%rdi)
ret

.global teki_setzlow_4
.type teki_setzlow_4, @function
.align 16
teki_setzlow_4:
movq %rsi, (%rdi)
movq $0, 8(%rdi)
movq $0, 16(%rdi)
movq $0, 24(%rdi)
ret
