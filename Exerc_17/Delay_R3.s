        PUBLIC Delay_R3

        SECTION .text:CODE:REORDER(1)

        THUMB

Delay_R3:
        CBZ R3, exit
        SUB R3, R3, #1
        B Delay_R3
exit    
        BX LR
        
        END