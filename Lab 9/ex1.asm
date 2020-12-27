.data    
 
newline: 	.asciiz "\n"			# for printing a new line     
pattern:	.space	21		  	# char pattern[21]
charbytes: 	.byte '0','1'

.data
	input:	.space 21
	newline: .asciiz "\n" 
	value0: .byte '0' #value to store character 0
	value1: .byte '1'  # value to store character 1
	pattern: .space 21 # space allocated for the array

        	
.text 0x3000

main:

  ori 		$sp, $0, 0x3000     		# Initialize stack pointer to the top word below .text
                                     		# The first value on stack will actually go at 0x2ffc
                                     		# because $sp is decremented first.
  addi    	$fp, $sp, -4         		# Set $fp to the start of main's stack frame


  addi		$v0, $0, 5			# system call 5 is for reading an integer
  syscall 					# 'n' read in $v0 
   
  add		$s0, $0, $v0			# $s0 = 'N'

  sb 		$0, pattern($s0)		# pattern[N] = 0 (terminator)
  
  la    	$t0, charbytes
  lb    	$s6, 0($t0)        		# $s6 = '0'
  lb    	$s7, 1($t0)        		# $s7 = '1'       	  
    
  ori     	$a0, $s0, 0     		# $a0 = N
  ori     	$a1, $0, 0     			# $a1 = currentlevel
  la 	  	$a2, pattern			# $a2 = pattern 

  jal     	makepatterns           		# call makepatterns
  
  j		exit_from_main 
  
exit_from_main:

  ori     	$v0, $0, 10     	# System call code 10 for exit
  syscall                 		# Exit the program
   	 
  
makepatterns:

  addi    	$sp, $sp, -4        	# Make room on stack for saving $ra and $fp
  sw      	$ra, 0($sp)         	# Save $ra

  addi    	$fp, $sp, 4         	# Set $fp to the start of proc1's stack frame

                               	   	# From now on:
                              	        #     0($fp) --> $ra's saved value
                                    	#    -4($fp) --> caller's $fp's saved value
                              	               	
                                	             	                 	               	                 	               	
  addi    	$sp, $sp, -4        	
  sb     	$s2, 0($sp)         	# Save $s2 = currentlevel

  
  beq		$a1, $a0, print	 	# if currentlevel = N ... print pattern

  sb  		$s6, pattern($a1)	# pattern[curretntlevel] = '0'
  addi 		$a1, $a1, 1           	# currentlevel = currentlevel + 1
 
  jal		makepatterns		# call recursive function
 
  sb  		$s7, pattern($a1)	# pattern[currentlevel] = '1'
  addi 		$a1, $a1, 1           	# currentlevel = currentlevel + 1
  
  jal		makepatterns		# call recursive function

   
return:

  addi    	$sp, $fp, 4     	# Restore $sp
  lw      	$ra, 0($fp)     	# Restore $ra
  lw      	$fp, -4($fp)    	# Restore $fp
  jr      	$ra             	# Return from procedure

	
exitprintval:

        lw   $ra, 0($sp)        # read registers from stack
        lw   $s0, 12($sp)
        lw   $s1, 8($sp)
        
        addi $sp, $sp, 12       # bring back stack pointer
 
        jr $ra	
	
	
print:
               
        li $v0, 4
        la $a0, pattern #printing the array
        syscall
               
        li $v0, 4
	la $a0, newline #printing the new line	
	syscall
		
	j exitprintval
	
		

