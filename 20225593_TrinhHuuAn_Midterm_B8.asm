.data
	chieudai_mang: .word 0  
	mang: .space 0  
	input_mang: .asciiz "Nhap kich thuoc mang: "
	prompt: .asciiz "Nhap 1 phan tu cua mang: "
	soam_lon_nhat: .asciiz "So am lon nhat o vi tri thu "
	vitri: .asciiz " trong mang va co gia tri la "
	error: .asciiz "Error: khong the tim so am lon nhat trong mang! "

.text
main:

    li $v0, 4
    la $a0, input_mang
    syscall			#Nhap kich thuoc mang

    li $v0, 5
    syscall

    sw $v0, chieudai_mang		#luu kich thuoc mang

    # luu dia chi cua mang
    sll $t0, $v0, 2             
    la $t1, mang  
    sw $t0, 0($t1) 

    # doc cac phan tu cua mang
    la $t0, mang             	   # luu dia chi cua mang vao $t0
    li $t1, 0                  	   # tao bien dem vong lap
    lw $t7, chieudai_mang           # luu kich thuoc mang vao $t7
loop_1:
    beq $t1, $t7, tim_so_lon_nhat  # neu da doc het mang, chuyen sang tim so am lon nhat

    # in ra "Nhap 1 phan tu cua mang: "
    li $v0, 4
    la $a0, prompt
    syscall

    # doc phan tu cua mang
    li $v0, 5
    syscall
    move $t5, $v0
    # luu phan tu vao mang
    sw $v0, 0($t0)

    # tang bien dem va dia chi cua mang
    addi $t1, $t1, 1
    addi $t0, $t0, 4
    j loop_1

tim_so_lon_nhat:
   				  # tao bien luu so am lon nhat va vi tri cua no
    li $t2, -2147483646		  # So am nho nhat de so sanh
    li $t3, -1 			  # Vi tri cua so am lon nhat  
    # Dat lai con tro mang
    la $t0, mang
    li $t1, 0

loop_2:
    beq $t1, $t7, kiemtra_lon_nhat  # neu da duyet het mang, kiem tra so am lon nhat
    # lay phan tu hien tai
    lw $t4, 0($t0)
   				 # neu phan tu hien tai la so duong hoac khong lon hon so am lon nhat, bo qua
    bgez $t4, skip_1		 # neu phan tu hien tai la so duong, bo qua
    ble $t4, $t2, skip 		 # neu phan tu hien tai khong lon hon so am lon nhat, bo qua
    move $t2, $t4
    move $t3, $t1
skip:
    # tang bien dem va dia chi cua mang
    addi $t1, $t1, 1
    addi $t0, $t0, 4
    j loop_2
    
skip_1:       #trong truong hop gap so duong
    addi $t1, $t1, 1
    addi $t0, $t0, 4
    addi $t6, $t6, 1
    j loop_2
kiemtra_lon_nhat:
    beq $t6, $t7, print_error	#neu t6 = t7, tuc la tat ca phan tu trong mang deu duong, in ra loi
in_so_lon_nhat:
    
    li $v0, 4
    la $a0, soam_lon_nhat
    syscall
    
    addi $t3, $t3, 1
    li $v0, 1
    move $a0, $t3
    syscall

    li $v0, 4
    la $a0, vitri
    syscall
    
    li $v0, 1
    move $a0, $t2
    syscall
  
    j exit

print_error:
    
    li $v0, 4
    la $a0, error
    syscall

exit:

    li $v0, 10
    syscall