.data    
 
newline: 	.asciiz "\n"						# for printing a new line  
prompt: 	.asciiz  "Enter how many strings you want to sort:"  	# Prompt asking for user input
strings:      	.space	10000
buffer:		.space	100
        
.text 0x3000

main:

  li		$v0, 5			# system call 5 is for reading an integer
  syscall 				# 'NUM' read in $v0  
  
  add		$s0, $0, $v0		# $s0 = 'NUM'
  addi		$s1, $0, 100		# $s1 = 100 (length)
  
  li		$t0, 0			# $t0 = i
  li		$t1, 0			# $t1 = j
  li		$t2, 0			# $t2 = buffer for i
  li		$t3, 0			# $t3 = buffer for j
  
  jal		loadFor
  j		bubbleOuter
  
  loadFor:
  
    beq		$s0, $t0, reset	# if i < NUM, continue the loop
    mul		$t2, $t0, $s1		# $t2 = 100 * i
    
    la		$a0, strings($t2)	# load address of strings at offset
    li		$v0, 8			# loads strings at 0-99, 100-199, ... 
    la		$a1, 100
    syscall
  
    add		$t0, $t0, 1		# i++
    j		loadFor			# jump back to loop
    
  reset:
  
    add		$t0, $0, $0		# i = 0
    jr		$ra
  
  bubbleOuter:

    bne		$s0, $t0, bubbleInner	# if i < NUM, go to bubbleInner
    
    add		$t0, $0, $0		# i = 0
    add		$t1, $0, $0		# j = 0
    add		$t2, $0, $0		# reset $t2
    
    j		printStrings
    
    bubbleInner:
    
      beq	  $s0, $t1, bubbleInnerDone	# if j < NUM, continue the loop
      beq	  $t0, $t1, ijEqual		# if (i == j): continue
      
      
      ############ CALL COMPARE ##############
      
      
      mul	$t2, $t0, $s1		# $t2 = 100 * i
      mul	$t3, $t1, $s1		# $t3 = 100 * j

      j     	compareStrings          # call compareStrings
      
      compareReturn:
      	
      
      ########################################
      
      
      
      ############## CALL SWAP ###############

      beq	$t9, -1, callSwap
      
      add	$t1, $t1, 1			# j++
      j		bubbleInner			# if nothing happened, continue bubbleInner
      
      callSwap:
      
        mul	$t2, $t0, $s1		# $t2 = 100 * i
        mul	$t3, $t1, $s1		# $t3 = 100 * j
        
        j     	swapStrings             # call swapStrings

        swapReturn:
        
          add	$t1, $t1, 1			# j++
      	  j	bubbleInner			# continue bubbleInner
        
      ########################################
      
    ijEqual:
    
      add	  $t1, $t1, 1			# j++
      j		  bubbleInner			# jump back to bubbleIn (continue)
  
    bubbleInnerDone:
    
      add	  $t1, $0, $0			# j = 0
      add	  $t0, $t0, 1			# i++
      j		  bubbleOuter			# j reset, i increment, bubbleOuter




################################### EXIT ####################################
 
exit:

  ori 		$v0, $0, 10       	# system call code 10 for exit
  syscall    
  
#############################################################################
  
  
  
  
  
################################# PRINTING ##################################
  
printStrings:
    
    beq		$s0, $t0, printDone	# if i < NUM, continue the loop
    mul		$t2, $t0, $s1		# $t2 = 100 * i
    
    li      	$v0, 4       		# print string
    la      	$a0, strings($t2)  	# $a0 == address of the string
    syscall            	 		# Ask the operating system to 

    add		$t0, $t0, 1		# i++
    j		printStrings

printDone:

    j		exit
  
#############################################################################





############################## COMPARE STRINGS ##############################

compareStrings:

  add		$t4, $0, $0		# $t4 = k
  add		$t5, $t2, $0		# $t5 = i * 100
  add		$t6, $t3, $0		# $t6 = j * 100
  j		compareLoop		# compare the two strings
  
  compareFin:
  
  add		$t4, $0, $0		# $t4 = 0
  add		$t5, $0, $0		# $t5 = 0    
  add		$t6, $0, $0		# $t6 = 0
  add		$t7, $0, $0		# $t7 = 0   
  add		$t8, $0, $0		# $t8 = 0         
  j		compareReturn		# return 	
  	
  compareLoop:

    beq		$t4, 100, compareFin	# if k = LEN, then exit
    lb 		$t7, strings($t5) 	# $t7 = strings[i]
    lb		$t8, strings($t6)	# $t8 = strings[j]
  
    ifEqual:
    
      beq	$t7, $t8, checkTerm  	# if string1[i] = string2[i] --> strings[i+1]
    
    ifNotEqual:
    
      beq	$t7, '\0', string1smaller	# if string1[i] = '\0'
      beq	$t8, '\0', string2smaller	# if string2[i] = '\0'
      slt 	$s2, $t7, $t8    		# compare string1[i] and string2[i]	
      beq	$s2, 1, string1smaller
      beq	$s2, 0, string2smaller
           					
      j 	compareFin 		# exit loop since different
      
    checkTerm:
    
      li	$t9, 0    		# $t9 = 0 (in case both end and are equal)
      beq	$t7, '\0', compareFin	# if string1[i] and string2[i] = '\0'
      
      add	$t4, $t4, 1		# k++
      add	$t5, $t5, 1		# i * 100 + 1
      add	$t6, $t6, 1		# j * 100 + 1
      j		compareLoop		# else keep going
      
    string1smaller:
    
      li	$t9, -1
      j		compareFin

    string2smaller:
    
      li	$t9, 1
      j		compareFin


################################################################################



############################### SWAP STRINGS ###################################

swapStrings:

  add		$t4, $0, $0		# $t4 = k
  add		$t5, $t2, $0		# $t5 = i * 100
  add		$t6, $t3, $0		# $t6 = j * 100
  
  lb 		$t7, strings($t5) 	# $t7 = strings[i]
  lb		$t8, strings($t6)	# $t8 = strings[j]
  lb		$t9, 0			# $t9 = temp
  
  j		swapLoop		# swap the two strings
  
  swapFin:
  
    add		$t4, $0, $0		# $t4 = 0
    add		$t5, $0, $0		# $t5 = 0    
    add		$t6, $0, $0		# $t6 = 0
    add		$t7, $0, $0		# $t7 = 0   
    add		$t8, $0, $0		# $t8 = 0  
    add		$t9, $0, $0		# $t9 = 0
    j		swapReturn
  
  
  resetVar:
  
    lb 		$t7, strings($t5) 	# $t7 = strings[i]
    lb		$t8, strings($t6)	# $t8 = strings[j]
    lb		$t9, 0			# $t9 = temp
  
  swapLoop:
  
    beq		$t4, 100, swapFin
  
    lb 		$t9, strings($t5) 	# temp = strings[i]
    sb 		$t8, strings($t5)	# strings[i] = strings[j]
    sb		$t9, strings($t6)	# strings[j] = strings[i]
    
    add		$t4, $t4, 1		# k++
    add		$t5, $t5, 1		# i * 100 + 1
    add		$t6, $t6, 1		# j * 100 + 1
    
    j		resetVar
  
########################################################################
