.import lotsofaccumulators.s

.data
#inputarray: .word 1,2,3,4,5,6,7,0
inputarray: .word 0,1,0,1,0,1,0       #for test 5

TestPassed: .asciiz "Test Passed!\n"
TestFailed: .asciiz "Test Failed!\n"

.text
# Tests if the given implementation of accumulate is correct.
#Input: a0 contains a pointer to the version of accumulate in question. See lotsofaccumulators.s for more details
#
#
#
#The main function currently runs a simple test that checks if accumulator works on the given input array. All versions of accumulate should pass this.
#Modify the test so that you can catch the bugs in four of the five solutions!
main:
    la a0 inputarray
    addi s0, x0, 3 	#for test 1
    li t0 28
    li t1 3
    li t2 5		#for test 4
    li t3 0
			
    addi sp sp -16	#for test 2
    sw t0 0(sp)
    sw t3 4(sp)
    sw t2 8(sp)
    sw t1 12(sp)
  
    jal accumulatorone
    
  
    lw t1 12(sp)
    lw t2 8(sp)
    lw t3 4(sp)
    lw t0 0(sp)
    addi sp sp 16
    
    li t4, 5
    li t5, 0
    bne t2, t4, Fail  # If t2 is not equal to 5, branch to Fail
    bne t3, t5, Fail  # If t3 is not equal to 0, branch to Fail
    
    bne s0 t1 Fail	#for test 1
    beq a0 t5 Pass
    
     
Fail:
    la a0 TestFailed
    jal print_string
    j End
Pass:
    la a0 TestPassed
    jal print_string
End:
    jal exit

print_int:
	mv a1 a0
    li a0 1
    ecall
    jr ra
    
print_string:
	mv a1 a0
    li a0 4
    ecall
    jr ra
    
exit:
    li a0 10
    ecall
