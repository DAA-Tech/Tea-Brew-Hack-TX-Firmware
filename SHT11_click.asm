_Init_MCU:
;SHT11_click.c,53 :: 		void Init_MCU() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;SHT11_click.c,56 :: 		GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_8, _GPIO_CFG_SPEED_50MHZ | _GPIO_CFG_OTYPE_OD | _GPIO_CFG_MODE_OUTPUT);
MOVW	R2, #2084
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Config+0
;SHT11_click.c,57 :: 		GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_7, _GPIO_CFG_SPEED_50MHZ | _GPIO_CFG_OTYPE_OD | _GPIO_CFG_MODE_OUTPUT);
MOVW	R2, #2084
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Config+0
;SHT11_click.c,59 :: 		GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_12);                            // LED GREEN
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
BL	_GPIO_Digital_Output+0
;SHT11_click.c,60 :: 		GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_13);                            // LED ORANGE
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
BL	_GPIO_Digital_Output+0
;SHT11_click.c,61 :: 		GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_14);                            // LED RED
MOVW	R1, #16384
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
BL	_GPIO_Digital_Output+0
;SHT11_click.c,62 :: 		GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_15);                           // LED BLUE
MOVW	R1, #32768
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;SHT11_click.c,63 :: 		GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_5);                             // RF_STB
MOVW	R1, #32
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
BL	_GPIO_Digital_Output+0
;SHT11_click.c,64 :: 		GPIO_Digital_Output(&GPIOE_ODR, _GPIO_PINMASK_4);                             // RF_RST
MOVW	R1, #16
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
BL	_GPIO_Digital_Output+0
;SHT11_click.c,65 :: 		GPIO_Digital_Output(&GPIOA_IDR, _GPIO_PINMASK_0);                             // Button
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_GPIO_Digital_Output+0
;SHT11_click.c,67 :: 		GPIO_Alternate_Function_Enable(&_GPIO_MODULE_USART2_PA23);
MOVW	R0, #lo_addr(__GPIO_MODULE_USART2_PA23+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART2_PA23+0)
BL	_GPIO_Alternate_Function_Enable+0
;SHT11_click.c,68 :: 		UART2_Init_Advanced(19200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART2_PA23);
MOVW	R0, #lo_addr(__GPIO_MODULE_USART2_PA23+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART2_PA23+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #19200
BL	_UART2_Init_Advanced+0
ADD	SP, SP, #4
;SHT11_click.c,76 :: 		UART6_Init_Advanced(19200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART6_PC67 );
MOVW	R0, #lo_addr(__GPIO_MODULE_USART6_PC67+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART6_PC67+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #19200
BL	_UART6_Init_Advanced+0
ADD	SP, SP, #4
;SHT11_click.c,77 :: 		Delay_ms(100);
MOVW	R7, #4521
MOVT	R7, #4
NOP
NOP
L_Init_MCU0:
SUBS	R7, R7, #1
BNE	L_Init_MCU0
NOP
NOP
;SHT11_click.c,80 :: 		USART6_CR1bits.RXNEIE = 1;         // enable uart rx interrupt
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(USART6_CR1bits+0)
MOVT	R0, #hi_addr(USART6_CR1bits+0)
STR	R1, [R0, #0]
;SHT11_click.c,81 :: 		NVIC_IntEnable(IVT_INT_USART6);    // enable interrupt vector
MOVW	R0, #87
BL	_NVIC_IntEnable+0
;SHT11_click.c,82 :: 		Enableinterrupts();
BL	_EnableInterrupts+0
;SHT11_click.c,83 :: 		}
L_end_Init_MCU:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_MCU
_interrupt:
;SHT11_click.c,87 :: 		void interrupt() iv IVT_INT_USART6 ics ICS_AUTO {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;SHT11_click.c,89 :: 		tmp = UART6_Read();                  // Store received data in the temporary variable
BL	_UART6_Read+0
; tmp start address is: 12 (R3)
UXTB	R3, R0
;SHT11_click.c,90 :: 		if ((tmp == '\r') || (rxCnt > 15)) { // Check if data counter is larger than the buffer string size
UXTB	R0, R0
CMP	R0, #13
IT	EQ
BEQ	L__interrupt20
MOVW	R0, #lo_addr(_rxCnt+0)
MOVT	R0, #hi_addr(_rxCnt+0)
LDRB	R0, [R0, #0]
CMP	R0, #15
IT	HI
BHI	L__interrupt19
IT	AL
BAL	L_interrupt4
; tmp end address is: 12 (R3)
L__interrupt20:
L__interrupt19:
;SHT11_click.c,92 :: 		rxBuff[rxCnt] = 0;                 // Terminate buffer string
MOVW	R2, #lo_addr(_rxCnt+0)
MOVT	R2, #hi_addr(_rxCnt+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_rxBuff+0)
MOVT	R0, #hi_addr(_rxBuff+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
;SHT11_click.c,93 :: 		rxCnt = 0;                         // Reset data counter
MOVS	R0, #0
STRB	R0, [R2, #0]
;SHT11_click.c,94 :: 		Received = 1;                      // Set Received data flag
MOVS	R1, #1
MOVW	R0, #lo_addr(_Received+0)
MOVT	R0, #hi_addr(_Received+0)
STRB	R1, [R0, #0]
;SHT11_click.c,95 :: 		}
IT	AL
BAL	L_interrupt5
L_interrupt4:
;SHT11_click.c,97 :: 		rxBuff[rxCnt] = tmp;               // Populate buffer string with received data
; tmp start address is: 12 (R3)
MOVW	R2, #lo_addr(_rxCnt+0)
MOVT	R2, #hi_addr(_rxCnt+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_rxBuff+0)
MOVT	R0, #hi_addr(_rxBuff+0)
ADDS	R0, R0, R1
STRB	R3, [R0, #0]
; tmp end address is: 12 (R3)
;SHT11_click.c,98 :: 		rxCnt = rxCnt + 1;                 // Increase data counter
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
STRB	R0, [R2, #0]
;SHT11_click.c,99 :: 		}
L_interrupt5:
;SHT11_click.c,100 :: 		}
L_end_interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _interrupt
_Transmit_results:
;SHT11_click.c,104 :: 		void Transmit_results(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;SHT11_click.c,106 :: 		UART6_Write_Text("Test Data\r\n");
MOVW	R0, #lo_addr(?lstr1_SHT11_click+0)
MOVT	R0, #hi_addr(?lstr1_SHT11_click+0)
BL	_UART6_Write_Text+0
;SHT11_click.c,107 :: 		Delay_Ms(2000);
MOVW	R7, #24915
MOVT	R7, #81
NOP
NOP
L_Transmit_results6:
SUBS	R7, R7, #1
BNE	L_Transmit_results6
NOP
NOP
NOP
NOP
;SHT11_click.c,115 :: 		}
L_end_Transmit_results:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Transmit_results
_main:
;SHT11_click.c,119 :: 		void main()
;SHT11_click.c,130 :: 		Init_MCU();                            // Initialize the MCU
BL	_Init_MCU+0
;SHT11_click.c,131 :: 		while(1) {
L_main8:
;SHT11_click.c,132 :: 		if (User_Button == 0)  {  // If PORTD.B0 is pressed :
MOVW	R1, #lo_addr(GPIOA_IDR+0)
MOVT	R1, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_main10
;SHT11_click.c,133 :: 		UART6_Write_Text("EchoTest\r");    // send text string
MOVW	R0, #lo_addr(?lstr2_SHT11_click+0)
MOVT	R0, #hi_addr(?lstr2_SHT11_click+0)
BL	_UART6_Write_Text+0
;SHT11_click.c,134 :: 		Delay_ms(250);                     // wait for 250ms
MOVW	R7, #11305
MOVT	R7, #10
NOP
NOP
L_main11:
SUBS	R7, R7, #1
BNE	L_main11
NOP
NOP
;SHT11_click.c,135 :: 		}
L_main10:
;SHT11_click.c,137 :: 		if(Received){                        // If data is received via UART :
MOVW	R0, #lo_addr(_Received+0)
MOVT	R0, #hi_addr(_Received+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main13
;SHT11_click.c,138 :: 		LED_RED = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;SHT11_click.c,139 :: 		Delay_Ms(1000);
MOVW	R7, #45225
MOVT	R7, #40
NOP
NOP
L_main14:
SUBS	R7, R7, #1
BNE	L_main14
NOP
NOP
;SHT11_click.c,140 :: 		LED_RED = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;SHT11_click.c,141 :: 		Received = 0;                      // clear received data flag
MOVS	R1, #0
MOVW	R0, #lo_addr(_Received+0)
MOVT	R0, #hi_addr(_Received+0)
STRB	R1, [R0, #0]
;SHT11_click.c,142 :: 		Delay_ms(250);                     // wait for 250ms
MOVW	R7, #11305
MOVT	R7, #10
NOP
NOP
L_main16:
SUBS	R7, R7, #1
BNE	L_main16
NOP
NOP
;SHT11_click.c,143 :: 		}
L_main13:
;SHT11_click.c,144 :: 		}
IT	AL
BAL	L_main8
;SHT11_click.c,145 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
