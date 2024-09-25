.text
start:
	li	$s1, 0x456
	li	$s2, 0x456
	li	$t0, 0
	addu	$s3, $s1, $s2		#s3 = s1 + s2
	xor	$t1, $s1, $s2		#kiem tra s1 va s2 cung hay khac dau
	bltz	$t1, EXIT		#nhay den EXIT neu khac dau
	xor	$t1, $s3, $s1		#kiem tra s1 va s3 cung hay khac dau
	bgez 	$t1, EXIT		#nhay den EXIT neu t1 >= 0
OVERFLOW:
	li	$t0, 1
EXIT:
