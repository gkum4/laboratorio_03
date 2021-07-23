        PUBLIC Delay_R0

        SECTION .text:CODE:REORDER(1)

        THUMB

Delay_R0:
        CBZ R0, exit
        SUB R0, R0, #1
        B Delay_R0
exit    
        BX LR
        
        END