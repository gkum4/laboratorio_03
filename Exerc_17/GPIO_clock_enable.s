        PUBLIC GPIO_clock_enable

        SECTION .text:CODE:REORDER(1)

        THUMB

SYSCTL_RCGCGPIO_R       EQU     0x400FE608
SYSCTL_PRGPIO_R		EQU     0x400FEA08

GPIO_clock_enable:
        LDR R2, =SYSCTL_RCGCGPIO_R
	LDR R1, [R2]
	ORR R1, R0
	STR R1, [R2]

        LDR R2, =SYSCTL_PRGPIO_R
wait	LDR R1, [R2]
	TST R1, R0
	BEQ wait

        BX LR
        
        END