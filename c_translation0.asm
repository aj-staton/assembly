# Written by Austin Staton
# Used in Intro. to Computer Architecture (CSCE 212) at the UofSC.
# HW3 Question 3
#
# Translation of (from C):
#  if (a < 20) {
#	val = (val & 0xFFFF) * 16;
#  } else {
#       val = (val >> 16) + 10;
#  }

.data
	a: 	.word 21
	val:	.word 0x00FF
.text
	# *************Psuedocode solution defined within here******************************
	lw  $t0, a
	bgt $t0, 20, else	# If a < 20, go to the else statement. 
	lw  $s0, val		# Get val from memory.
	andi $s0, $s0, 0xFFFF	# AND val and 0xFFFF (111...1111) = val
	mul $s0, $s0, 16	# $s0 = val*16
	sw  $s0, val
	j   exitif
	
else:	lw   $s1, val	      	
	srl  $s1, $s1, 16	# shift right 16 bits
	addi $s1, $s1, 10
	sw   $s1, val
	
exitif:
	# *************Psuedocode solution defined within here******************************
	#***Print to Check - Ignore for solution***
	# li   $v0, 1
	# lw   $s1, val
	# add  $a0, $zero, $s1
	# syscall
	#******************************************
	
	li   $v0, 10 		# End program call.
	syscall
	
	
	
	
