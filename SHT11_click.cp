#line 1 "C:/Users/ayo/Google Drive/DAA STEM Academy/Hack Software/Tea Brew Hack Firmware/Tea Brew Hack TX Firmware/SHT11_click.c"
#line 21 "C:/Users/ayo/Google Drive/DAA STEM Academy/Hack Software/Tea Brew Hack Firmware/Tea Brew Hack TX Firmware/SHT11_click.c"
sbit RF_STB at GPIOC_ODR.B5;
sbit RF_RST at GPIOE_ODR.B4;
sbit LED_GRN at GPIOD_ODR.B12;
sbit LED_ORNG at GPIOD_ODR.B13;
sbit LED_RED at GPIOD_ODR.B14;
sbit LED_BLUE at GPIOD_ODR.B15;
sbit User_Button at GPIOA_IDR.B0;



sbit SDA_pin_out at GPIOB_ODR.B7;
sbit SDA_pin_in at GPIOB_IDR.B7;
sbit SCL_pin at GPIOB_ODR.B8;


float temperature;
float rel_humidity;

char Temp_str[16], Old_Temp_str[16];
char Humi_str[16], Old_Humi_str[16];

void Read_SHT11(float *fT, float *fRH);
int oldvalue[2] = {0, 0};

char rxBuff[17];
char rxCnt = 0;
unsigned short Received = 0;
char lab1[17] = {0};
#line 53 "C:/Users/ayo/Google Drive/DAA STEM Academy/Hack Software/Tea Brew Hack Firmware/Tea Brew Hack TX Firmware/SHT11_click.c"
void Init_MCU() {


 GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_8, _GPIO_CFG_SPEED_50MHZ | _GPIO_CFG_OTYPE_OD | _GPIO_CFG_MODE_OUTPUT);
 GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_7, _GPIO_CFG_SPEED_50MHZ | _GPIO_CFG_OTYPE_OD | _GPIO_CFG_MODE_OUTPUT);

 GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_12);
 GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_13);
 GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_14);
 GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_15);
 GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_5);
 GPIO_Digital_Output(&GPIOE_ODR, _GPIO_PINMASK_4);
 GPIO_Digital_Output(&GPIOA_IDR, _GPIO_PINMASK_0);

 GPIO_Alternate_Function_Enable(&_GPIO_MODULE_USART2_PA23);
 UART2_Init_Advanced(19200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART2_PA23);
#line 76 "C:/Users/ayo/Google Drive/DAA STEM Academy/Hack Software/Tea Brew Hack Firmware/Tea Brew Hack TX Firmware/SHT11_click.c"
 UART6_Init_Advanced(19200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART6_PC67 );
 Delay_ms(100);


 USART6_CR1bits.RXNEIE = 1;
 NVIC_IntEnable(IVT_INT_USART6);
 Enableinterrupts();
}
#line 87 "C:/Users/ayo/Google Drive/DAA STEM Academy/Hack Software/Tea Brew Hack Firmware/Tea Brew Hack TX Firmware/SHT11_click.c"
void interrupt() iv IVT_INT_USART6 ics ICS_AUTO {
 char tmp;
 tmp = UART6_Read();
 if ((tmp == '\r') || (rxCnt > 15)) {

 rxBuff[rxCnt] = 0;
 rxCnt = 0;
 Received = 1;
 }
 else{
 rxBuff[rxCnt] = tmp;
 rxCnt = rxCnt + 1;
 }
}
#line 104 "C:/Users/ayo/Google Drive/DAA STEM Academy/Hack Software/Tea Brew Hack Firmware/Tea Brew Hack TX Firmware/SHT11_click.c"
void Transmit_results(){
 char i;
 UART6_Write_Text("Test Data\r\n");
 Delay_Ms(2000);
#line 115 "C:/Users/ayo/Google Drive/DAA STEM Academy/Hack Software/Tea Brew Hack Firmware/Tea Brew Hack TX Firmware/SHT11_click.c"
}
#line 119 "C:/Users/ayo/Google Drive/DAA STEM Academy/Hack Software/Tea Brew Hack Firmware/Tea Brew Hack TX Firmware/SHT11_click.c"
void main()
{
#line 130 "C:/Users/ayo/Google Drive/DAA STEM Academy/Hack Software/Tea Brew Hack Firmware/Tea Brew Hack TX Firmware/SHT11_click.c"
 Init_MCU();
 while(1) {
 if (User_Button == 0) {
 UART6_Write_Text("EchoTest\r");
 Delay_ms(250);
 }

 if(Received){
 LED_RED = 1;
 Delay_Ms(1000);
 LED_RED = 0;
 Received = 0;
 Delay_ms(250);
 }
 }
}
