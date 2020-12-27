.data    
 
newline: .asciiz "\n"			# for printing a new line       
        
.text 0x3000

main:

  ori     	$sp, $0, 0x3000     	# Initialize stack pointer to the top word below .text
                                	# The first value on stack will actually go at 0x2ffc
                                	# because $sp is decremented first.
  addi    	$fp, $sp, -4        	# Set $fp to the start of main's stack frame
  
loopWhile:

  addi		$v0, $0, 5		# system call 5 is for reading an integer
  syscall 				# 'n' read in $v0  
  add		$s2, $0, $v0		# $s2 = 'n'
  
  beq		$s2, $0, end		# if n = 0, terminate
  
  addi		$v0, $0, 5		# system call 5 is for reading an integer
  syscall 				# 'k' read in $v0
  add		$s3, $0, $v0		# $s3 = 'k'
  
  ori      	$a0, $s2, 0     	# Put 'n' in $a0
  ori     	$a1, $s3, 0     	# Put 'k' in $a1
  
  jal     	NchooseK           	# call NchooseK
  
  div		$v0, $v0, $s3		# divide NchooseK by K
  mflo		$v0			# store result in $v0
  
  add		$a0, $0, $v0		# print the factorial result
  li		$v0, 1
  syscall
  
  addi 		$v0, $0, 4  		# system call 4 is for printing a string
  la 		$a0, newline 		# address of newline string is in $a0
  syscall           			# print the string

  j		loopWhile

end: 
  
  ori   	$v0, $0, 10     	# system call 10 for exit
  syscall               		# we are out of here.


NchooseK:    		

  addi    	$sp, $sp, -8        	# Make room on stack for saving $ra and $fp
  sw      	$ra, 4($sp)         	# Save $ra
  sw      	$fp, 0($sp)         	# Save $fp

  addi    	$fp, $sp, 4         	# Set $fp to the start of proc1's stack frame

                               	   	# From now on:
                              	        #     0($fp) --> $ra's saved value
                                    	#    -4($fp) --> caller's $fp's saved value
                                    	
  addi    	$sp, $sp, -8        	
  sw     	$s0, 4($sp)         	# Save $s0 = n
  sw     	$s1, 0($sp)         	# Save $s1 = k



  beq		$a1, $0, returnNK	# finish if k = 0
  
  add		$s0, $0, $a0		# $s0 = 'n'
  add		$s1, $0, $a1		# $s1 = 'k'
  
  addi 		$a0, $a0, -1           	# n = n - 1
  addi 		$a1, $a1, -1            # k = k - 1

  jal		NchooseK		# call recursive function
  
  mult		$v0, $s0		# multiply NchooseK by n
  mflo		$v0			# $v0 = NchooseK(n-1, k-1) * n
  div		$v0, $s1		# divide NchooseK by k
  mflo		$v0			# $v0 = (NchooseK(n-1, k-1) * n) / k
  
  lw  		$s0,  -8($fp)           # Restore $s0
  lw  		$s1,  -12($fp)          # Restore $s1

returnNK:

  addi    	$sp, $fp, 4     	# Restore $sp
  lw      	$ra, 0($fp)     	# Restore $ra
  lw      	$fp, -4($fp)    	# Restore $fp
  jr      	$ra             	# Return from procedure
