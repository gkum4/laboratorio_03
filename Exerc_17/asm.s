        PUBLIC  __iar_program_start
        PUBLIC  __vector_table
        EXTERN GPIO_clock_enable
        EXTERN GPIO_write_leds
        EXTERN GPIO_enable_digital_output
        EXTERN Delay_R0
        EXTERN Delay_R3

        SECTION .text:CODE:REORDER(2)
        
        ;; Keep vector table even if it's not referenced
        REQUIRE __vector_table
        
        THUMB

; System Control definitions
SYSCTL_RCGCGPIO_R       EQU     0x400FE608
SYSCTL_PRGPIO_R		EQU     0x400FEA08
PORTF_BIT               EQU     0000000000100000b ; bit  5 = Port F
PORTJ_BIT               EQU     0000000100000000b ; bit  8 = Port J
PORTN_BIT               EQU     0001000000000000b ; bit 12 = Port N

; GPIO Port definitions
GPIO_PORTF_BASE    	EQU     0x4005D000
GPIO_PORTJ_BASE    	EQU     0x40060000
GPIO_PORTN_BASE    	EQU     0x40064000


; PROGRAMA PRINCIPAL

__iar_program_start
        
main:   
        
        MOV R0, #(PORTN_BIT | PORTF_BIT)
	BL GPIO_clock_enable ; enable clock port N and port F
        
	LDR R0, =GPIO_PORTN_BASE
        MOV R1, #00000011b ; bits 0 and 1 (LEDs D1 and D2)
        BL GPIO_enable_digital_output
        
        LDR R0, =GPIO_PORTF_BASE
        MOV R1, #00010001b ; bits 0 and 4 (LEDs D4 and D3)
        BL GPIO_enable_digital_output
       
        LDR R0, = GPIO_PORTN_BASE
        MOV R1, #00000011b ; LEDs D1 and D2 mask
        MOV R2, #00000001b

        LDR R3, = GPIO_PORTF_BASE
        MOV R4, #00010001b ; LEDs D3 and D4 mask
        MOV R5, #00000001b   

loop:   BL GPIO_write_leds; write LEDs D1, D2, D3, D4
        PUSH {R0}
        PUSH {R3}
        MOVT R0, #0x003F
        MOVT R3, #0x0001
        BL Delay_R0
        BL Delay_R3
        POP {R3}
        POP {R0}
        
        EOR R2, R2, #11b
        EOR R5, R5, #10001b
        B loop

        ;; Forward declaration of sections.
        SECTION CSTACK:DATA:NOROOT(3)
        SECTION .intvec:CODE:NOROOT(2)
        
        DATA

__vector_table
        DCD     sfe(CSTACK)
        DCD     __iar_program_start

        DCD     NMI_Handler
        DCD     HardFault_Handler
        DCD     MemManage_Handler
        DCD     BusFault_Handler
        DCD     UsageFault_Handler
        DCD     0
        DCD     0
        DCD     0
        DCD     0
        DCD     SVC_Handler
        DCD     DebugMon_Handler
        DCD     0
        DCD     PendSV_Handler
        DCD     SysTick_Handler

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default interrupt handlers.
;;

        PUBWEAK NMI_Handler
        PUBWEAK HardFault_Handler
        PUBWEAK MemManage_Handler
        PUBWEAK BusFault_Handler
        PUBWEAK UsageFault_Handler
        PUBWEAK SVC_Handler
        PUBWEAK DebugMon_Handler
        PUBWEAK PendSV_Handler
        PUBWEAK SysTick_Handler

        SECTION .text:CODE:REORDER:NOROOT(1)
        THUMB

NMI_Handler
HardFault_Handler
MemManage_Handler
BusFault_Handler
UsageFault_Handler
SVC_Handler
DebugMon_Handler
PendSV_Handler
SysTick_Handler
Default_Handler
__default_handler
        CALL_GRAPH_ROOT __default_handler, "interrupt"
        NOCALL __default_handler
        B __default_handler

        END

