# Auto-generated; do not edit.

.global teki_add_5
.type teki_add_5, @function
.align 16
teki_add_5:
movq (%rsi), %r11
addq %r11, (%rdi)
movq 8(%rsi), %r11
adcq %r11, 8(%rdi)
movq 16(%rsi), %r11
adcq %r11, 16(%rdi)
movq 24(%rsi), %r11
adcq %r11, 24(%rdi)
movq 32(%rsi), %r11
adcq %r11, 32(%rdi)
sbbq %rax, %rax
ret

.global teki_sub_5
.type teki_sub_5, @function
.align 16
teki_sub_5:
movq (%rsi), %r11
subq %r11, (%rdi)
movq 8(%rsi), %r11
sbbq %r11, 8(%rdi)
movq 16(%rsi), %r11
sbbq %r11, 16(%rdi)
movq 24(%rsi), %r11
sbbq %r11, 24(%rdi)
movq 32(%rsi), %r11
sbbq %r11, 32(%rdi)
sbbq %rax, %rax
ret

.global teki_add_masked_5
.type teki_add_masked_5, @function
.align 16
teki_add_masked_5:
movq (%rsi), %r11
andq %rdx, %r11
movq 8(%rsi), %r10
andq %rdx, %r10
movq 16(%rsi), %r9
andq %rdx, %r9
movq 24(%rsi), %r8
andq %rdx, %r8
movq 32(%rsi), %rcx
andq %rdx, %rcx
addq %r11, (%rdi)
adcq %r10, 8(%rdi)
adcq %r9, 16(%rdi)
adcq %r8, 24(%rdi)
adcq %rcx, 32(%rdi)
sbbq %rax, %rax
ret

.global teki_sub_masked_5
.type teki_sub_masked_5, @function
.align 16
teki_sub_masked_5:
movq (%rsi), %r11
andq %rdx, %r11
movq 8(%rsi), %r10
andq %rdx, %r10
movq 16(%rsi), %r9
andq %rdx, %r9
movq 24(%rsi), %r8
andq %rdx, %r8
movq 32(%rsi), %rcx
andq %rdx, %rcx
subq %r11, (%rdi)
sbbq %r10, 8(%rdi)
sbbq %r9, 16(%rdi)
sbbq %r8, 24(%rdi)
sbbq %rcx, 32(%rdi)
sbbq %rax, %rax
ret

.global teki_cmplt_5
.type teki_cmplt_5, @function
.align 16
teki_cmplt_5:
movq (%rdi), %r11
subq (%rsi), %r11
movq 8(%rdi), %r11
sbbq 8(%rsi), %r11
movq 16(%rdi), %r11
sbbq 16(%rsi), %r11
movq 24(%rdi), %r11
sbbq 24(%rsi), %r11
movq 32(%rdi), %r11
sbbq 32(%rsi), %r11
sbbq %rax, %rax
ret

.global teki_cmple_5
.type teki_cmple_5, @function
.align 16
teki_cmple_5:
movq (%rsi), %r11
subq (%rdi), %r11
movq 8(%rsi), %r11
sbbq 8(%rdi), %r11
movq 16(%rsi), %r11
sbbq 16(%rdi), %r11
movq 24(%rsi), %r11
sbbq 24(%rdi), %r11
movq 32(%rsi), %r11
sbbq 32(%rdi), %r11
sbbq %rax, %rax
notq %rax
ret

.global teki_cmpeq_5
.type teki_cmpeq_5, @function
.align 16
teki_cmpeq_5:
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
movq 32(%rdi), %r11
xorq 32(%rsi), %r11
orq %r11, %rax
subq $1, %rax
sbbq %rax, %rax
ret

.global teki_mul_5
.type teki_mul_5, @function
.align 16
teki_mul_5:
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
movq %rdx, 40(%r11)
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
movq %rdx, 48(%r11)
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
movq %rdx, 56(%r11)
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
movq %rdx, 64(%r11)
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
movq %rdx, 72(%r11)
ret

.global teki_mul_lo_5
.type teki_mul_lo_5, @function
.align 16
teki_mul_lo_5:
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
movq %rdx, %rcx
movq %r9, %rax
mulq 24(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 24(%r11)
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
movq %rdx, %r8
movq %r9, %rax
mulq 16(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 16(%r11)
adcq %r10, %rdx
movq 24(%rsi), %r9
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
movq 32(%rsi), %r9
movq %r9, %rax
mulq (%rdi)
addq %rax, (%r11)
adcq %r10, %rdx
ret

.global teki_mul_10_6
.type teki_mul_10_6, @function
.align 16
teki_mul_10_6:
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
movq %rdx, %r8
movq %r9, %rax
mulq 64(%rdi)
addq %r8, %rax
adcq %r10, %rdx
movq %rax, 64(%r11)
movq %rdx, %r8
movq %r9, %rax
mulq 72(%rdi)
addq %r8, %rax
adcq %r10, %rdx
movq %rax, 72(%r11)
movq %rdx, 80(%r11)
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
movq %rdx, %rcx
movq %r9, %rax
mulq 64(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 72(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 72(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 80(%r11)
adcq %r10, %rdx
movq %rdx, 88(%r11)
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
movq %rdx, %r8
movq %r9, %rax
mulq 64(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 80(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 72(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 88(%r11)
adcq %r10, %rdx
movq %rdx, 96(%r11)
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
movq %rdx, %rcx
movq %r9, %rax
mulq 64(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 88(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 72(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 96(%r11)
adcq %r10, %rdx
movq %rdx, 104(%r11)
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
movq %rdx, %r8
movq %r9, %rax
mulq 64(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 96(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 72(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 104(%r11)
adcq %r10, %rdx
movq %rdx, 112(%r11)
movq 40(%rsi), %r9
movq %r9, %rax
mulq (%rdi)
addq %rax, 40(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 8(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 48(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 16(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 56(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 24(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 64(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 32(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 72(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 40(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 80(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 48(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 88(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 56(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 96(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 64(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 104(%r11)
adcq %r10, %rdx
movq %rdx, %rcx
movq %r9, %rax
mulq 72(%rdi)
addq %rcx, %rax
adcq %r10, %rdx
addq %rax, 112(%r11)
adcq %r10, %rdx
movq %rdx, 120(%r11)
ret

.global teki_copyfw_5
.type teki_copyfw_5, @function
.align 16
teki_copyfw_5:
movq (%rsi), %r11
movq %r11, (%rdi)
movq 8(%rsi), %r11
movq %r11, 8(%rdi)
movq 16(%rsi), %r11
movq %r11, 16(%rdi)
movq 24(%rsi), %r11
movq %r11, 24(%rdi)
movq 32(%rsi), %r11
movq %r11, 32(%rdi)
ret

.global teki_copybw_5
.type teki_copybw_5, @function
.align 16
teki_copybw_5:
movq 32(%rsi), %r11
movq %r11, 32(%rdi)
movq 24(%rsi), %r11
movq %r11, 24(%rdi)
movq 16(%rsi), %r11
movq %r11, 16(%rdi)
movq 8(%rsi), %r11
movq %r11, 8(%rdi)
movq (%rsi), %r11
movq %r11, (%rdi)
ret

.global teki_setzlow_5
.type teki_setzlow_5, @function
.align 16
teki_setzlow_5:
movq %rsi, (%rdi)
movq $0, 8(%rdi)
movq $0, 16(%rdi)
movq $0, 24(%rdi)
movq $0, 32(%rdi)
ret
