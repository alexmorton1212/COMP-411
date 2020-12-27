#---------------------------------
# Lab 6: Pixel Conversion
#
# Name: Alex Morton
#
# --------------------------------

.data 0x0
  startString:  .asciiz "Converting pixels to grayscale:\n"
  finishString: .asciiz "Finished.\n"
  newline:      .asciiz "\n"
  pixels:       .word   0x00010000, 0x010101, 0x6,      0x3333,
                        0x030c,     0x700853, 0x294999, -1
                        
.text 0x3000

main:

  addi	$v0, $0, 4       	# system call code 4 for printing a string
  la	$a0, startString      	# put address of startString in $a0
  syscall               	# print the string
  
  add   $t1,$0,$0     		# i in $t1 = 0


while:

  sll   $t2, $t1, 2
  lw    $t0, pixels($t2)   	# load pixels[i]
  
  beq   $t0, -1, exit		# if pixels[i] = -1, exit
  
  andi	$a2, $t0, 0x000000FF	# stores blue in a2
  srl	$t0, $t0, 8		# shifts pixel value right 8
  andi	$a1, $t0, 0x000000FF 	# stores green in a1
  srl	$t0, $t0, 8		# shifts pixel value right 8
  andi	$a0, $t0, 0x000000FF	# stores red in a0
  
  jal	rgb_to_gray		# calculates grey value and sets it to v0
  
  add  $a0, $0, $v0		# put value to be printed in $a0
  addi $v0, $0, 1  		# put 1 in $v0 to indicate which syscall			
  syscall          		# and then execute "syscall"		
  
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, newline 		# address of newline string is in $a0
  syscall			# print the newline
  
  addi 	$t1, $t1, 1		# i++
  j while			# loops back to while


exit:

  addi $v0, $0, 4            	# system call code 4 for printing a string
  la   $a0, finishString   	# put address of finishString in $a0
  syscall               	# print the string

  addi $v0, $0, 10      	# system call code 10 for exit
  syscall               	# exit the program


rgb_to_gray:            	# procedure to calculate gray = (red + green + blue) / 
	                        # red is in $a0, green is in $a1, blue is in $a2
                          	# gray should be computed in $v0 (return value)
                                              
  add	$v0, $a0, $a1		# adds red and green and puts in v0
  add	$v0, $v0, $a2		# adds blue to v0
  div	$v0, $v0, 3		# divides v0 by 3 to give grey
  jr $ra			# return to main
 
