.data
  AA:     .space 400  		# int AA[100]
  BB:     .space 400  		# int BB[100]
  CC:	  .space 400  		# int CC[100]	
  m:      .space 4   		# m is an int whose value is at most 10
                     		# actual size of the above matrices is mxm
  newline: .asciiz "\n"
  max:	  .word 0x0		# keeps track of the maxproduct of matrix
  space: .asciiz " "		# for printing a space
  
.text

main:

  li		$v0, 5		        # system call 5 is for reading an integer
  syscall 				# integer value read is in $v0
  
  add		$t0, $0, $v0		# $t0: m (user input)
  add		$t1, $0, $0		# $t1: offset
  add		$t2, $0, $0		# $t2: i = 0
  
AFor:

  li		$v0, 5		        # system call 5 is for reading an integer
  syscall 				# integer value read is in $v0

  sw 		$v0, AA($t1)		# $v0 = AA[offset (4)]
  addi		$t1, $t1, 4		# increse offset (4)
  
  addi		$t2, $t2, 1		# i++
  slt		$t4, $t2, $t0		# $t4 = i < m
  bne		$t4, $0, AFor		# loops if $t4 is true



add	$t2, $0, $0		# i = 0
add	$t1, $0, $0		# offset = 0
  
BFor:

  li		$v0, 5		        # system call 5 is for reading an integer
  syscall 				# integer value read is in $v0

  sw		$v0, BB($t1)		# $v0 = AA[offset (4)]
  addi		$t1, $t1, 4		# increse offset (4)
  
  addi		$t2, $t2, 1		# i++
  slt		$t4, $t2, $t0		# $t4 = i < m
  bne		$t4, $0, BFor		# loops if $t4 is true  

  add		$t2, $0, $0		# i = 0
  add		$t1, $0, $0		# offset = 0
  
PrintA:

  beq		$t2, $t0, reset3	# check for array end (if i = m, exit)
  
  lw  		$v0, AA($t1)            # access element of AA
  add		$a0, $0, $v0
  addi 		$v0, $0, 1  		# system call 1 is for printing an integer
  syscall           			# print the integer
  
  addi		$t1, $t1, 4		# increse offset(4)
  
  addi 		$v0, $0, 4  		# system call 4 is for printing a string
  la 		$a0, newline 		# address of newline string is in $a0
  syscall           			# print the string
  
  addi		$t2, $t2, 1		# i++
  
  j		PrintA
  
reset3:

  add		$t1, $0, $0		# $t1: offset
  add		$t2, $0, $0		# $t2: i = 0
  
PrintB:

  beq		$t2, $t0, exit	        # check for array end (if i = m, exit)
  
  lw  		$v0, BB($t1)            # access element of AA
  add		$a0, $0, $v0
  addi 		$v0, $0, 1  		# system call 1 is for printing an integer
  syscall           			# print the integer
  
  addi		$t1, $t1, 4		# increse offset(4)
  
  addi 		$v0, $0, 4  		# system call 4 is for printing a string
  la 		$a0, newline 		# address of newline string is in $a0
  syscall           			# print the string
  
  addi		$t2, $t2, 1		# i++
  
  j		PrintB
  
exit:
                   
  addi $v0, $0, 10      	# system call code 10 for exit
  syscall               	# exit the program
  
