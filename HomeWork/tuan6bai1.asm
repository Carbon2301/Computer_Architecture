.data
prompt1: .asciiz "\nEnter array length: "
prompt2: .asciiz "\nEnter a number: "
result: .asciiz "\nMax sum prefix is "
A: .word
.text
main:
la $a0, prompt1
li $v0, 4
syscall
li $v0, 5
syscall		    #nhap length vao a0
add $a1, $zero, $v0  #length = $a1
addi $t0, $zero, 0   #initialize index i in $t0 to 0
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
sw   $v0, 0($t3)    #store v0 in A[i]
addi $t0, $t0, 1
j read
end_read:
j mspfx
nop
continue:
j mspfx_end
end_of_main:
mspfx: 
addi $v0, $zero, 0 #initialize length in $v0 to 0
addi $v1, $zero, 0 #initialize max sum in $ v1to 0
addi $t0, $zero, 0 #initialize index i in $t0 to 0
addi $t1, $zero, 0 #initialize running sum in $t1 to 0
loop: 
add $t2, $t0, $t0 #put 2i in $t2
add $t2, $t2, $t2 #put 4i in $t2
add $t3, $t2, $a0 #put 4i+A (address of A[i]) in $t3
lw  $t4, 0($t3) #load A[i] from mem(t3) into $t4
add $t1, $t1, $t4 #add A[i] to running sum in $t1
slt $t5, $v1, $t1 #set $t5 to 1 if max sum < new sum
bne $t5, $zero, mdfy #if max sum is less, modify results
j test #done?
mdfy:
addi $v0, $t0, 1 #new max-sum prefix has length i+1
addi $v1, $t1, 0 #new max sum is the running sum
test:
addi $t0, $t0, 1 #advance the index i
slt $t5, $t0, $a1 #set $t5 to 1 if i<n
bne $t5, $zero, loop #repeat if i<n
done:
j continue
mspfx_end:
la $a0, result
li $v0, 4
syscall
add $a0, $zero, $v1
li $v0, 1
syscall