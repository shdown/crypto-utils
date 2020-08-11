# Auto-generated; do not edit.

.global teki_add_3
.type teki_add_3, @function
.align 16
teki_add_3:
movq (%rsi), %r11
addq %r11, (%rdi)
movq 8(%rsi), %r11
adcq %r11, 8(%rdi)
movq 16(%rsi), %r11
adcq %r11, 16(%rdi)
sbbq %rax, %rax
retq

.global teki_sub_3
.type teki_sub_3, @function
.align 16
teki_sub_3:
movq (%rsi), %r11
subq %r11, (%rdi)
movq 8(%rsi), %r11
sbbq %r11, 8(%rdi)
movq 16(%rsi), %r11
sbbq %r11, 16(%rdi)
sbbq %rax, %rax
retq

.global teki_add_montgomery_3
.type teki_add_montgomery_3, @function
.align 16
teki_add_montgomery_3:
movq (%rdi), %r11
addq (%rsi), %r11
movq 8(%rdi), %r11
adcq 8(%rsi), %r11
movq 16(%rdi), %r11
adcq 16(%rsi), %r11
movq 24(%rdi), %r11
adcq 24(%rsi), %r11
movq %r11, (%rdx)
movq 32(%rdi), %r11
adcq 32(%rsi), %r11
movq %r11, 8(%rdx)
movq 40(%rdi), %r11
adcq 40(%rsi), %r11
movq %r11, 16(%rdx)
sbbq %rax, %rax
retq

.global teki_add_masked_3
.type teki_add_masked_3, @function
.align 16
teki_add_masked_3:
movq (%rsi), %r11
andq %rdx, %r11
movq 8(%rsi), %r10
andq %rdx, %r10
movq 16(%rsi), %r9
andq %rdx, %r9
addq %r11, (%rdi)
adcq %r10, 8(%rdi)
adcq %r9, 16(%rdi)
sbbq %rax, %rax
retq

.global teki_sub_masked_3
.type teki_sub_masked_3, @function
.align 16
teki_sub_masked_3:
movq (%rsi), %r11
andq %rdx, %r11
movq 8(%rsi), %r10
andq %rdx, %r10
movq 16(%rsi), %r9
andq %rdx, %r9
subq %r11, (%rdi)
sbbq %r10, 8(%rdi)
sbbq %r9, 16(%rdi)
sbbq %rax, %rax
retq

.global teki_cmplt_3
.type teki_cmplt_3, @function
.align 16
teki_cmplt_3:
movq (%rdi), %r11
subq (%rsi), %r11
movq 8(%rdi), %r11
sbbq 8(%rsi), %r11
movq 16(%rdi), %r11
sbbq 16(%rsi), %r11
sbbq %rax, %rax
retq

.global teki_cmple_3
.type teki_cmple_3, @function
.align 16
teki_cmple_3:
movq (%rsi), %r11
subq (%rdi), %r11
movq 8(%rsi), %r11
sbbq 8(%rdi), %r11
movq 16(%rsi), %r11
sbbq 16(%rdi), %r11
sbbq %rax, %rax
notq %rax
retq

.global teki_cmpeq_3
.type teki_cmpeq_3, @function
.align 16
teki_cmpeq_3:
movq (%rdi), %rax
xorq (%rsi), %rax
movq 8(%rdi), %r11
xorq 8(%rsi), %r11
orq %r11, %rax
movq 16(%rdi), %r11
xorq 16(%rsi), %r11
orq %r11, %rax
subq $1, %rax
sbbq %rax, %rax
retq

.global teki_mul_3
.type teki_mul_3, @function
.align 16
teki_mul_3:
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
movq %rdx, 24(%r11)
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
movq %rdx, 32(%r11)
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
movq %rdx, 40(%r11)
retq

.global teki_mul_q_3
.type teki_mul_q_3, @function
.align 16
teki_mul_q_3:
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
movq %rdx, %rax
retq

.global teki_div_leaky_q_3
.type teki_div_leaky_q_3, @function
.align 16
teki_div_leaky_q_3:
movq %rdx, %r11
xorq %rdx, %rdx
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

.global teki_mul_lo_3
.type teki_mul_lo_3, @function
.align 16
teki_mul_lo_3:
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
movq %rax, 16(%r11)
movq 8(%rsi), %rcx
movq %rcx, %rax
mulq (%rdi)
addq %rax, 8(%r11)
adcq %r10, %rdx
movq %rdx, %r8
movq %rcx, %rax
mulq 8(%rdi)
addq %r8, %rax
addq %rax, 16(%r11)
movq 16(%rsi), %rax
mulq (%rdi)
addq %rax, 16(%r11)
retq

.global teki_mul_barrett_3
.type teki_mul_barrett_3, @function
.align 16
teki_mul_barrett_3:
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
movq %rdx, 48(%r11)
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
movq %rdx, 56(%r11)
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
movq %rdx, 64(%r11)
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
movq %rdx, 72(%r11)
retq

.global teki_copyfw_3
.type teki_copyfw_3, @function
.align 16
teki_copyfw_3:
movq (%rsi), %r11
movq %r11, (%rdi)
movq 8(%rsi), %r11
movq %r11, 8(%rdi)
movq 16(%rsi), %r11
movq %r11, 16(%rdi)
retq

.global teki_copybw_3
.type teki_copybw_3, @function
.align 16
teki_copybw_3:
movq 16(%rsi), %r11
movq %r11, 16(%rdi)
movq 8(%rsi), %r11
movq %r11, 8(%rdi)
movq (%rsi), %r11
movq %r11, (%rdi)
retq

.global teki_setzlow_3
.type teki_setzlow_3, @function
.align 16
teki_setzlow_3:
movq %rsi, (%rdi)
movq $0, 8(%rdi)
movq $0, 16(%rdi)
retq

.global teki_tabsel_3
.type teki_tabsel_3, @function
.align 16
teki_tabsel_3:
subq $1, %rdx
sbbq %r11, %r11
movq (%rsi), %r9
andq %r11, %r9
movq 8(%rsi), %r8
andq %r11, %r8
movq 16(%rsi), %rcx
andq %r11, %rcx
subq $1, %rdx
sbbq %r11, %r11
movq 24(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 32(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 40(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
subq $1, %rdx
sbbq %r11, %r11
movq 48(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 56(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 64(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
subq $1, %rdx
sbbq %r11, %r11
movq 72(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 80(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 88(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
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
subq $1, %rdx
sbbq %r11, %r11
movq 144(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 152(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 160(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
subq $1, %rdx
sbbq %r11, %r11
movq 168(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 176(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 184(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
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
subq $1, %rdx
sbbq %r11, %r11
movq 216(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 224(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 232(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
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
subq $1, %rdx
sbbq %r11, %r11
movq 264(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 272(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 280(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
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
subq $1, %rdx
sbbq %r11, %r11
movq 312(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 320(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 328(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
subq $1, %rdx
sbbq %r11, %r11
movq 336(%rsi), %r10
andq %r11, %r10
orq %r10, %r9
movq 344(%rsi), %r10
andq %r11, %r10
orq %r10, %r8
movq 352(%rsi), %r10
andq %r11, %r10
orq %r10, %rcx
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
movq %r9, (%rdi)
movq %r8, 8(%rdi)
movq %rcx, 16(%rdi)
retq
