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
retq

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
retq

.global teki_add_montgomery_4
.type teki_add_montgomery_4, @function
.align 16
teki_add_montgomery_4:
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
movq %r11, (%rdx)
movq 40(%rdi), %r11
adcq 40(%rsi), %r11
movq %r11, 8(%rdx)
movq 48(%rdi), %r11
adcq 48(%rsi), %r11
movq %r11, 16(%rdx)
movq 56(%rdi), %r11
adcq 56(%rsi), %r11
movq %r11, 24(%rdx)
sbbq %rax, %rax
retq

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
retq

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
retq

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
retq

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
retq

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
retq

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
movq %rdx, 56(%r11)
retq

.global teki_mul_q_4
.type teki_mul_q_4, @function
.align 16
teki_mul_q_4:
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
movq %rdx, %rax
retq

.global teki_div_leaky_q_4
.type teki_div_leaky_q_4, @function
.align 16
teki_div_leaky_q_4:
movq %rdx, %r11
xorq %rdx, %rdx
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
movq %rax, 24(%r11)
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
addq %rax, 24(%r11)
movq 16(%rsi), %r9
movq %r9, %rax
mulq (%rdi)
addq %rax, 16(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %r9, %rax
mulq 8(%rdi)
addq %r8, %rax
addq %rax, 24(%r11)
movq 24(%rsi), %rax
mulq (%rdi)
addq %rax, 24(%r11)
retq

.global teki_mul_barrett_4
.type teki_mul_barrett_4, @function
.align 16
teki_mul_barrett_4:
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
retq

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
retq

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
retq

.global teki_setzlow_4
.type teki_setzlow_4, @function
.align 16
teki_setzlow_4:
movq %rsi, (%rdi)
movq $0, 8(%rdi)
movq $0, 16(%rdi)
movq $0, 24(%rdi)
retq

.global teki_shr_4
.type teki_shr_4, @function
.align 16
teki_shr_4:
movq %rsi, %rcx
movq 24(%rdi), %r11
shrq %r11
movq %r11, 24(%rdx)
movq 16(%rdi), %r10
shrdq %r11, %r10
movq %r10, 16(%rdx)
movq 8(%rdi), %r11
shrdq %r10, %r11
movq %r11, 8(%rdx)
movq (%rdi), %r10
shrdq %r11, %r10
movq %r10, (%rdx)
retq

.global teki_shl_4
.type teki_shl_4, @function
.align 16
teki_shl_4:
movq %rsi, %rcx
movq (%rdi), %r11
shlq %r11
movq %r11, (%rdx)
movq 8(%rdi), %r10
shldq %r11, %r10
movq %r10, 8(%rdx)
movq 16(%rdi), %r11
shldq %r10, %r11
movq %r11, 16(%rdx)
movq 24(%rdi), %r10
shldq %r11, %r10
movq %r10, 24(%rdx)
retq

.global teki_tabsel_4
.type teki_tabsel_4, @function
.align 16
teki_tabsel_4:
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
subq $1, %rdx
sbbq %r11, %r11
movq 32(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 40(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 48(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 56(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
subq $1, %rdx
sbbq %r11, %r11
movq 64(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 72(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 80(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 88(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
subq $1, %rdx
sbbq %r11, %r11
movq 96(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 104(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 112(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 120(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
subq $1, %rdx
sbbq %r11, %r11
movq 128(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 136(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 144(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 152(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
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
subq $1, %rdx
sbbq %r11, %r11
movq 192(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 200(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 208(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 216(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
subq $1, %rdx
sbbq %r11, %r11
movq 224(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 232(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 240(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 248(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
subq $1, %rdx
sbbq %r11, %r11
movq 256(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 264(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 272(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 280(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
subq $1, %rdx
sbbq %r11, %r11
movq 288(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 296(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 304(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 312(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
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
subq $1, %rdx
sbbq %r11, %r11
movq 352(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 360(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 368(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 376(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
subq $1, %rdx
sbbq %r11, %r11
movq 384(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 392(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 400(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 408(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
subq $1, %rdx
sbbq %r11, %r11
movq 416(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 424(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 432(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 440(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
subq $1, %rdx
sbbq %r11, %r11
movq 448(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 456(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 464(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
movq 472(%rsi), %r10
andq %r11, %r10
orq %r10, %rax
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
movq %r9, (%rdi)
movq %r8, 8(%rdi)
movq %rcx, 16(%rdi)
movq %rax, 24(%rdi)
retq
