.data

newLine: 	.asciiz "\n"
string1:      	.space	10000
string2:	.space  10000

.text	0x3000

main:

				# Loads string into string1
  li 		$v0, 8 			# take in input
  la 		$a0, string1 		# load byte space into address
  li 		$a1, 100 		# allot the byte space for string (100 characters)
  syscall

  la 		$a0, string1            # Load address of string1
  jal   	getLength          	# get length of string1  (will be in $t0)
  
  add		$t2, $0, $t0            # $t2 = String1 length            	                        	
                     
  li 		$v0, 1			#prints String1 length
  move 		$a0, $t2
  syscall

  j		exit

getLength:

  add 		$t0, $0, $0 			# $t0 = i: i = 0
	
	lengthLoop:
	
	  lb 		$t1, 0($a0) 		# load the next character into t1
	  beq   	$t1, '\n', exitLoop 	# check for the newLine character
	  addi 		$a0, $a0, 1 		# increment the string pointer
	  addi  	$t0, $t0, 1 		# increment the count
	  j 		lengthLoop 		# return to the top of the loop
	  
	exitLoop:
	
  	  jr 		$ra			# returns to line after getLength was called
  
exit:

  ori 			$v0, $0, 10       	# system call code 10 for exit
  syscall    
