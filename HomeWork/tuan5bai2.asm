.data
Message_1:	.asciiz "Nhap so thu nhat: "
Message_2:	.asciiz	"Nhap so thu hai: "
Message_3:	.asciiz	"Tong cua "
Message_4:	.asciiz	" va "
Message_5: 	.asciiz " la: "
Newline:		.asciiz "\n"
.text
	li	$v0, 4
	la	$a0, Message_1
	syscall				#in thong tin Message_1
	li	$v0, 5
	syscall				#doc vao so nguyen
	move	$s0, $v0		#luu so nguyen vua nhap vao thanh ghi $s0
	
	li	$v0, 4
	la	$a0, Message_2
	syscall				#in thong tin Message_2
	li	$v0, 5
	syscall
	move	$s1, $v0		#luu so vua nhap vao thanh ghi $s1
	
	add	$t1, $s0, $s1		#$t1 = $s0 + $s1
	li	$v0, 4
	la	$a0, Message_3
	syscall
	li	$v0, 1
	la	$a0, 0($s0)
	syscall
	li	$v0, 4
	la	$a0, Message_4
	syscall
	li	$v0, 1
	la	$a0, 0($s1)
	syscall
	li	$v0, 4
	la	$a0, Message_5
	syscall
	li	$v0, 1
	la	$a0, 0($t1)
	syscall
	li	$v0, 4
	la	$a0, Newline
	syscall				#in ra thong tin tong
