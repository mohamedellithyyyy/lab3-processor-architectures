.text
    .org 0x100
_start:
    addi s0fp, zero, 1024          / addi s1, zero, 1024            / lw t0, 128(zero) /
    addi s3, zero, 31              / addi t1, zero, -1              /                  / blt t0, zero, negative_n
                                   /                                /                  / beqz t0, done

loop:
                                   /                                / lw a0, 128(zero) /
                                   /                                / lw a1, 128(zero) /
    addi t0, t0, -1                /                                / lw a2, 128(zero) /
    mul t1, a1, a2                 / mulh t2, a1, a2                / lw a3, 128(zero) /
    mul t3, a0, a3                 / mulh t4, a0, a3                /                  /
    sub t5, t3, t1                 / sub t6, t4, t2                 /                  / bleu t1, t3, no_borrow
    addi t6, t6, -1                / sra s2, t5, s3                 /                  / j check
no_borrow:
                                   / sra s2, t5, s3                 /                  /
check:
    addi s0fp, s0fp, 4             /                                / sw t5, 0(s0fp)   / bne t6, s2, overflow
                                   /                                /                  / bnez t0, loop

out_loop:
    addi s1, s1, 4                 /                                / lw t1, 0(s1)     /
                                   /                                / sw t1, 132(zero) / bne s1, s0fp, out_loop
done:
                                   /                                /                  / halt

overflow:
    lui t1, 0xCCCCD                /                                /                  /
    addi t1, t1, -820              /                                /                  /
                                   /                                / sw t1, 132(zero) / halt

negative_n:
                                   /                                / sw t1, 132(zero) / halt