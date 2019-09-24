# Written by Amell Peralta on Youtube.

.data
  theArray: .space 12 # Want and array of three ints. 1 int is 4 bytes. 4 bytes * 3 = 12 bytes
.text
  addi $s0, $zero, 4
  addi $s1, $zero, 10
  addi $s2, $zero, 12
  
  # Offset = $t0
  
  # Store all data in theArray.
  addi $t0, $zero, 0  # Clear $t0.
  sw $s0, theArray($t0)
  
  addi $t0, $zero, 4  # Move the offset by 4 bytes, thus moving over an index.
  sw $s1, theArray($t0) # Store the value at $s1(10) into the array at its "first" index.
  
  addi $t0, $zero, 4 
  sw $s3, theArray($t0)
  
  # Retrieve data from theArray.
  lw $s4, theArray($zero)
  
  # Printing...
  li $v0, 1
  add $a0, $zero, $s4
  syscall
  