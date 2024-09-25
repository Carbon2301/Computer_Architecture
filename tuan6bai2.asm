.data
prompt1: .asciiz "\nEnter array length: "
prompt2: .asciiz "Enter a number: "
comma: .asciiz ", "
newline: .asciiz "\n"
A: .word
.text
main:
la $a0, prompt1
li $v0, 4
syscall
li $v0, 5
syscall
add $a1, $zero, $v0 #length = $a1
addi $t0, $zero, 0 #initialize index i in $t0 to 0
read:
beq $t0, $a1, end_read #end loop after reaching the length of the array
la $a0, prompt2
li $v0, 4
syscall
li $v0, 5
syscall
la $a0, A
add $t2, $t0, $t0 #put 2i in $t2
add $t2, $t2, $t2 #put 4i in $t2
add $t3, $t2, $a0 #put 4i+A (address of A[i]) in $t3
sw $v0, 0($t3)    #store v0 in A[i]
addi $t0, $t0, 1
j read
end_read:
add $a1, $zero, $t3 #$a1 = Address(A[n-1])
j sort 		   #sort
after_sort:
li $v0, 10 #exitsyscall
syscall
end_main:
sort: 
beq $a0, $a1, done #single element list is sorted
j max #call the max procedure
after_max: 
lw $t0, 0($a1) #load last element into $t0
sw $t0, 0($v0) #copy last element to max location
sw $v1, 0($a1) #copy max value to last element
addi $a1, $a1, -4 #decrement pointer to last element
li $v0, 4
la $a0, newline
syscall
la $s0, A
add $s1, $zero, $t3 #s1 = A[n-1]
print:
li $v0, 1
lw $a0, 0($s0) #load A[i] into $a0
syscall
addi $s0, $s0, 4 #advance to next element
bgt $s0, $s1, endprint
li $v0, 4
la $a0, comma
syscall
j print
endprint:
li $v0, 4
la $a0, newline
syscall
la $a0, A #$a0 = Address(A[0])
j sort #repeat sort for smaller list
done:
j after_sort
max:
addi $v0, $a0, 0 #init max pointer to first element
lw $v1, 0($v0) #init max value to first value
addi $t0, $a0, 0 #init next pointer to first
loop:
beq $t0, $a1, ret #if next=last, return
addi $t0, $t0, 4 #advance to next element
lw $t1, 0($t0) #load next element into $t1
slt $t2, $t1, $v1 #(next)<(max) ?
bne $t2, $zero, loop #if (next)<(max), repeat
addi $v0, $t0, 0 #next element is new max element
addi $v1, $t1, 0 #next value is new max value
j loop #change completed; now repeat
ret:
j after_max