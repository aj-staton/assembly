# Written by Amell Peralta on YouTube

.data
  message1: .asciiz "The numbers are equal"
  
.text
  main:
  	addi $t0, $zero, 20
  	addi $t1, $zero, 20
  	
  	beq  $t0, $t1, equal

  	# Syscall to end program -- Needed when labels are below the end of program to let the program know to stop.
 	li $v0, 10
  	syscall
  
  
  equal:
  	# Display message.
  	li $v0, 4
  	la $a0, message1
  	syscall