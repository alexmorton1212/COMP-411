.data

newLine: 	.asciiz "\n"
string1:      	.space	100
string2:	.space  100

.text	0x3000

main:

				# Loads string into string1
  li 		$v0, 8 			# take in input
  la 		$a0, string1 		# load byte space into address
  li 		$a1, 100 		# allot the byte space for string (100 characters)
  syscall                        	
                     
                          	# Loads input into string2  	
  li 		$v0, 8 			# take in input
  la 		$a0, string2 		# load byte space into address
  li 		$a1, 100 		# allot the byte space for string
  syscall
  
  add		$t0, $0, $0		# $t0 = i
  li		$t1, 100		# $t1 = LEN (=100)
  
  la 		$a0, string1            # $a0 = string1
  la		$a1, string2		# $a1 = string2
  jal		compareLoop		# compare the two strings
  
  li 		$v0, 1			# prints result of $t5
  move 		$a0, $t5
  syscall                                          	                       	                              	                      	                              	                       	                              	           
     
  j		exit
  
compareLoop:

  beq		$t0, $t1, exitLoop	# if i = LEN, then exit
  
  lb 		$t2, 0($a0) 		# $t2 = string1[i]
  lb		$t3, 0($a1)		# $t3 = string2[i]
  
    ifEqual:
    
      beq	$t2, $t3, checkTerm  	# if string1[i] = string2[i] --> strings[i+1]
    
  
    ifNotEqual:
    
      beq	$t2, '\0', string1smaller	# if string1[i] = '\0'
      beq	$t3, '\0', string2smaller	# if string2[i] = '\0'
    
      slt 	$t5, $t2, $t3    		# compare string1[i] and string2[i]
		
      beq	$t5, 1, string1smaller
      beq	$t5, 0, string2smaller
      					
      j 	exitLoop 		# exit loop since different
      
    checkTerm:
    
      li	$t5, 0    		# $t5 = 0 (in case both end and are equal)
      beq	$t2, '\0', exitLoop	# if string1[i] and string2[i] = '\0'
      j		incrementPointers	# else keep going
      
    incrementPointers:
    
      addi 	$a0, $a0, 1 		# increment the string pointer: string1
      addi 	$a1, $a1, 1 		# increment the string pointer: string2
      addi	$t0, $t0, 1		# i++
      j		compareLoop
      
    string1smaller:
    
      li	$t5, -1
      j		exitLoop

    string2smaller:
    
      li	$t5, 1
      j		exitLoop

exitLoop:

  li		$t0, 0
  jr		$ra
  
    
exit:

  ori 			$v0, $0, 10       	# system call code 10 for exit
  syscall    
