.data
string:		.space 21
reverse:		.space 21
Message1:	.asciiz "Nhap vao ki tu: "
Message2:	.asciiz "Chuoi dao nguoc la:"
Message3: 	.asciiz "Khong ton tai chuoi dao nguoc"
Newline:		.asciiz "\n"
.text
main:
	add	$s0, $zero, $zero	#khoi tao step
	la	$a1, string		#$a1 = string
get_char:
	beq	$s0, 20, reverse_string	#if strlen = 20 thuc hien reverse
	
	li	$v0, 4				
	la	$a0, Message1
	syscall				#in ra chuoi nhap ki tu
	li	$v0, 12
	syscall				#doc ki tu vao
	move	$t0, $v0			#luu ky tu vao $t0 ($t0 = c)
	beq	$t0, 10, check_eror	#neu gap ki tu Enter thi thuc hien len tiep
	li	$v0, 4			
	la	$a0, Newline
	syscall				#in ra dau xuong dong
		
	add	$t1, $s0, $a1		#$t1 = s[i]
	sb	$t0, 0($t1)		#lay ki tu $t0 nap vao $t1 (s[i] = c)
	add	$s0, $s0, 1		#i += 1
	j	get_char
check_eror:
	beq	$s0, $zero, print_eror	#if strlen = 0 in ra loi
reverse_string:
	subi	$s0, $s0, 1		#$s0 -= 1 do i chay tu 0
	la	$a2, reverse		#$a2 = reverse
	add	$s1, $zero, $zero	#i = 0
R1:
	sub	$t1, $s0, $s1		#j = $s0 - i
	blt 	$t1, $zero, print_reverse	#if j<0 thuc hien print
	add	$t2, $t1, $a1		#$t2 = s[j]
	lb	$t3, 0($t2) 		#$t3 = $t2 = s[j]
	add	$t4, $s1, $a2		#$t4 = reverse_s[i]
	sb	$t3, 0($t4)		#r[j] = reverse_s[i] 
	addi	$s1, $s1, 1		#i += 1
	j	R1
print_reverse:
	li	$v0, 4
	la	$a0, Message2
	syscall
	la	$a0, Newline
	syscall
	la	$a0, reverse
	syscall				#in ra chuoi dao
	j	end_main
print_eror:
	li	$v0, 55
	la	$a0, Message3
	syscall				#in ra thong bao loi
end_main:
