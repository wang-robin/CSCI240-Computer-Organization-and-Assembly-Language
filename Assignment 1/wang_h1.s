# Name: Robin Wang
# Last Edited: 11/25/18
# Assignment: MIPS Homework Asssignment 1 part 1
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Description of Program:
# Prompt for input ranging from [-30,-10] then a second one greater than 5; ask again if not in range.
# Add int 1 to 32 times the second then subtract 28. Repeat from the beginning until a sentinel of 999 is inputted for the first integer.
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Pseudocode in c++:
# int main(){
#	int first, second;
#	while(){
#		do{
# 			cout<<"Enter a number in the range [-30,-10].\n"
# 			cin>>first;
#			if(first == 999) exit(0);
#		}
#		while(first<-30 || first>-10);
#		do{
#			cout<<"Enter a number greater than 5.\n"
#			cin>>second;
#		}
#		while(second<6);
#		cout<<first<<"+32*"<<second<<"-28="<<first+32*second-28<<endl;
#	}
# }
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Register Mappings:
# $t0 = int1
# $t1 = int2
# $t3 = final answer 
# (registers are reused in the middle of the program but in the end, hold the given values)
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
.data
	Int1Prompt: .asciiz "Enter a number in the range [-30, -10]."
	Int2Prompt: .asciiz "Enter a number greater than 5."
	Plus: .asciiz " + 32*"
	Minus: .asciiz " - 28 = "
	PeriodNewLine: .asciiz ".\n"
	NewLine: .asciiz "\n"
.text

main:
	FirstInputLoop: 
		la $a0, Int1Prompt	# output Int1Prompt
		li $v0, 4
		syscall
		la $a0, NewLine
		li $v0, 4
		syscall
					# read the int input
		li $v0, 5
		syscall
		
		move $t0, $v0		# $t0 <- int1

		li $t1, 999		# if 999 then done
		beq $t0, $t1, Done
		
		slti $t1, $t0, -9	# if not in range [-30, -10], repeat
		li $t3, -31
		slt $t2, $t3, $t0	# using condit1 < condit2 but swapped conditions to condit2 < condit1 so it's now greater than
		and $t3, $t2, $t1
		beq $t3, $zero, FirstInputLoop
		
	SecondInputLoop:
		la $a0, Int2Prompt	#output Int2Prompt 
		li $v0, 4
		syscall
		la $a0, NewLine
		li $v0, 4
		syscall
		
		li $v0, 5		# read the int input
		syscall
		
		move $t1, $v0		# $t1 <- int2
		
		slti $a1, $t1, 6	# if less than or equal to 5 then repeat
		bne $a1, $zero, SecondInputLoop
	
	sll $t2, $t1, 5			# evaluate the expression
	add $t3, $t0, $t2
	addi $t3, $t3, -28
	
	la $a0, 0($t0)			# output int1 + 32*int2 - 28 = "Answer"
	li $v0, 1
	syscall
	la $a0, Plus
	li $v0, 4
	syscall
	la $a0, 0($t1)
	li $v0, 1
	syscall
	la $a0, Minus
	li $v0, 4
	syscall
	la $a0, 0($t3)
	li $v0, 1
	syscall
	la $a0, PeriodNewLine
	li $v0, 4
	syscall
	j main
Done: 					#exit
	li $v0, 10
	syscall
		
	
