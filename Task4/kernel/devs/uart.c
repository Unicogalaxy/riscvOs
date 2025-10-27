#include"../../include/memlayout.h"
#include"../../include/defs.h"


#define RHR 0  //Receive hloding register (ReadMode)
#define THR 0  //Transmit holding register (WriteMode)
#define DLL 0  //Divisor latch register: Least Significant Byte (WriteMode)
#define IER 1  //Interrupt enable register (WriteMode)
#define IER_RX_ENABLE (1<<0)
#define IER_TX_ENABLE (1<<1)
#define DLM 1  //Divisor latch register: Most Significant Byte (WriteMode)
#define FCR 2  //FIFO control register
#define FCR_FIFO_ENABLE (1<<0)
#define FCR_FIFO_CLEAR (3<<1)
#define LCR 3  //Line control register
#define LCR_BAUD_LATCH (1<<7)  //Special mode to set baud rate
#define LCR_EIGHT_BITS (3<<0)
#define LSR 5  //Line status register
#define LSR_TX_IDLE (1<<5) 


#define Reg(reg) ((volatile unsigned char*) (UART0 + reg))
//Attention: there should be unsigned because UART use 0-255
#define ReadReg(reg) (*Reg(reg))
#define WriteReg(reg, v) (*Reg(reg) = (v))

void uart_putc(char c){
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
  ;
  WriteReg(THR, (int)c);
}

void uart_puts(const char*s){
  for(; *s; s++){
    if(*s == '\n') uart_putc('\r'); //CRLF format is more safe
    uart_putc(*s);
  }
}


void uart_init(){
  //1.Disable the interrupts
  WriteReg(IER, 0x00);
  //2.Enter the mode which sets baud rate
  WriteReg(LCR, LCR_BAUD_LATCH);
  //3.Set DLL, DLM for the baud rate
  WriteReg(DLL, 0x03); //LSB for 38.4K
  WriteReg(DLM, 0x00); //MSB for 38.4K
  //4.Leave the special mode
  //Word Length:8bit  Parity:None Why?
  WriteReg(LCR, LCR_EIGHT_BITS);
  //5.Set the FIFO
  WriteReg(FCR, (FCR_FIFO_CLEAR | FCR_FIFO_ENABLE));
  //6.Enable the interrupts
  WriteReg(IER, (IER_RX_ENABLE | IER_TX_ENABLE)); 

}


void uart_intr(){
  panic("uart_intr");
}