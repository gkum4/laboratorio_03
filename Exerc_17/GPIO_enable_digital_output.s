        PUBLIC GPIO_enable_digital_output

        SECTION .text:CODE:REORDER(1)

        THUMB
        
GPIO_DIR                EQU     0x0400
GPIO_PUR                EQU     0x0510
GPIO_DEN                EQU     0x051C

GPIO_enable_digital_output:
	LDR R2, [R0, #GPIO_DIR]
	ORR R2, R1 ; configura bits de saída
	STR R2, [R0, #GPIO_DIR]

	LDR R2, [R0, #GPIO_DEN]
	ORR R2, R1 ; habilita função digital
	STR R2, [R0, #GPIO_DEN]

        BX LR
        
        END