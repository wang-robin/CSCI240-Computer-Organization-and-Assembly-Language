# Name: Robin Wang
# Last Edited: 11/25/18
# Assignment: MIPS Homework Asssignment 1 part 2
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Description of Program:
# Prompt to enter 10 values, which are stored in an array
# Compute the sum and minimum of the elements
# Display the array in a column and in reversed order
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Pseudocode in c++:
# int main(){
# 	int a[10], min, sum=0;
# 	for(int i = 0; i<10; i++){
# 		cin>>a[i];
#		if(i==0)
#			min = a[0];
#		if(a[i]<min)
#			min = a[i];
#		sum += a[i];
#	}
# 	cout<<"Sum: "<<sum<<"\nMin: "<<min;
# 	for(int i=9; i>=0; i++)
# 		cout<<a[i]<<endl;
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Register Mappings:
# $sp = stack pointer
# $t0 = counts the current index
# $t1 = constant that holds the max size of the array
# $t2 = new input
# $t3 = sum
# $t4 = min
# $s0 = current location in memory
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
.data
	Prompt: .asciiz "Enter 10 integers\n"
	Reverse: .asciiz "Array in reverse: \n"
	NewLine: .asciiz "\n"
	SUM: .asciiz "The sum of the elements is "
	MIN: .asciiz "The minimum of the elements is "
.text
	
main:
	la $a0, Prompt
	li $v0, 4
	syscall
	
	addi $sp, $sp, -40		# allocate space for 10 ints
	
	li $t0, 0			# index variable
	
	li $t1, 10			# size constant
	add $s0, $sp, $zero
	FillArray:
		
		li $v0, 5		# get input and put it into $t2
		syscall
		move $t2, $v0
					# if first entry to the array, i==0
		bne $t0, $zero, Continue
		addi $t4, $t2, 0	# set the first array entry to be min
		Continue:
		
		slt $t5, $t2, $t4	# if the new entry is less than min, it's the new min
		beq $t5, $zero, NotLess
		addi $t4, $t2, 0
		NotLess:
		
		add $t3, $t3, $t2	# recalculate sum
		
		sw $t2, 0($s0) 		# array[index] = t2
		
		addi $t0, $t0, 1	# increment index variable
		sll $s0, $t0, 2		# index * 4
		add $s0, $s0, $sp	# base addr. + offset
		
		bne $t0, $t1, FillArray 
	
	la $a0, SUM			# output the sum, min
	li $v0, 4
	syscall
	la $a0, 0($t3)
	li $v0, 1
	syscall
	la $a0, NewLine
	li $v0, 4
	syscall
	la $a0, MIN
	li $v0, 4
	syscall
	la $a0, 0($t4)
	li $v0, 1
	syscall
	la $a0, NewLine
	li $v0, 4
	syscall
	la $a0, Reverse
	li $v0, 4
	syscall
	
	PrintReverse:
		addi $t0, $t0, -1	# reduce index and the address
		sll $s0, $t0, 2
		add $s0, $s0, $sp
		
		lw $a0, 0($s0)		# output array[index] 
		li $v0, 1
		syscall
		la $a0, NewLine
		li $v0, 4
		syscall
		bne $t0, $zero, PrintReverse
	
li $v0, 10				# exit
syscall
