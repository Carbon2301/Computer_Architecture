.data
Message1a: .asciiz "The largest element is stored in $s"
Message1b: .asciiz ", largest value is "
Message2a: .asciiz "The smallest element is stored in $s"
Message2b: .asciiz ", smallest value is "
newline: .asciiz "\n"
.text
li $s0, 7
li $s1, 58
li $s2, 3
li $s3, 1
li $s4, 6
li $s5, 5
li $s6, -5
li $s7, 5
main:
jal findmaxmin
nop
quit:
li $v0, 10
syscall
end_main:
findmaxmin:
add $fp, $sp, $zero# fp points to the bottom of the stack
addi $sp, $sp, -48 # make room for the 8 elements and 4 return values
# load 8 parameters into the stack
sw $s0, 44($sp)
sw $s1, 40($sp)
sw $s2, 36($sp)
sw $s3, 32($sp)
sw $s4, 28($sp)
sw $s5, 24($sp)
sw $s6, 20($sp)
sw $s7, 16($sp)
addi $t1, $zero, 8 # last index
lw $a0, 44($sp) # a0 = first element
addi $t0, $zero, 0 # t0 = 0
# max and min so far is the first element
sw $a0, 12($sp)
sw $t0, 8($sp)
sw $a0, 4($sp)
sw $t0, 0($sp)
addi $t0, $t0, 1 # t0 = 1
loop:
bge $t0, $t1, end_loop # end loop if t0 reaches the last element
addi $t2, $t0, 1 # t2 = t0 + 1, so that when we take fp - 4 * (t0 + 1) we get a[t0]
add $t2, $t2, $t2 # t2 = 2 * t0 + 2
add $t2, $t2, $t2 # t2 = 4 * t0 + 4
sub $t2, $fp, $t2 # t2 = address(a[i])
lw $a0, 0($t2) # a0 = a[i]
lw $a1, 12($sp) # a1 = current max
lw $a2, 4($sp) # a2 = current min
max:
ble $a0, $a1, min # if a0 < a1 (a[i] < current max), skip to check if a[i] is the smallest value
sw $a0, 12($sp) # else save the new max into the stack
sw $t0, 8($sp) # and save the max index into the stack
min:
bge $a0, $a2, next # if a0 > a1 (a[i] > current min), skip to next element
sw $a0, 4($sp) # else save the new min into the stack
sw $t0, 0($sp) # and save the min index into the stack
next:
addi $t0, $t0, 1 # t0++
j loop
nop
end_loop:
print:
la $a0, Message1a
li $v0, 4
syscall
lw $a0, 8($sp)
li $v0, 1
syscall
la $a0, Message1b
li $v0, 4
syscall
lw $a0, 12($sp)
li $v0, 1
syscall
la $a0, newline
li $v0, 4
syscall
la $a0, Message2a
li $v0, 4
syscall
lw $a0, 0($sp)
li $v0, 1
syscall
la $a0, Message2b
li $v0, 4
syscall
lw $a0, 4($sp)
li $v0, 1
syscall
end_print:
return:
jr $ra