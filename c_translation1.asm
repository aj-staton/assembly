# Written by Austin Staton
# For use in Intro. to Computer Architechure (CSCE 212) at the UofSC.
# This is the C equivalent to the assembly below:
#   if (a < b) {
#     c=1;
#   } else if (a == b) {
#     c=2;
#   } else {
#     c=3;
#   }
# Written by Austin Staton
# For use in CSCE 212 HW3 Question 4
.data
	a: .word 1
	b: .word 2
	c: .word 0
.text
	main:	
		lw 	$t0, a	
		lw	$t1, b
		bgt 	$t0, $t1, else
		beq	$t0, $t1, elseif
		lw	$t2, c
		addi	$t2, $zero, 1
		sw	$t2, c
		j	exitif
	elseif:
		lw	$t2, c
		addi	$t2, $zero, 2
		sw	$t2, c
		j	exitif
	else:
		lw	$t2, c
		addi	$t2, $zero, 3
		sw	$t2, c
	exitif:
		# Print to check for accuracy...
		lw	$t3, c
		li	$v0, 1
		add	$a0, $zero, $t3
		syscall
		
		
	
	
	
	





