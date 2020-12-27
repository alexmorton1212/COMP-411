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
  
  la 		$a0, string1            # $a0 = string1
  la		$a1, string2		# $a1 = string2
  jal		swapLoop		# swap the two strings
  
  li      	$v0, 4       		# code 4 == print string
  la      	$a0, string1  		# $a0 == address of the string
  syscall            	 		# Ask the operating system to 
 
  li      	$v0, 4       		# code 4 == print string
  la      	$a0, string2  		# $a0 == address of the string
  syscall            	 		# Ask the operating system to 
  
  j		exit
  
  swapLoop:

    lb 		$t2, 0($a0) 		# $t2 = string1[i]
    lb		$t3, 0($a1)		# $t3 = string2[i]
    
    beq		$t2, '\0', string1done	# if string1[i] = '\0'
    beq		$t3, '\0', string2done	# if string2[i] = '\0'
  
    lb		$t1, 0($a0)		# temp = string1[i]
    sb		$t3, 0($a0)		# string1[i] = string2[i]
    sb		$t1, 0($a1)		# string2[i] = temp

    addi 	$a0, $a0, 1 		# increment the string pointer: string1
    addi 	$a1, $a1, 1 		# increment the string pointer: string2
    
    j		swapLoop
    
exitLoop:

  li	$t0, 0
  jr	$ra
  
string1done:
 
  lb		$t1, 0($a0)		# temp = string1[i]			# swap one more time, now string2 is done
  sb		$t3, 0($a0)		# string1[i] = string2[i]
  sb		$t1, 0($a1)		# string2[i] = temp
  
  j		contString1		# jump to contString1
  
  contString1:
  
    addi 	$a0, $a0, 1 		# increment the string pointer: string1
    addi 	$a1, $a1, 1 		# increment the string pointer: string2
    
    lb		$t1, 0($a0)		# temp = string1[i]			
    sb		$t3, 0($a0)		# string1[i] = string2[i]
    sb		$t1, 0($a1)		# string2[i] = temp
  
    lb 		$t2, 0($a0) 		# $t2 = string1[i]
    lb		$t3, 0($a1)		# $t3 = string2[i]
  
    bne		$t2, '\0', contString1	# if "string1" is not done now
    
    li		$t4, '\n'
    sb		$t4, 0($a0)
    
    j		exitLoop		# else exit (were done)
      		
string2done:
 
  lb		$t1, 0($a0)		# temp = string1[i]			# swap one more time, now string1 is done
  sb		$t3, 0($a0)		# string1[i] = string2[i]
  sb		$t1, 0($a1)		# string2[i] = temp
  
  j		contString2		# jump to contString2
  
  contString2:
  
    addi 	$a0, $a0, 1 		# increment the string pointer: string1
    addi 	$a1, $a1, 1 		# increment the string pointer: string2
  
    lb		$t1, 0($a0)		# temp = string1[i]			
    sb		$t3, 0($a0)		# string1[i] = string2[i]
    sb		$t1, 0($a1)		# string2[i] = temp
  
    lb 		$t2, 0($a0) 		# $t2 = string1[i]
    lb		$t3, 0($a1)		# $t3 = string2[i]
  
    bne		$t3, '\0', contString2	# if "string2" is not done now
    
    li		$t4, '\n'
    sb		$t4, 0($a1)
   
    j		exitLoop		# else exit (were done)
  
exit:

  ori 		$v0, $0, 10       	# system call code 10 for exit
  syscall    
  
