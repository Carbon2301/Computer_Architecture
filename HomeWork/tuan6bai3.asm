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
sw $v0, 0($t3) #store v0 in A[i]
addi $t0, $t0, 1
j read
end_read:
add $a1, $zero, $t3 #$a1 = Address(A[n-1])
add $a2, $zero, $a1 #$a2 = Address(A[n-1]) for printing
j sort
nop
after_sort:
li $v0, 10 # exit syscall
syscall
end_main:
sort:
beq $a0, $a1, done # single element list is sorted
nop
loop:
beq $a0, $a1, endloop # stop after getting to the last element
nop
lw $s0, 0($a0) # load array[i] into $s0
lw $s1, 4($a0) # load array[i+1] into $s1
ble $s0, $s1, skip_swap # if array[i] <= array[i+1], skip swap
nop
sw $s1, 0($a0) # store array[i+1] into array[i]
sw $s0, 4($a0) # store array[i] into array[i+1]
skip_swap:
addi $a0, $a0, 4 # increment pointer to next element
j loop
nop
endloop:
print:
li $v0, 4
la $a0, newline
syscall
la $s0, A
printloop:
li $v0, 1
lw $a0, 0($s0) #load A[i] into $a0
syscall
addi $s0, $s0, 4 #advance to next element
bgt $s0, $a2, endprint
nop
li $v0, 4
la $a0, comma
syscall
j printloop
nop
endprintloop:
li $v0, 4
la $a0, newline
syscall
endprint:
addi $a1, $a1, -4 # decrement pointer to last element
sub $a0, $a0, $t1 # reset array pointer to the start
la $a0, A #$a0 = Address(A[0])
j sort
nop
done:
j after_sort
nop