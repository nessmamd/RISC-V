# ENCM 369 Winter 2023 Lab 4 Exercise C
# BEGINNING of start-up & clean-up code. Do NOT edit this code.
.data
exit_msg_1:
.asciz "***About to exit. main returned "
exit_msg_2:
.asciz ".***\n"
main_rv:
.word 0
.text
# adjust sp, then call main
andi sp, sp, -32 # round sp down to multiple of 32
jal main
# when main is done, print its return value, then halt the program
sw a0, main_rv, t0
la a0, exit_msg_1
li a7, 4
ecall
lw a0, main_rv
li a7, 1
ecall
la a0, exit_msg_2
li a7, 4
ecall
lw a0, main_rv
addi a7, zero, 93 # call for program exit with exit status that is in a0
ecall
# END of start-up & clean-up code.
# void copycat(char *dest, const char *src1, const char *src2)
#
.text
.globl copycat
copycat:
#void copycat(char *dest, const char *src1, const char *src2)
#dest = string
#src1 = string
#src2 = string
#prologue
addi sp, sp, -20
sw ra, 16(sp)
sw s2, 12(sp) #storage of a2
sw s1, 8(sp) #storage of a1
sw s0, 4(sp) #storage of a0
sw s3, 0(sp) #storage of char c
mv s0, a0
mv s1, a1
mv s2, a2
#body
lbu t0, (s1) #storing t0 = *src1
while:
beq t0, zero, exit #t0 == 0
sb t0, (s0) #storing s0 in t0
addi s0, s0, 1
addi s1, s1, 1
lbu t0, (s1)
j while
exit:
dowhile:
lbu s3, (s2)
sb s3, (s0)
addi s0, s0, 1
addi s2, s2, 1
beq s3, zero, end
j dowhile
end:
#epligoue....what do we even need this because it is not being branched
lw s3, 0(sp)
lw s0, 4(sp)
lw s1, 8(sp)
lw s2, 12(sp)
lw ra, 16(sp)
addi sp, sp, 20
jr ra
# void lab4reverse(const char *str)
#
.text
.globl lab4reverse
lab4reverse:
addi sp,sp, -20
sw ra, 16(sp)
sw s1, 12(sp) #front value
sw s2, 8(sp) #back value
sw s3, 4(sp) #c value
sw s0, 0(sp) #string pointer
mv s0, a0
li s2, 0 #back = 0
okz:
add t0, s2, s0 #t0 = &str[back]
lbu t1, (t0) #t1 = str[back]
beq t1,zero, exitzz #str[back] != \0
addi s2,s2, 1 #back++
j okz
exitzz:
addi s2,s2, -1 #back--
li s1, 0
while2:
bge s1, s2, asd #back <= front
add t2, s2, s0 #t2 = back + pointer address
add t3, s1,s0 #t3 = pointer address + front
lbu t5, (t2) #t5 = str[back]
mv s3, t5 #c = str[back]
#str[back] = str[front]
lbu t4, (t3) #str[front]
sb t4 ,(t2)
#str[front] = c
sb s3, (t3)
addi s2,s2,-1 #back --
addi s1,s1,1 #front++
j while2
asd:
lw s0, 0(sp)
lw s3, 4(sp)
lw s2, 8(sp)
lw s1, 12(sp)
lw ra, 16(sp)
addi sp,sp 20
jr ra
# void print_in_quotes(const char *str)
#
.text
.globl print_in_quotes
print_in_quotes:
add t0, a0, zero # copy str to t0
addi a0, zero, '"'
li a7, 11
ecall
mv a0, t0
li a7, 4
ecall
li a0, '"'
li a7, 11
ecall
li a0, '\n'
li a7, 11
ecall
jr ra
# Global arrays of char for use in testing copycat and lab4reverse.
.data
.align 5
# char array1[32] = { '\0', '*', ..., '*' };
array1: .byte 0, '*', '*', '*', '*', '*', '*', '*'
.byte '*', '*', '*', '*', '*', '*', '*', '*'
.byte '*', '*', '*', '*', '*', '*', '*', '*'
.byte '*', '*', '*', '*', '*', '*', '*', '*'
# char array2[] = "X";
array2: .asciz "X"
# char array3[] = "YZ";
array3: .asciz "YZ"
# char array4[] = "123456";
array4: .asciz "123456"
# char array5[] = "789abcdef";
array5: .asciz "789abcdef"
# int main(void)
#
# string constants used by main
.data
sc0: .asciz ""
sc1: .asciz "good"
sc2: .asciz "bye"
sc3: .asciz "After 1st call to copycat, array1 has "
sc4: .asciz "After 2nd call to copycat, array1 has "
sc5: .asciz "After 3rd call to copycat, array1 has "
sc6: .asciz "After 4th call to copycat, array1 has "
sc7: .asciz "After use of lab4reverse, array2 has "
sc8: .asciz "After use of lab4reverse, array3 has "
sc9: .asciz "After use of lab4reverse, array4 has "
sc10: .asciz "After use of lab4reverse, array5 has "
.text
.globl main
main:
# Prologue only needs to save ra
addi sp, sp, -32
sw ra, 0(sp)
# Body
# Start tests of copycat.
la a0, array1 # a0 = array1
la a1, sc0 # a1 = sc0
la a2, sc0 # a2 = sc0
jal copycat
la a0, sc3
li a7, 4
ecall
la a0, array1 # a0 = array1
jal print_in_quotes
la a0, array1 # a0 = array1
la a1, sc1 # a1 = sc1
la a2, sc0 # a2 = sc0
jal copycat
la a0, sc4
li a7, 4
ecall
la a0, array1 # a0 = array1
jal print_in_quotes
la a0, array1 # a0 = array1
la a1, sc0 # a1 = sc0
la a2, sc2 # a2 = sc2
jal copycat
la a0, sc5
li a7, 4
ecall
la a0, array1 # a0 = array1
jal print_in_quotes
la a0, array1 # a0 = array1
la a1, sc1 # a1 = sc1
la a2, sc2 # a2 = sc2
jal copycat
la a0, sc6
li a7, 4
ecall
la a0, array1 # a0 = array1
jal print_in_quotes
# End tests of lab4cat; start tests of lab4reverse.
la a0, array2 # a0 = array2
jal lab4reverse
la a0, sc7
li a7, 4
ecall
la a0, array2 # a0 = array2
jal print_in_quotes
la a0, array3 # a0 = array3
jal lab4reverse
la a0, sc8
li a7, 4
ecall
la a0, array3 # a0 = array3
jal print_in_quotes
la a0, array4 # a0 = array4
jal lab4reverse
la a0, sc9
li a7, 4
ecall
la a0, array4 # a0 = array4
jal print_in_quotes
la a0, array5 # a0 = array5
jal lab4reverse
la a0, sc10
li a7, 4
ecall
la a0, array5 # a0 = array5
jal print_in_quotes
# End tests of lab4reverse.
mv a0, zero # r.v. from main = 0
# Epilogue
lw ra, 0(sp)
addi sp, sp, 32
