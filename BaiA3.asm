.data
	Input_S:	.asciiz "Nhap so S: " 
	Msg1: 		.asciiz "S la so nguyen to!\n"
	Msg2: 		.asciiz "S khong phai la so nguyen to!\n"
	Error: 		.asciiz "So S phai lon hon hoac bang 2, vui long nhap lai S: "
	Input_M:	.asciiz "Nhap so M: "
	Error_M:	.asciiz "M phai la mot so lon hon 0, vui long nhap lai M: "
	Input_N:	.asciiz "Nhap so N: "
	Error_N:	.asciiz "N phai la mot so lon hon 0, vui long nhap lai N: "
	Error_N2:	.asciiz "N phai lon hon M, vui long nhap lai N: "
	Msg3:		.asciiz "\nNhap hai so M va N:\n"
	Msg4: 		.asciiz "Cac so nguyen to trong doan tu M den N la: "
	Space:		.asciiz ", "

.text
	# Message Input:
	li	$v0, 4
	la	$a0, Input_S
	syscall
	
Input1:
	# Nhap so S va kiem tra dieu kien:
	li	$v0, 5
	syscall
	
	slti 	$t0, $v0, 2	# Neu S < 2 thi khong phai so nguyen to
	bgtz 	$t0, NotPrime
	move	$s0, $v0	# Gan S vao $s0
	j	CheckPrime	# Neu S >= 2 thi check xem S co phai so nguyen to khong?
	
Exit:
	li	$v0, 10
	syscall
	
CheckPrime:
	li 	$t1, 2		# Gan i = $t1 = 2
	
loop:
	beq	$t1, $s0, IsPrime	# Neu i = S thi so nay la so nguyen to
	div 	$s0, $t1		# Chia S cho i
	mfhi	$a1			# Lay so du cua phep chia gan vao $a1
	beqz 	$a1, NotPrime		# Neu $a1 = 0 tuc la i | S thi S khong la so nguyen to
	addi	$t1, $t1, 1		# i += 1
	j 	loop
	
NotPrime:	
	# Khong phai so nguyen to
	li	$v0, 4
	la	$a0, Msg2
	syscall
	j	PrintPrime
	
IsPrime:
	# La so nguyen to
	li	$v0, 4
	la	$a0, Msg1
	syscall
	
PrintPrime: 		# In cac so nguyen to tu M den N:
	# Nhap hai so M va N:
	li	$v0, 4
	la	$a0, Msg3
	syscall
	
	li	$v0, 4
	la	$a0, Input_M
	syscall
	
InputM:
	li	$v0, 5
	syscall
	
	slti 	$t0, $v0, 0	# Neu M < 0 thi error
	bgtz 	$t0, Error1
	move	$s0, $v0	# Gan M vao $s0
	
	# Neu M = 1 thi cong them 1 vao M:
	seq 	$t9, $s0, 1	# Neu M = 1
	beq	$t9, 1, Add1M

Add1M:
	addi	$s0, $s0, 1	# M += 1
	
	li	$v0, 4
	la	$a0, Input_N
	syscall
	j	InputN		# Neu M >= 0 thi nhap tiep N

Error1:
	li	$v0, 4
	la	$a0, Error_M
	syscall	
	j	InputM

InputN:
	li	$v0, 5
	syscall
	
	slti 	$t0, $v0, 0	# Neu N < 0 thi error
	bgtz 	$t0, Error2
	
	slt 	$t0, $v0, $s0	# Neu N < M thi error
	bgtz 	$t0, Error3
	move	$s1, $v0	# Gan N vao $s1
	
	li	$v0, 4
	la	$a0, Msg4
	syscall
	
	j	CheckPrime2	# Neu N >= 0 thi in ra cac so nguyen to trong khoang [M; N]

Error2:
	li	$v0, 4
	la	$a0, Error_N
	syscall	
	j	InputN
	
Error3:
	li	$v0, 4
	la	$a0, Error_N2
	syscall	
	j	InputN

Set:	
	beq	$s0, $s1, Exit
	addi	$s0, $s0, 1
		
CheckPrime2:
	li 	$t1, 2			# Gan i = $t1 = 2
	
loop2:
	beq	$t1, $s0, PrintPrime2	# Neu i = M thi so nay la so nguyen to
	div 	$s0, $t1		# Chia M cho i
	mfhi	$a1			# Lay so du cua phep chia gan vao $a1
	beqz 	$a1, Set		# Neu $a1 = 0 tuc la i | M thi M khong la so nguyen to
	addi	$t1, $t1, 1		# i += 1
	j 	loop2
	
PrintPrime2:
	# In ra output
	li	$v0, 1
	move	$a0, $s0
	syscall
	
	li	$v0, 4
	la	$a0, Space
	syscall
	
	j 	Set