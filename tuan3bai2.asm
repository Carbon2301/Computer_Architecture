.data
arr: .word 2, 3, 0, 1
.text
    addi $s5, $zero, 0 # sum = 0
    addi $s1, $zero, 0 # i = 0
    la   $s2, arr      # load array
    addi $s3, $zero, 4 # khoi tao n
    addi $s4, $zero, 1 # khoi tao step
loop:  
    slt  $t2, $s1, $s3 # $t2 = i < n ? 1 : 0
    beq $t2, $zero, endloop
    add $t1, $s1, $s1 # $t1 = 2 * $s1
    add $t1, $t1, $t1 # $t1 = 4 * $s1
    add $t1, $t1, $s2 # $t1 store the address of A[i]
    lw  $t0, 0($t1)   # load value of A[i] in $t0
    add $s5, $s5, $t0 # sum = sum + A[i]
    addi $s1, $s1, 1  # i = i + step
    j loop            # goto loop
endloop:
    li $v0, 1         # Chuẩn bị mã hệ thống để in ra một số nguyên
    syscall           # Thực hiện việc in ra giá trị của tổng sum
