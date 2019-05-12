.data
prompt: .asciiz	"Please enter an interger from 0 to 100(0 to stop): "
end: .asciiz	"program end"
wrongInput: .asciiz	"The numbe is invalid, Please enter again.\n"
SumString: .asciiz	"The sum of odd integers from 0 to "
is: .asciiz " is "
input: .word	0
sum: .word	0
arr: .space	400

.text #text segment
AskInput:
	#print string that ask user enter an inter
	li $v0, 4
	la $a0, prompt
	syscall 
	#get input from user
	li $v0, 5
	syscall
	
	move $t0, $v0
	#check the input is 0 
	beq $t0, $zero, InputZero
	#check is the input less than 0
	bltz $t0, outOfRange
	#check is the input greater than 100
	bge $t0, 101, outOfRange
	sw $t0, input
	b storeValue
	
InputZero:
	#if input is 0, program end
	#print string that tell user program end
	li $v0, 4
	la $a0, end
	syscall
	#exit
	li $v0, 10
	syscall

outOfRange:
	#if input out of range, print string jump to ask user enter input again
	li $v0, 4
	la $a0, wrongInput
	syscall
	
	b AskInput
	
storeValue:
	addi $t2, $zero, 0 #value to store
	addi $t1, $t0, 1 #value to stop loop
	addi $t3, $zero, 0 #pointer
	addi $t4, $zero, 1 #count the number
	addi $t5, $zero, 1 #store the sum
loop:	
	beq $t2, $t1, calculate
	sw $t2, arr($t3)
	addi $t2, $t2, 1
	addi $t3, $t3, 4
	j loop
calculate:
	addi $t4, $t4, 2
	bgt $t4, $t0, printSum
	add $t5, $t5, $t4
	j calculate
printSum:
	sw $t5, sum
	
	li $v0, 4
	la $a0, SumString
	syscall
	
	li $v0, 1
	lw $a0, input
	syscall
	
	li $v0, 4
	la $a0, is
	syscall
	
	li $v0, 1
	lw $a0, sum
	syscall
	
	


	
	

	
	
	
	
