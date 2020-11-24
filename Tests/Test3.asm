.data


.text

addi x1, x0, 4


addi x3, x1, 4


addi x4, x0, 20


addi x5, x0, -5


addi x8, x0, 26


jal x7, function #checking jal


addi x1, x1, 1


addi x1, x1, 2                     # checking offset of jalr
# end of program

ebreak

function:
addi x2, x0, 1

bigger_than:

addi x3, x3, 3


blt x4, x3, less_than       #checking blt works correctly

bge x5, x3, bigger_than            # checking BGE vs BGEU
fence 1, 1

bgeu x5, x3, bigger_than


less_than:
beq x3, x8, end        #check beq
ecall

bne x1, x2, function        
#checking bne and backward jumps


end:
jalr x0, x7, 4     #cheking jalr

