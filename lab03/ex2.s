.globl main

.data
source:             #int source[] = {3, 1, 4, 1, 5, 9, 0};
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest:               #int dest[10];
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
fun:
    addi t0, a0, 1   #t0 = a0 + 1  ----> t0 = x+1
    sub t1, x0, a0   #t1 = 0 - a0  ----> t1 = -x
    mul a0, t0, t1   #a0 = t0 * t1 ----> -x * (x+1)
    jr ra

main:
    # BEGIN PROLOGUE
    addi sp, sp, -20
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw ra, 16(sp)
    # END PROLOGUE
    addi t0, x0, 0   # t0 = 0 -----> initialized counter k to zero
    addi s0, x0, 0   # s0 = 0 -----> initialized sum to zero 
    la s1, source    # base adress of array source is stored in s1
    la s2, dest      # base adress of array dest is stored in s2
loop:
    slli s3, t0, 2   # s3 = t0 << 2 -----> s3 = 4*k
    add t1, s1, s3   # t1 = s1 + s3 -----> t1 = source + k 
    lw t2, 0(t1)     # t2 = source[k]
    beq t2, x0, exit # if (source[k] == 0) exit the loop 
    add a0, x0, t2   # a0 = source[k]
    addi sp, sp, -8
    sw t0, 0(sp)
    sw t2, 4(sp)
    jal fun
    lw t0, 0(sp)
    lw t2, 4(sp)
    addi sp, sp, 8  
    add t2, x0, a0  #a0 is value returned from fun -----> fun(source[k]) t2 = fun(source[k])
    add t3, s2, s3  # t3 = s2 + s3 -----> base adress of dest array plus k ---->t3 = dest+k 
    sw t2, 0(t3)    # t3 = t2  -------> dest[k] = fun(source[k]) 
    add s0, s0, t2  # sum = sum + dest[k]
    addi t0, t0, 1  # k = k + 1
    jal x0, loop
exit:
    add a0, x0, s0
    # BEGIN EPILOGUE
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20
    # END EPILOGUE
    jr ra
