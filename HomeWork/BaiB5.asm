.data
    array:      .space 400      # Khai báo mảng có thể chứa tối đa 100 phần tử (4 byte mỗi phần tử)
    array_msg:  .asciiz "Nhap so phan tu cua mang: "
    element_msg: .asciiz "Nhap phan tu "
    even_sum_msg: .asciiz "Tong cac phan tu chan trong mang la: "
    positive_sum_msg: .asciiz "Tong cac phan tu duong trong mang la: "
    newline:    .asciiz "\n"
    space:      .asciiz " "
.text
main:
li $t7, 2
    # Nhập số lượng phần tử của mảng
    li $v0, 4
    la $a0, array_msg
    syscall

    li $v0, 5
    syscall
    move $t0, $v0          # Lưu số lượng phần tử vào $t0

    # Nhập các phần tử của mảng
    la $t1, array           # $t1 trỏ đến địa chỉ bắt đầu của mảng
    li $t2, 0               # Biến đếm để lặp qua các phần tử của mảng

input_loop:
    beq $t2, $t0, calculate_sum   # Nếu đã nhập đủ số lượng phần tử, chuyển đến bước tính tổng
    addi $t2, $t2, 1                # Tăng biến đếm lên 1
    li $v0, 4
    la $a0, element_msg
    syscall
    move $a0, $t2                   # In ra thông điệp nhập phần tử thứ $t2
    

    li $v0, 5
    syscall
    sw $v0, 0($t1)                  # Lưu phần tử vừa nhập vào mảng
    addi $t1, $t1, 4                # Tăng con trỏ mảng lên 4 byte

    j input_loop

calculate_sum:
    li $t3, 0               # Khởi tạo biến tổng các phần tử chẵn là 0
    li $t4, 0               # Khởi tạo biến tổng các phần tử dương là 0
    la $t1, array           # $t1 trỏ đến địa chỉ bắt đầu của mảng
    li $t2, 0               # Biến đếm để lặp qua các phần tử của mảng

sum_loop:
    beq $t2, $t0, print_results    # Nếu đã duyệt hết mảng, chuyển đến bước in kết quả

    lw $t5, 0($t1)                  # Load giá trị của phần tử hiện tại vào $t5
    addi $t1, $t1, 4                # Tăng con trỏ mảng lên 4 byte
    bltz $t5, sum_loop
    # Tính tổng các phần tử chẵn
    div $t5, $t7   # A[i] / 2
    mfhi $t6       # lấy dư ra $t6
    bne $t6, $0, not_even
    add $t3, $t3, $t5                # Cộng phần tử vào tổng các phần tử chẵn
not_even:

    # Tính tổng các phần tử dương
    blez $t5, negative               # Nếu phần tử âm, nhảy qua
    add $t4, $t4, $t5                # Cộng phần tử vào tổng các phần tử dương
negative:

    addi $t2, $t2, 1                # Tăng biến đếm lên 1
    j sum_loop

print_results:
    # In tổng các phần tử chẵn
    li $v0, 4
    la $a0, even_sum_msg
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

    # In ra một dòng mới
    li $v0, 4
    la $a0, newline
    syscall

    # In tổng các phần tử dương
    li $v0, 4
    la $a0, positive_sum_msg
    syscall

    li $v0, 1
    move $a0, $t4
    syscall

    # Kết thúc chương trình
    li $v0, 10
    syscall
