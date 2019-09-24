# Written by Amell Peralta from YouTube. 

# Every MIPS program has ".data" & ".text" fields.
.data
  myMessage: .asciiz "Hello World\n"

.text
  li $v0, 4 # To print text, a value of 4 must be in register $v0. For an int, it's 1.
  la $a0, myMessage # a registers are for loading .data If this was an int, it would be 'lw'
                    # This is becuase an integer is a word, not an address.
  syscall # Do it. 
  