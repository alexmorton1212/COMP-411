.data
  AA:     .space 400  		# int AA[100]
  BB:     .space 400  		# int BB[100]
  CC:     .space 400  		# int CC[100]
  m:      .space 4   		# m is an int whose value is at most 10
                     		# actual size of the above matrices is mxm
               
  newline: .asciiz "\n"		# for printing a new line
  space:   .asciiz " "		# for printing a space
  

.text

main:
					# Read in the value of 'm'
  addi		$v0, $0, 5		# system call 5 is for reading an integer
  syscall 				# integer value read is in $v0
  
  add		$t0, $0, $v0		# $t0: m = user input
  add  		$t1, $0, $0		# $t1: offset = 0
  
  mult 		$t0, $t0		# m * m
  mflo		$t2			# $t2: m * m
  
  add 		$t3, $0, $0		# $t3: i = 0
  add		$t4, $0, $0		# $t4: j = 0
  add		$t5, $0, $0		# $t5: k = 0
  
  add		$s1, $0, 4		# $s1 = 4
  

AFor: 
  
  li		$v0, 5		        # system call 5 is for reading an integer
  syscall 				# integer value read is in $v0

  sw		$v0, AA($t1)		# $v0 = AA[offset (4)]
  addi		$t1, $t1, 4		# increse offset (4)
  
  addi		$t3, $t3, 1		# i++
  slt		$t6, $t3, $t2		# $t6 = i < m * m
  bne		$t6, $0, AFor		# loops if $t6 is true
  
  add  		$t1, $0, $0		# $t1: offset = 0
  add 		$t3, $0, $0		# $t3: i = 0
      
BFor:  

  li		$v0, 5		        # system call 5 is for reading an integer
  syscall 				# integer value read is in $v0

  sw		$v0, BB($t1)		# $v0 = BB[offset (4)]
  addi		$t1, $t1, 4		# increse offset (4)
  
  addi		$t3, $t3, 1		# i++
  slt		$t6, $t3, $t2		# $t4 = i < m * m
  bne		$t6, $0, BFor		# loops if $t4 is true
 
  add  		$t1, $0, $0		# $t1: offset = 0
  add 		$t3, $0, $0		# $t3: i = 0
      
      
TopCLoop:

  slt		$t6, $t3, $t0		# if i < m
  bne		$t6, $0, MiddleCLoop	# jumps if $t6 is true
  
  j		exit
  
MiddleCLoop:

  slt		$t6, $t4, $t0		# if j < m
  bne		$t6, $0, BottomCLoop	# jumps if $t6 is true
  
  add		$t4, $0, $0		# $t4: j = 0
  add		$t3, $t3, 1		# i++
  
  addi 		$v0, $0, 4  		# system call 4 is for printing a string
  la 		$a0, newline 		# address of newline string is in $a0
  syscall           			# print the string
 
  j		TopCLoop
  
BottomCLoop:
  
  mult		$t3, $t0		# i * m
  mflo		$t6			# $t6: i * m
  add		$t6, $t6, $t5		# $t6: (i * m) + k
  mult 		$t6, $s1		# $t6: 4((i * m) + k)
  mflo		$t6
  
  lw  		$v0, AA($t6)   		# access element of AA[offset]
  add		$t6, $0, $v0    	# $t6 = AA[(i * m) + k]
  
  mult		$t5, $t0		# k * m
  mflo		$t7			# $t7: k * m
  add		$t7, $t7, $t4		# $t7: (k * m) + j
  mult 		$t7, $s1		# $t7: 4((k * m) + j)
  mflo		$t7
  
  lw  		$v0, BB($t7)    	# access element of AA[offeset]
  add		$t7, $0, $v0    	# $t7 = BB[(zk * m) + j]
  
  mult		$t6, $t7		# AA[(i * m) + k] * BB[(k * m) + j]
  mflo		$t6			# $t6 = above ^^
  
  mult		$t3, $t0		# i * m
  mflo		$t8			# $t8: i * m
  add		$t8, $t8, $t4		# $t8: (i * m) + j
  mult 		$t8, $s1		# $t8: 4((i * m) + j)
  mflo		$t8
  
  sw    	$t6, CC($t8)		# CC[$t8] = $t6
  lw  		$v0, CC($t8)    	# $v0 = CC[$t8]
  add		$t9, $t6, $v0		# CC[$t8] =  CC[$t8] + $t6
  lw 		$t9, CC($t8)		# $t9 = CC[$t8]
  add		$t1, $t1, $t9
 
  slt 		$t7, $t5, $t0		# if k < m, loop
  add		$t5, $t5, 1		# k++
  bne		$t7, $0, BottomCLoop 	# jump to BottomCLoop if true
  
  addi 		$v0, $0, 1  		# system call 1 is for printing an integer
  add		$a0, $0, $t1		# load value of CC[]
  syscall           			# print the integer
  
  addi 		$v0, $0, 4  		# system call 4 is for printing a string
  la 		$a0, space 		# address of space string is in $a0
  syscall           			# print the string
  
  add		$t4, $t4, 1		# j++
  add		$t5, $0, $0		# $t5: k = 0
  
  add		$t1, $0, $0		# resets $t1
 
  j     	MiddleCLoop
  

exit:                     		# this is code to terminate the program -- don't mess with this!

  addi $v0, $0, 10      		# system call code 10 for exit
  syscall               		# exit the program


