#Text assignment
.text
	li	$s0, 1		
	li	$t0, 1			
	li	$s1, 5			
	li	$s2, 16
LOOP:
	sllv	$t1, $t0, $s0		# t1 = t0 * 2^(s0) 
	beq	$t1, $s2, MUL		# neu t1 < s2 thuc hien lenh nhan cho den khi t1 = s2
	bgt 	$t1, $s2, EXIT		# t1 > s2 => s2 khong phai luy thua cua 2 => EXIT
	addi	$s0, $s0, 1		# tang gia tri dich bit len 1
	j	LOOP
MUL:
	sllv	$s3, $s1, $s0		#s3 = s1 * s2 
EXIT:
