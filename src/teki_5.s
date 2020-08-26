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
retq

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
retq

.global teki_add_montgomery_5
.type teki_add_montgomery_5, @function
.align 16
teki_add_montgomery_5:
movq (%rdi), %r11
addq (%rsi), %r11
movq 8(%rdi), %r11
adcq 8(%rsi), %r11
movq 16(%rdi), %r11
adcq 16(%rsi), %r11
movq 24(%rdi), %r11
adcq 24(%rsi), %r11
movq 32(%rdi), %r11
adcq 32(%rsi), %r11
movq 40(%rdi), %r11
adcq 40(%rsi), %r11
movq %r11, (%rdx)
movq 48(%rdi), %r11
adcq 48(%rsi), %r11
movq %r11, 8(%rdx)
movq 56(%rdi), %r11
adcq 56(%rsi), %r11
movq %r11, 16(%rdx)
movq 64(%rdi), %r11
adcq 64(%rsi), %r11
movq %r11, 24(%rdx)
movq 72(%rdi), %r11
adcq 72(%rsi), %r11
movq %r11, 32(%rdx)
sbbq %rax, %rax
retq

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
retq

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
retq

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
retq

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
retq

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
retq

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
movq 8(%rsi), %rcx
movq %rcx, %rax
mulq (%rdi)
addq %rax, 8(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 8(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 16(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 16(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 24(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 24(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 32(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 32(%rdi)
addq %r8, %rax
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
movq 24(%rsi), %rcx
movq %rcx, %rax
mulq (%rdi)
addq %rax, 24(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 8(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 32(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 16(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 40(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 24(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 48(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 32(%rdi)
addq %r8, %rax
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
retq

.global teki_mul_q_5
.type teki_mul_q_5, @function
.align 16
teki_mul_q_5:
movq %rdx, %r11
movq %rsi, %rax
mulq (%rdi)
movq %rax, (%r11)
movq %rdx, %r10
movq %rsi, %rax
mulq 8(%rdi)
addq %r10, %rax
adcq $0, %rdx
movq %rax, 8(%r11)
movq %rdx, %r10
movq %rsi, %rax
mulq 16(%rdi)
addq %r10, %rax
adcq $0, %rdx
movq %rax, 16(%r11)
movq %rdx, %r10
movq %rsi, %rax
mulq 24(%rdi)
addq %r10, %rax
adcq $0, %rdx
movq %rax, 24(%r11)
movq %rdx, %r10
movq %rsi, %rax
mulq 32(%rdi)
addq %r10, %rax
adcq $0, %rdx
movq %rax, 32(%r11)
movq %rdx, %rax
retq

.global teki_div_leaky_q_5
.type teki_div_leaky_q_5, @function
.align 16
teki_div_leaky_q_5:
movq %rdx, %r11
xorq %rdx, %rdx
movq 32(%rdi), %rax
divq %rsi
movq %rax, 32(%r11)
movq 24(%rdi), %rax
divq %rsi
movq %rax, 24(%r11)
movq 16(%rdi), %rax
divq %rsi
movq %rax, 16(%r11)
movq 8(%rdi), %rax
divq %rsi
movq %rax, 8(%r11)
movq (%rdi), %rax
divq %rsi
movq %rax, (%r11)
movq %rdx, %rax
retq

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
movq %rax, 32(%r11)
movq 8(%rsi), %rcx
movq %rcx, %rax
mulq (%rdi)
addq %rax, 8(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 8(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 16(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 16(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 24(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 24(%rdi)
addq %r8, %rax
addq %rax, 32(%r11)
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
addq %rax, 32(%r11)
movq 24(%rsi), %rcx
movq %rcx, %rax
mulq (%rdi)
addq %rax, 24(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 8(%rdi)
addq %r8, %rax
addq %rax, 32(%r11)
movq 32(%rsi), %rax
mulq (%rdi)
addq %rax, 32(%r11)
retq

.global teki_mul_barrett_5
.type teki_mul_barrett_5, @function
.align 16
teki_mul_barrett_5:
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
movq 8(%rsi), %rcx
movq %rcx, %rax
mulq (%rdi)
addq %rax, 8(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 8(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 16(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 16(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 24(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 24(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 32(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 32(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 40(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 40(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 48(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 48(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 56(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 56(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 64(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 64(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 72(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 72(%rdi)
addq %r8, %rax
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
movq 24(%rsi), %rcx
movq %rcx, %rax
mulq (%rdi)
addq %rax, 24(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 8(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 32(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 16(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 40(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 24(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 48(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 32(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 56(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 40(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 64(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 48(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 72(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 56(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 80(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 64(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 88(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 72(%rdi)
addq %r8, %rax
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
movq 40(%rsi), %rcx
movq %rcx, %rax
mulq (%rdi)
addq %rax, 40(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 8(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 48(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 16(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 56(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 24(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 64(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 32(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 72(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 40(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 80(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 48(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 88(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 56(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 96(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 64(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 104(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 72(%rdi)
addq %r8, %rax
adcq %r10, %rdx
addq %rax, 112(%r11)
adcq %r10, %rdx
movq %rdx, 120(%r11)
retq

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
retq

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
retq

.global teki_setzlow_5
.type teki_setzlow_5, @function
.align 16
teki_setzlow_5:
movq %rsi, (%rdi)
movq $0, 8(%rdi)
movq $0, 16(%rdi)
movq $0, 24(%rdi)
movq $0, 32(%rdi)
retq

.global teki_shr_5
.type teki_shr_5, @function
.align 16
teki_shr_5:
movq %rsi, %rcx
movq 32(%rdi), %r11
shrq %cl, %r11
movq %r11, 32(%rdx)
movq 24(%rdi), %r10
shrdq %cl, %r11, %r10
movq %r10, 24(%rdx)
movq 16(%rdi), %r11
shrdq %cl, %r10, %r11
movq %r11, 16(%rdx)
movq 8(%rdi), %r10
shrdq %cl, %r11, %r10
movq %r10, 8(%rdx)
movq (%rdi), %r11
shrdq %cl, %r10, %r11
movq %r11, (%rdx)
retq

.global teki_shl_5
.type teki_shl_5, @function
.align 16
teki_shl_5:
movq %rsi, %rcx
movq (%rdi), %r11
shlq %cl, %r11
movq %r11, (%rdx)
movq 8(%rdi), %r10
shldq %cl, %r11, %r10
movq %r10, 8(%rdx)
movq 16(%rdi), %r11
shldq %cl, %r10, %r11
movq %r11, 16(%rdx)
movq 24(%rdi), %r10
shldq %cl, %r11, %r10
movq %r10, 24(%rdx)
movq 32(%rdi), %r11
shldq %cl, %r10, %r11
movq %r11, 32(%rdx)
retq

.global teki_tabsel_5
.type teki_tabsel_5, @function
.align 16
teki_tabsel_5:
pushq %r15
subq $1, %rdx
sbbq %r11, %r11
movq (%rsi), %r9
andq %r11, %r9
movq 8(%rsi), %r8
andq %r11, %r8
movq 16(%rsi), %rcx
andq %r11, %rcx
movq 24(%rsi), %rax
andq %r11, %rax
movq 32(%rsi), %r15
andq %r11, %r15
subq $1, %rdx
sbbq %r11, %r11
movq 40(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 48(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 56(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 64(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
movq 72(%rsi), %r10
andq %r11, %r10
orq %r10, %r15
subq $1, %rdx
sbbq %r11, %r11
movq 80(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 88(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 96(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 104(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
movq 112(%rsi), %r10
andq %r11, %r10
orq %r10, %r15
subq $1, %rdx
sbbq %r11, %r11
movq 120(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 128(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 136(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 144(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
movq 152(%rsi), %r10
andq %r11, %r10
orq %r10, %r15
subq $1, %rdx
sbbq %r11, %r11
movq 160(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 168(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 176(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 184(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
movq 192(%rsi), %r10
andq %r11, %r10
orq %r10, %r15
subq $1, %rdx
sbbq %r11, %r11
movq 200(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 208(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 216(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 224(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
movq 232(%rsi), %r10
andq %r11, %r10
orq %r10, %r15
subq $1, %rdx
sbbq %r11, %r11
movq 240(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 248(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 256(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 264(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
movq 272(%rsi), %r10
andq %r11, %r10
orq %r10, %r15
subq $1, %rdx
sbbq %r11, %r11
movq 280(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 288(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 296(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 304(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
movq 312(%rsi), %r10
andq %r11, %r10
orq %r10, %r15
subq $1, %rdx
sbbq %r11, %r11
movq 320(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 328(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 336(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 344(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
movq 352(%rsi), %r10
andq %r11, %r10
orq %r10, %r15
subq $1, %rdx
sbbq %r11, %r11
movq 360(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 368(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 376(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 384(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
movq 392(%rsi), %r10
andq %r11, %r10
orq %r10, %r15
subq $1, %rdx
sbbq %r11, %r11
movq 400(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 408(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 416(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 424(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
movq 432(%rsi), %r10
andq %r11, %r10
orq %r10, %r15
subq $1, %rdx
sbbq %r11, %r11
movq 440(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 448(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 456(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 464(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
movq 472(%rsi), %r10
andq %r11, %r10
orq %r10, %r15
subq $1, %rdx
sbbq %r11, %r11
movq 480(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 488(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 496(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 504(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
movq 512(%rsi), %r10
andq %r11, %r10
orq %r10, %r15
subq $1, %rdx
sbbq %r11, %r11
movq 520(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 528(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 536(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 544(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
movq 552(%rsi), %r10
andq %r11, %r10
orq %r10, %r15
subq $1, %rdx
sbbq %r11, %r11
movq 560(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 568(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 576(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 584(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
movq 592(%rsi), %r10
andq %r11, %r10
orq %r10, %r15
subq $1, %rdx
sbbq %r11, %r11
movq 600(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 608(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 616(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 624(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
movq 632(%rsi), %r10
andq %r11, %r10
orq %r10, %r15
movq %r9, (%rdi)
movq %r8, 8(%rdi)
movq %rcx, 16(%rdi)
movq %rax, 24(%rdi)
movq %r15, 32(%rdi)
popq %r15
retq
