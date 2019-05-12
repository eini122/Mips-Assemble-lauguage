.data
AskCircleInput: .asciiz "Enter how many circle pizza sold: "
AskSquareInput: .asciiz "Enter how many square pizza sold: "
Error: .asciiz "Please enter a vaild input"
Guess: .asciiz "Estimate the total pizzas sold in square feet: "
TotalArea: .asciiz "The total number of square feet of pizza sold is: "
CirculeArea: .asciiz "The total number of square feet of round pizza sold is: "
SquareArea: .asciiz "The total number of square feet of square pizza sold is: "
newLine: .asciiz "\n"
Yeah: "Yeah!"
Bummer: "Bummer!"
FloatZero: .float 0.0 #initail a float point for 0
RoundPizzaArea: .float 0.349 #assume pi = 3.14 and only round the first 3 decimals 
squarePizzaArea: .float 0.694 #only round the first 4 decimals
.text
main:	
	lwc1 $f5, FloatZero
	#ask user enter the circle pizza sold 
	li $v0, 4
	la $a0, AskCircleInput
	syscall
	
	#put input into register $s0
	li $v0, 5
	syscall
	add $s0, $v0, $zero
	#if the input greater 0, jump to calculate circle area, else display error message
	slt $t0, $zero, $s0
	beq $t0 $zero, DisplayError
	jal CalCircleArea
	
	#ask user enter the suqare pizza sold
	li $v0, 4
	syscall 
	la $a0, AskSquareInput
	#put input into register $s1
	li $v0, 5
	syscall
	add $s1, $v0, $zero
	#if the input is greater 0, jump to calculate suqare area, else display error message
	slt $t0, $zero, $s1
	beq $t0 $zero, DisplayError
	jal CalSquareArea
	
	#ask user enter the estimate total area of sold pizza
	li $v0, 4
	la $a0, Guess
	syscall
	#if the input is greater than 0, jump to calculate total area, else display error message
	li $v0, 6
	syscall
	add.s $f10, $f0, $f5
	c.lt.s $f10, $f5
	bc1t DisplayError
	jal CalTotalArea
	
	#display the total pizza area
	li $v0, 4
	la $a0, TotalArea
	syscall
	li $v0, 2
	add.s $f12, $f3, $f5
	syscall
	jal DisplayNewLine
	
	#display the round pizza area
	li $v0, 4
	la $a0, CirculeArea
	syscall
	li $v0, 2
	add.s $f12, $f1, $f5
	syscall
	jal DisplayNewLine
	
	#display the square pizza area
	li $v0, 4
	la $a0, SquareArea
	syscall
	li $v0, 2
	add.s $f12, $f2, $f5
	syscall
	jal DisplayNewLine
	#chech the user assum sold square feet, if user guess is greater than total, display yeah
	#else display bummer
	c.lt.s $f3, $f10
	bc1t DisplayBummer
	j DisplayYeah
	
	
	
	
CalCircleArea:
	lwc1 $f1, RoundPizzaArea #load the 8 inch round pizza area
	mtc1 $s0, $f2 #move the user input integer into float register
	cvt.s.w $f2, $f2 #convert the format from integer to float
	mul.s $f1, $f1, $f2 #calculate the round pizza area by the number of round pizza sold times the round pizza area
	jr $ra

CalSquareArea:
	lwc1 $f2, squarePizzaArea #load the 10 inch square pizza area
	mtc1 $s1, $f3 #move the user input integer into float regiaster 
	cvt.s.w $f3, $f3 #convert the format from integer to float
	mul.s $f2, $f2, $f3 #calculate the square pizza area by the number of square pizza sold times the square pizza area
	jr $ra
	
CalTotalArea:
	add.s $f3, $f1, $f2 #calculate the total area by total round pizza area plus total square pizza area
	jr $ra
	
DisplayYeah:
	#display the string yeah, and then end the program
	li $v0, 4
	la $a0, Yeah
	syscall
	j Exit
	
DisplayBummer:
	#display the string bummer, and then end the program
	li $v0, 4
	la $a0, Bummer
	syscall
	j Exit

DisplayNewLine:
	#display a new line
	li $v0, 4
	la $a0, newLine
	syscall 
	
	jr $ra
Exit:
	#end the program
	li $v0, 10
	syscall
	
	
DisplayError:
	#display the error message and jump back the program start point
	li $v0, 4
	la $a0, Error
	syscall
	jal DisplayNewLine
	
	j main
	
	
	
	
