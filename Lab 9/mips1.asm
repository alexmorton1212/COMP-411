# Starter file for ex1.asm

.data

	newline: .asciiz "\n" 
	char0: .byte '0' #value to store character 0
	char1: .byte '1'  # value to store character 1
	pattern: .space 21 # space allocated for the array
	
.text 

main:

	ori 		$sp, $0, 0x3000     		# Initialize stack pointer to the top word below .text
                                     			# The first value on stack will actually go at 0x2ffc
                                     			# because $sp is decremented first.
  	addi    	$fp, $sp, -4         		# Set $fp to the start of main's stack frame


  	addi		$v0, $0, 5			# system call 5 is for reading an integer
  	syscall 					# 'n' read in $v0 
 
  	add		$s0, $0, $v0			# $s0 = 'N'
        add 		$a2, $s0, $0 			# $a2 = 'N'

	addi 		$a1, $a1, 0  			# $a1 = currentlevel
	beq		$a2, $0, end			# if N = 0, finish
	
	jal		makepatterns
	
	j 		end
	
end: 

	ori 		$v0, $0, 10     		# system call 10 for exit
	syscall               				# we are out of here.


makepatterns:    

    addi    $sp, $sp, -16        # Make room on stack for saving $ra and $fp
    sw      $ra, 12($sp)         # Save $ra
    sw      $fp, 8($sp)         # Save $fp
    sw	    $s0, 4($sp)  		# $s0 = N
    sw	    $s1, 0($sp)  		# $s1 = currentlevel
		
	 
	 add     $s0, $a2, $0  		# $s0 = N
	 add     $s1, $a1, $0  		# $s1 = currentlevel
	 la      $s2, pattern    	# $s2 = pattern
	 
         beq	 $s1, $s0, print 	# if currentlevel = N, print pattern
         
         
         add     $t2,$s2,$s1   		# t2 stores pattern[n], t2= s2(start of pattern array)+s1(index)
         lb      $t0,char0    		# $t1 = '0'
         sb      $t0, pattern     	# character 0 is added as the element in parallel array
	 
	 addi	 $a1, $s1, 1		# currentlevel = currentlevel + 1
		
	 jal	 makepatterns
	 
	 add     $t2,$s2,$s1      #follows same pattern
         
         lb      $t0,char1
         sb      $t0,($t2)
         
         addi	 $a1, $s1, 1                   # currentlevel = currentlevel + 1
	 
	 jal     makepatterns                  # recursive call

	 
	
restore:



	lw   $ra, 12($sp)        # read registers from stack
        lw   $s0, 4($sp)
        lw   $s1, 0($sp)
        
	addi $sp, $sp, 16       # bring back stack pointer
       
        jr $ra			# return from procedure

	
print:
  
  addi 		$v0, $0, 4		# print pattern
  la 		$a0, pattern
  syscall
               	
  addi 		$v0, $0, 4		# print newline
  la 		$a0, newline 
  syscall
		
  j		restore
		