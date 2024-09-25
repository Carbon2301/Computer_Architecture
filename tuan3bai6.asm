.data
    arr: .word 5, -3, 14, -23, 20, -6
.text
    addi    $s1, $zero, 0    		# i
    la        $s2, arr            	# loading array
    addi    $s3, $zero, 6    		# n
    addi    $s4, $zero, 1    		# step
    addi    $s5, $zero, 0    		# the greatest absolute value in the array
loop:    slt     $t2, $s1, $s3    	# i < n
   	  beq    $t2, $zero, endloop
    	  add    $t1, $s1, $s1
  	  add    $t1, $t1, $t1            #offset
  	  add    $t1, $t1, $s2            #A[i]
  	  lw    $t0, 0($t1)        	# load the value of A[i]
    start:            			
        slt    $t3, $t0, $zero     	# Neu A[i] < 0($t3 = 1)
        beq    $t3, $zero, start_1  	# Neu $t3=0 => re nhanh hoac nguoc lai
        sub    $t0, $zero, $t0    	# Neu A[i] < 0, chuyen thanh so duong
    start_1:            			# Tim GTLN
        slt    $t3, $t0, $s5         	# So sanh A[i] voi GTLN 
        bne    $t3, $zero, endif          # Neu $t3 khac 0, nhay den endif va nguoc lai	
        addi   $s5, $t0, 0		# Cap nhat GTLN
    endif:
        add     $s1, $s1, $s4       	# i = i + 1
    j    loop
endloop:
    li  $v0, 1           # service 1 is print integer
    syscall
