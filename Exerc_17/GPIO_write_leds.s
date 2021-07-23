        PUBLIC GPIO_write_leds

        SECTION .text:CODE:REORDER(1)

        THUMB

GPIO_write_leds:
        STR R2, [R0, R1, LSL #2]
        STR R5, [R3, R4, LSL #2]
        BX LR
        
        END