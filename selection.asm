# Written by Austin Staton
# Used in Intro. to Computer Architecture (CSCE 212) at the UofSC
# Translation of (from C):
#  if (a < 20) {
#	val = (val & 0xFFFF) * 16;
#  } else {
#       val = (val >> 16) + 10;
#  }

.data
	a: 	.word 19
	val:	.word 10
.text
	lw  $t0, a
	bgt $t0, 20, else	# If a < 20, go to the else statement. 
	lw  $s0, val		# Get val from memory.
	and $s0, $s0, 0xFFFF	# AND val and 0xFFFF (111...1111) = val
	mul $s0, $s0, 16	# $s0 = val*16
	sw  $s0, val
return:
	#***Print to Check - Ignore for solution***
	li   $v0, 1
	lw   $s2, val
	add  $a0, $zero, $s2
	syscall
	#******************************************
	
	li   $v0, 10 		# End program call.
	syscall
	
else:	lw   $s0, val	      	
	srl  $s0, $s0, 16	# Shift right 16 bits "val >> 16"
	addi $s0, $s0, 10
	sw   $s0, val
	j return
	
	
	
	
