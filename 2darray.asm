# Written by Amell Peralta on Youtube

.data
	array:   .word 2, 5 # Row1: Column 1, Column 2   (2x2 array)
		 .word 3, 7
	size:	 .word 2    # Two columns, two rows, so we only need a number 2.
	.eqv DATASIZE 4 # This is a constant representing an int size.
.text
	main:
	    la $a0, array # Load the base address of the 2darray, Parameter 1 for SumDiagonal
	    lw $a1, size    # Load the size of the array, Paramter 2 for SumDiagonal
	    jal SumDiagonal # This function will sum 5 + 3 and 2 + 7
	    move $a0, $v0   # The returned value from SumDiagonal (in $v0) will be copied to $a0 so we can print it.
	    li $v0, 1 
	    syscall
	    
	    # End Program
	    li $v0, 10
	    syscall
	SumDiagonal:
	    li $v0, 0 # Clear $v0, wich will return the sum.
	    li $t0, 0 # Clear $t0, which will be used as an index counter
	    
	    sumLoop:
	        # This Chunk is calculating the offset with the offset = base + sizeof(int)*(N+....
	    	mul $t1, $t1, $a1       # By multiplying index by number of columns, $t1 will get a value of offset.
	    	add  $t1, $t1, $t0
	    	mul $t1, $t1, DATASIZE
	    	add  $t1, $t1, $a0       # Adds the base address 
	    	
	    	lw   $t2, 0($t1)
	    	add  $v0, $v0, $t2       # sum = sum + 2darray[i][i]
	    	
	    	addi $t0, $t0, 1         # i++
	    	blt  $t0, $a1, sumLoop   # if i < size, then loop ends
	    jr $ra
	    
	    