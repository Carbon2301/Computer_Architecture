.data
messenger: .asciiz "Nhap so nguyen duogn n: "
ketqua: .asciiz "Day Fibonacci nho hon n la: "
comma: .asciiz ", "
newline: .asciiz "\n"
cham: .asciiz ". "

.text
    # In thông báo "Nhap n: "
    li $v0, 4
    la $a0, messenger
    syscall

    # Nhận n từ người dùng
    li $v0, 5
    syscall
    move $s0, $v0   # $s0 = n

    # In newline
    li $v0, 4
    la $a0, newline
    syscall

    # Khởi tạo dãy Fibonacci với 0 và 1
    li $t0, 0
    li $t1, 1

main:    
    # In thông báo "Day Fibonacci nho hon n la: "
    li $v0, 4
    la $a0, ketqua
    syscall

    # In số Fibonacci đầu tiên (0)
    li $v0, 1
    move $a0, $t0
    syscall

    # In dấu phẩy
    li $v0, 4
    la $a0, comma
    syscall

    # In số Fibonacci thứ hai (1)
    li $v0, 1
    move $a0, $t1
    syscall

loop:
    # Tính toán số Fibonacci tiếp theo
    add $t2, $t0, $t1

    # Kiểm tra điều kiện dừng (nếu số Fibonacci tiếp theo lớn hơn hoặc bằng n)
    bge $t2, $s0, endloop

    # In dấu phẩy
    li $v0, 4
    la $a0, comma
    syscall

    # Cập nhật các số trong dãy Fibonacci
    move $t0, $t1
    move $t1, $t2

    # In số Fibonacci tiếp theo
    li $v0, 1
    move $a0, $t2
    syscall

    # Lặp lại quá trình
    j loop

endloop:
    # In kết thúc dòng
    li $v0, 4
    la $a0, cham
    syscall
