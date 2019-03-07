# Written by Austin Staton for CSCE 212 (Intro. to Computer Architecture) at the UofSC
# Date: 03/04/2019
#   Minor framework given by Dr. Yonghong Yan
#   References used from Missouri State University
# 
# This a source array and convolutes it using the filter array to produce the dest array, which is the convoluted product.
# Works similary to 2d image coonvolution.
.data
	space:	.asciiz " "
	source:	.word	0:256	#16x16
	dest:	.word	0:256
	size:   .word   16        # Both source and destination arrays are 16x16 (a.k.a M, N)
		
	filter:	.word	-1, 0, 1, -2, 0, 2, -1, 0, 1
	fsize : .word   3         # Size of filter array
		
	.eqv INTSIZE 4    	  # Declare a constant for the size on an integer (bytes).
	
		
				
.text 
 	main:
        	lw	$s0, size 	# $s0 = number of rows
        	lw	$s1, size	# $s1 = number of columns
        	
		move    $t0, $zero     	# $t0 = row counter a.k.a. 'i'
      	 	move    $t1, $zero    	# $t1 = column counter a.k.a. 'j'
      	 	 	
	# ******************We first need to assign values to the 'source' array to give numbers to convolute.*******************
	# Remember:offset = sizeof(int) * (row*#cols+col)
	loop1: # ---Body----- 
      	   	mult	$s0, $t1	# $s2 = row * #ofColumns
      	   	mflo	$s2		# get product from LO
      	   	add	$s2, $s2, $t1	# (row*#cols) + col
      	   	mul	$s2, $s2, INTSIZE # offset
      	   	add	$t2, $t0, $t1	# i + j
      	   	sw	$t2, source($s2)# store i+j in source
      	   	# li	$v0, 1
      	   	# add	$a0, $zero, $t2
      	   	# syscall
      	   	# -----End Body------
      	   	addi 	$t1, $t1, 1
      	   	blt	$t1, $s1, loop1 # Is j < M? If yes, loop back.
      	   	move 	$t1, $zero	# reset column counter
      	   	addi	$t0, $t0, 1	# increment row counter
      	   	blt	$t0, $s0, loop1	# Is i < N? If yes, loop back.      	   	 
	# ********END PART 1*******************************************************************************************************
      		
      		
      		
      		addi	$t0, $zero, 1	# i = 1
      		addi	$t1, $zero, 1	# j = 1
      		addi	$s0, $s0, -1 	# M - 1
      		addi	$s1, $s1, -1	# N - 1      		
 	 loop2: # **********************Outer Nested Loop Body************************************* 
 	 	addi	$t2, $zero, 0	# fi = 0 - row counter
      		addi	$t3, $zero, 0	# fj = 0 - column counter
      		lw	$s2, fsize 	# $s2 = 3 for row condition
      		lw	$s3, fsize	# $s3 = 3 for column condition   
      		
      		move	$t4, $zero 	# $t4 = temp = 0
 	 loop2b:# ****************Inner Nested Loop Body**************************
 	 
 	 	# source offset
 	 	add	$t5, $t0, $t2	
 	 	sub 	$t5, $t5, 1	# This is the "row" value for source.
 	 	add	$t6, $t1, $t3
 	 	sub	$t6, $t6, 1	# This is the "column" value for source.
 	 	lw 	$t7, size	# STORES 16
 	 	mult	$t5, $t7	# row * # columns
 	 	mflo	$s4
 		add	$s4, $s4, $t6
 		sll	$s4, $s4, 4	
 		lw	$s4, source($s4)# $s4 contains the value at source	
 		
 	 	# filter offset 
 	 	mult	$t2, $s3
 	 	mflo	$s5
 	 	add	$s5, $s5, $t3
 	 	sll	$s5, $s5, 4
 	 	lw	$s5, filter($s5)# $s5 contains the needed value at filter
 	 	
 	 	mult 	$s4, $s5
 	 	mflo	$s4		# $s4 is not needed to store now. 
 	 	add	$t4, $t4, $s4	# temp += product
 	 	
 	 	#******************End Inner Nested Loop Body*********************
 	 	
 	 	addi 	$t3, $t3, 1	 # fj ++
      	   	blt	$t3, $s3, loop2b # Is fj < 3? If yes, loop back.
      	   	move 	$t3, $zero	 # fj = 0 => reset column counter
      	   	addi	$t2, $t2, 1	 # fi++ => increment row counter
      	   	blt	$t2, $s2, loop2b # Is i < N-1? If yes, loop back. 
      	   	
      	   	# dest[i][j] = temp, so need dest offset to save what is in $t4
 	 	mult	$t0, $t7	# row * # columns
 	 	mflo	$s5
 	 	add	$s5, $s5, $t1 	# product * column counter
 	 	sll	$s5, $s5, 2	# shift for TOTAL OFFSET
 	 	sw	$t4, dest($s5)
 	 	#
 		#************************ End Outer Nested Loop Body *****************************
 	 	addi 	$t1, $t1, 1	# j++
      	   	blt	$t1, $s1, loop2 # Is j < M-1? If yes, loop back.
      	   	move 	$t1, $zero	# j = 0 => reset column counter
      	   	addi	$t0, $t0, 1	# i++ => increment row counter
      	   	blt	$t0, $s0, loop2	# Is i < N-1? If yes, loop back.   
      	   	
      	   	# Print Setup
      	   	la	$a0, dest	# Arg for print - the array.
      	   	add	$a1, $zero, 256	# Arg for print - the array size. 
		jal 	print
 	 	
 	 	#End
 	 	li	$v0, 10
 	 	syscall
 	
 	print:	
 		add	$t0, $zero, $a0	# starting address of array of data to be printed.
 		add	$t1, $zero, $a1	# loop counter to array size
 		
 	out:	lw	$a0, 0($t0)	# load integer to print
 		li	$v0, 1		# Integer print sys code.
 		syscall
 		
 		la	$a0, space
 		li	$v0, 4		# ASCII sys code.
 		syscall
 		
 		addi	$t0, $t0, 4	# Increment the arrays addr.
 		addi	$t1, $t1, -1	# Decrease loop counter.
 		bgtz	$t1, out	# Keep going...
 		
 		jr	$ra		#return
 		
 	
 	
 	
 	
 	
 	
 	
