.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    li t1, 1 # Initialize result to 1
factorial_loop:
    beq a0, x0, factorial_end # Check for base case: if n is 0 return 1
    mul t1, t1, a0
    # Multiply the result (t1) by n (a0)
    addi a0, a0, -1
    # Decrement n
    j factorial_loop
    # Jump back to the loop start
factorial_end:
    mv a0, t1 # Move the final result (t1) to a0 before returning
    jr ra