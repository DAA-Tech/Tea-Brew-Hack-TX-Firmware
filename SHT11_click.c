/**************************************************************************************************
 * Project name:
 TEA Brew Hack TX (modified version of SHT11_click firmware)
 * Copyright:
     (c) DAA Technology Solutions, 2015.
 * Revision History:
     20150530: - initial release;
 * Description:
     This code demonstrates how to use mikroBUS board SHT11 click and the tRF Click
     to set up a remote warehouse monitoring system.
     SHT1x semsor uses I2C communication and measures temperature and relative humidity.
     tRF Click transfers data wirelessly using the 866MHz freq band.

 * Test configuration:
     Device:          STM32F407VC
     Oscillator:      72.000MHz
**************************************************************************************************/
//******************************************************************************
//******************************************************************************
//******************************************************************************
sbit RF_STB      at GPIOC_ODR.B5;
sbit RF_RST      at GPIOE_ODR.B4;
sbit LED_GRN     at GPIOD_ODR.B12;
sbit LED_ORNG    at GPIOD_ODR.B13;
sbit LED_RED     at GPIOD_ODR.B14;
sbit LED_BLUE    at GPIOD_ODR.B15;
sbit User_Button at GPIOA_IDR.B0;
//******************************************************************************

//SHT11 connections
sbit SDA_pin_out at GPIOB_ODR.B7;                 // Serial data pin out
sbit SDA_pin_in  at GPIOB_IDR.B7;                 // Serial data pin in
sbit SCL_pin     at GPIOB_ODR.B8;                 // Serial clock pin

// global variables
float temperature;
float rel_humidity;

char Temp_str[16], Old_Temp_str[16];
char Humi_str[16], Old_Humi_str[16];

void Read_SHT11(float *fT, float *fRH);
int oldvalue[2] = {0, 0};

char rxBuff[17];                         // Buffer string for storing data
char rxCnt = 0;                          // Counter for data writen in buffer string
unsigned short Received = 0;             // Received data flag
char lab1[17] = {0};

/**************************************************************************************************
* Init MCU
**************************************************************************************************/
void Init_MCU() {

  // Set PORTB8/7 to Open Drain output mode
  GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_8, _GPIO_CFG_SPEED_50MHZ | _GPIO_CFG_OTYPE_OD | _GPIO_CFG_MODE_OUTPUT);
  GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_7, _GPIO_CFG_SPEED_50MHZ | _GPIO_CFG_OTYPE_OD | _GPIO_CFG_MODE_OUTPUT);

  GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_12);                            // LED GREEN
  GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_13);                            // LED ORANGE
  GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_14);                            // LED RED
  GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_15);                           // LED BLUE
  GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_5);                             // RF_STB
  GPIO_Digital_Output(&GPIOE_ODR, _GPIO_PINMASK_4);                             // RF_RST
  GPIO_Digital_Output(&GPIOA_IDR, _GPIO_PINMASK_0);                             // Button

  GPIO_Alternate_Function_Enable(&_GPIO_MODULE_USART2_PA23);
  UART2_Init_Advanced(19200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART2_PA23);
  //****************************************************************************
/*UART3_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART3_PB10_11);
  Delay_ms(100);
  USART3_CR1bits.RXNEIE = 1;       // enable uart rx interrupt
  NVIC_IntEnable(IVT_INT_USART3);  // enable interrupt vector
  Delay_ms(100);                        // Wait for UART module to stabilize*/
  //****************************************************************************
  UART6_Init_Advanced(19200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART6_PC67 );
  Delay_ms(100);
  
  // Enable Usart Receiver interrupt:
  USART6_CR1bits.RXNEIE = 1;         // enable uart rx interrupt
  NVIC_IntEnable(IVT_INT_USART6);    // enable interrupt vector
  Enableinterrupts();
}
/**************************************************************************************************
// Interrupt routine
**************************************************************************************************/
void interrupt() iv IVT_INT_USART6 ics ICS_AUTO {
  char tmp;                              // Temporary variable declaration
    tmp = UART6_Read();                  // Store received data in the temporary variable
    if ((tmp == '\r') || (rxCnt > 15)) { // Check if data counter is larger than the buffer string size
                                         // or the received data is equal to the Carriage Return character
      rxBuff[rxCnt] = 0;                 // Terminate buffer string
      rxCnt = 0;                         // Reset data counter
      Received = 1;                      // Set Received data flag
    }
    else{
      rxBuff[rxCnt] = tmp;               // Populate buffer string with received data
      rxCnt = rxCnt + 1;                 // Increase data counter
    }
}
/**************************************************************************************************
* Transmit result to Receiver
**************************************************************************************************/
void Transmit_results(){
  char i;
  UART6_Write_Text("Test Data\r\n");
  Delay_Ms(2000);
/*sprintf(Temp_str, "T: %3.1f degC", temperature);
  sprintf(Humi_str, "RH: %3.1f pct", rel_humidity);*/

/*for (i = 0; i < 16; i++){
    Old_Temp_str[i] = Temp_str[i];
    Old_Humi_str[i] = Humi_str[i];
  }*/
}
/**************************************************************************************************
* MAIN PROGRAM
**************************************************************************************************/
void main()
{
/*SDA_pin_out = 1;
  // Start the test example
  while(1)                           // Endless loop
  {
    //Read_SHT11(&temperature, &rel_humidity);
    Transmit_results();
    Delay_ms(800);                   // delay 800ms
  }*/
  
  Init_MCU();                            // Initialize the MCU
  while(1) {
    if (User_Button == 0)  {  // If PORTD.B0 is pressed :
      UART6_Write_Text("EchoTest\r");    // send text string
      Delay_ms(250);                     // wait for 250ms
    }

    if(Received){                        // If data is received via UART :
      LED_RED = 1;
      Delay_Ms(1000);
      LED_RED = 0;
      Received = 0;                      // clear received data flag
      Delay_ms(250);                     // wait for 250ms
    }
  }
}

/**************************************************************************************************
* End of File
**************************************************************************************************/