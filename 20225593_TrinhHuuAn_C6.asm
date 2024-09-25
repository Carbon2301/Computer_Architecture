.data
	input: .asciiz "Nhap vao mot xau: "
	kiemtra: .asciiz "Nhap ki tu muon kiem tra: "
	output: .asciiz "So lan xuat hien cua ki tu can kiem tra: "
	newline: .asciiz "\n"
	enter_line: .asciiz "Ban da nhap so enter, so ki tu la 1"
	st: .space 256
.text    

        li $v0, 4
        la $a0, input
        syscall			#Nhap vao mot xau: 
    
	li $v0, 8
	la $a0, st
	li $a1, 256
	syscall			#Noi dung xau
	
	li $v0, 4
        la $a0, kiemtra
        syscall  		#Nhap ki tu can kiem tra
	
	li $v0, 12		#input $v0 chua ki tu
 	syscall 
	
	li $s5, 10
	beq $v0, $s5, enter
	
	addi   $t6, $t6, 65
	addi   $t7, $t7, 90
	addi $t8, $v0, 0		#Gan ki tu nhap tu thanh ghi $v0 vao $t8
	bgt  $t8, $t7, chu_thuong
	blt  $t8, $t9, chu_thuong
chu_hoa:
	addi $t8, $t8, 32        #chuyen chu hoa thanh chu thuong
chu_thuong:
	addi $t9, $t8, -32       #chuyen chu cai thuong thanh chu in hoa, chu in hoa luu o thanh ghi #t9
	la $s0, st		#luu ki tu dau tien trong xau vao thanh ghi $s0
	li $t3, 0		#t3 = 0
	li $t0, -1 		#i = 0
	li $s5, 10 		#s5 = ki tu ket thuc xau (dau enter)
solve:
	
	lb $s6, 0($s0)		#gan tung ki tu cua xau vao thanh ghi $s6 de check 
	beq $s6, $s5, done 	#neu gap kí tự kết thúc xâu thì done
	
	beq $s6, $t8, tang_dem1 
	continue1:
	beq $s6, $t9, tang_dem2
	continue2:
	

	addi $s0, $s0, 1		# i = i + 1
	j solve
tang_dem1:
	addi $t3, $t3, 1
	j continue1
tang_dem2:
	addi $t3, $t3, 1
	j continue2
done:    
	li $v0 ,4
	la $a0, newline
	syscall
	
	li $v0, 4
	la $a0, output
	syscall
	
	li $v0, 1
	addi $a0, $t3, 0
	syscall
	li $v0, 4
        la $a0, newline
        syscall
        
        li $v0, 10
        syscall
        
enter:
	li $v0, 4
	la $a0, enter_line
	syscall
	
	