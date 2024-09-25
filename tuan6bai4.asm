.data
prompt1: .asciiz "\nEnter array length: "
prompt2: .asciiz "Enter a number: "
comma: .asciiz ", "
newline: .asciiz "\n"
A: .word
.text
main:
la $a0, prompt1
la $a2, A # $a2 = Address(A[0]) (i = 0)
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
addi $t0, $t0, 1 #i++
j read
end_read:
add $a1, $zero, $t3 #$a1 = Address(A[n-1])
j sort
nop 
after_sort:
li $v0, 10 # exit syscall
syscall
end_main:
sort:
bgt $a0, $a1, done # stop after getting to the last element (i > n-1)
nop
add $t0, $zero, $a0 # $t0 = Address(A[j]) (j = i)
loop:
beq $t0, $a2, endloop # stop after getting to the first element (j = 0)
nop
addi $t1, $t0, -4 # $t1 = Address(A[j-1])
lw $s0, 0($t0) # load array[j] into $s0
lw $s1, 0($t1) # load array[j-1] into $s1
ble $s1, $s0, endloop # stop if A[j-1] <= A[j]
nop
sw $s1, 0($t0) # store array[j-1] into array[j]
sw $s0, 0($t1) # store array[j] into array[j-1]
addi $t0, $t0, -4 # decrement j (j--)
j loop
endloop:
add $t3, $zero, $a0 # $t3 = $a0
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
bgt $s0, $a1, endprint #stop after printing the last element
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
add $a0, $zero, $t3 # set $a0 to most recent i
addi $a0, $a0, 4 # increment pointer (i++)
j sort
nop
done:
j after_sort
nop