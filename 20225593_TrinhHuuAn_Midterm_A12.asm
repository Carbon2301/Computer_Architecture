.data
	input: .asciiz "Nhap vao so nguyen duong N: "
	result: .asciiz "Chu so lon nhat cua N la: "
	newline: .asciiz "\n"
.text
	li $v0, 4
	la $a0, input
	syscall
        li $v0, 5               
        syscall            #Nhap vao so nguyen duong N     
 
	move $t0,$v0 	#luu N vao t0
	li $t1,10	#t1 = 10
	div $t0,$t1      #lay t0 chia ch0 10
	mfhi $t2 	#luu chu so cuoi cung vao t2, khoi tao t2 la chu so max tam thoi
	mflo $t0		#luu thuong sau khi chia cho 10 vao t0
loop:
	beq $t0,$zero,endloop   #khi nao chia den khi bang 0 thi end_loop
	div $t0,$t1	# lay t0 chia cho 10
	mfhi $t3 	#luu tung chu so vao t3
	mflo $t0		#luu thuong sau khi chia cho 10 vao t0
	ble $t3,$t2,loop #neu t3 <= t2(max) thi lap tiep
	move $t2,$t3 	#neu t3 > t2 thi cap nhat lai max tam thoi vao t2
j loop
endloop:


	li $v0, 4
	la $a0, result
	syscall
	
	move $a0,$t2     #chuyen chu lon nhat vao thanh ghi a0
	jal print_int
	li $v0,10
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
print_int:
        li $v0, 1               # in ra so nguyen trong thanh ghi $a0
        syscall                 
        jr $ra                  # return

       