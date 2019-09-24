# Written by Amell Peralta from YouTube
# ERRORS from ME
.data
  prompt: .asciiz "Enter a number to compute it's factorial: \n"
  result: .asciiz "\nThe factorial of the number is:"
  number: .word   0
  answer: .word   0 # The zeros, just decalre values.
  
.text
  .globl main
  main:
  	# Get number from user.
  	li $v0, 4
  	la $a0, prompt
  	syscall
  	
  	li $v0, 5 # This is the syscall code to be able to take in an integer. The taken value will be in %$v0.
  	syscall
  	
  	# Store the taken value into .data.
  	sw $v0, number
  	
  	
  	# Call factorial function.
  	lw $a0, number
  	jal Factorial # 'jal' is commonly used for function calls.
  	
  	# Store the returned value into the answer variable from .data.
  	sw $v0, answer # By convention, the $v* registers are for return values from functions.
  	
  	# Give user the answer.
  	li $v0, 4
  	la $a0, result
  	syscall
  	li $v0, 1
  	la $a0, answer
  	syscall
  	
  	# Signal End of program
  	li $v0, 10
  	syscall
  
 # factorial function
.globl Factorial
Factorial:
	subu $sp, $sp, 8 # Declares space in stack for return and local variable (8 bytes, 2 ints).
	sw $ra, ($sp) # Stores return variables to stack.
	sw $s0, 4($sp) # Stores locall variable to stack.
	
	# Base Case:
	li $v0, 1
	beq $a0, 0, done
	# Recursion
	move $s0, $a0 # Copies value of $a0 to $s0
	sub $a0, $a0, 1
	jal Factorial
	
	mul $v0, $a0, $v0
	
done:
	lw $ra, ($sp)
	lw $s0, 4($sp)
	addu $sp, $sp, 8 # Reallocate stack memory - Memory Management.
	jr $ra
  
