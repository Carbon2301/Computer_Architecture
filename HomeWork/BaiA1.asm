.data
line: .asciiz" "
.text
#read int
	li $v0,5
	syscall
	addi $t0, $v0,0
	li $t1,3
	li $s1,3
	li $s2,5
#for
for:	beq $t1, $t0,exit
	
	div $t1,$s1
	mfhi $s3
	div $t1, $s2
	mfhi $s4
	mul $t2, $s4, $s3
	bne $t2, $0, add_
#in ra	
	li $v0, 1
	addi $a0, $t1,0
	syscall
	
	li $v0,4
	la $a0,line
	syscall
	
add_:	addi $t1, $t1,1
	j for	
exit: 	li $v0,10
	syscall