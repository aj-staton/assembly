# Written by Amell Peralt from Youtube. 
# Note : nul, mult and sll all can muliply.
.data # Puts values in RAM.

.text # For instructions. 


# MUL  *************************************************************************************************
  addi $s0, $zero, 10 # Put value 10 in @s0.
  addi $s1, $zero, 5  # 5 in $s1.
  
  # The drawback is that you can only multiply 16 bit numbers (Since MIPS only has 32-bit words).
  mul $t0, $s0, $s1   # Multiply $s0(10) and $s1(5).
  
# MULT *************************************************************************************************
  addi $s2, $zero, 2000
  addi $s3, $zero, 10
  
  mult $s2, $s3 # 2000*10 = ?? Where's the pruduct?
  # Product is stored in both the LO and HI Registers so products can be larger (64-bit).
  mflo $s4 # mflo = move from LO, so get LO's value and put it in $s4. 
  
# SLL  *************************************************************************************************
  addi $s5, $zero, 10
  
  sll $t1, $s5, 4 # Multiply $s5(10) by 2^4 = 16 


#*************************************************************************************************
  
  # Printing...
  li  $v0, 1 # li 1, tells MIPS that we are printing an int. 
  # add $a0, $zero, $t0 # Display product for 'mul'. 
  # add $a0, $zero, $s4 # Display product from 'mult'.
  add $a0, $zero, $t1  
  syscall # Run it. Note: syscall with a value of 1 in $v0 only lets you print $a0.
  