.data
string:		.space 50
Message1:	.asciiz	"Nhap xau "
Message2:	.asciiz "Do dai xau la "
.text
main:
get_string: 	li	$v0, 54	
		la	$a0, Message1
		la	$a1, string
		la	$a2, 50
		syscall				#in ra thong tin va nhap vao chuoi
get_length:	la	$a0, string		#gan dia chi string cho $a0
		add	$t0, $zero, $zero	#khoi tao i = 0
		lb	$t3, 0($a0)		#$t3 = s[0]
		beq 	$t3, $zero, end_of_get_length	#if s[0] = '\0' (length = 0) jump
check_char:	add	$t1, $t0, $a0		#$t1 = s[i]
		lb	$t2, 0($t1)		#$t2 = $t1 = s[i]
		beq	$t2, $zero, end_of_str	#if s[i] = '\0' jump
		addi	$t0, $t0, 1		#i += 1
		j	check_char
end_of_str:	subi	$t0, $t0, 1		#tru di ki tu '\n'
end_of_get_length:
print_length:	li	$v0, 56
		la	$a0, Message2
		la	$a1, 0($t0)
		syscall				#in ra length
