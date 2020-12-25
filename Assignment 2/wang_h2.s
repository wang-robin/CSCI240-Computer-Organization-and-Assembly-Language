# Name: Robin Wang
# Last Edited: 12/3/18
# Assignment: MIPS Homework Asssignment 2
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Description of Program:
# Prompt for nonnegative input n; if not in range, prompt until in range
# Calculate the recursive function 4*Func(n-1) + 5*n and output
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Pseudocode in java:
# public int function(int n){
# 	if(n==0) return 6;
# 	return 4*function(n-1) + 5*n;
# }
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Register Mappings 
# $a0 = 'n' - the nth term of the function
# $v0 = the return value of functions
# $sp = the stackpointer
# $ra = the location to jump to
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
.data
	input_message: .asciiz "Input a nonnegative integer n: "
	result_message: .asciiz "The value returned by the function [4*Fn(n-1) + 5*n] is "
.text

input:
	la $a0, input_message
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	
	slt $a0, $v0, $zero		# if input less than 0, prompt again
	bne $a0, $zero, input
	
	move $a0, $v0
	jal Func			# calls Func($a0), returns $v0
	
	move $t3, $v0			# store returned value since it's going to be wiped
	
	la $a0, result_message		# print result message
	li $v0, 4
	syscall
	la $a0, 0($t3)
	li $v0, 1
	syscall
	
	li $v0, 10			# exit
	syscall
Func:
	addi $sp, $sp, -8		# add a new stackframe
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	li $v0, 6			# base case
	beq $a0, $zero, FnDone
	
	addi $a0, $a0, -1		# recursive case
	jal Func
	
	lw $t0, 4($sp)			# calculation of the answer
	sll $v0, $v0, 2
	mul $t0, $t0, 5
	add $v0, $v0, $t0
FnDone:
	lw $ra, 0($sp)			# remove a stackframe
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	jr $ra