#line 1 "C:/Users/foobar/Desktop/331 Project/Securitas/Securitas.c"
#line 1 "c:/users/foobar/desktop/331 project/securitas/ssd1306.c"
#line 1 "a:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;



typedef signed char int_fast8_t;
typedef signed int int_fast16_t;
typedef signed long int int_fast32_t;


typedef unsigned char uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned long int uint_fast32_t;


typedef signed int intptr_t;
typedef unsigned int uintptr_t;


typedef signed long int intmax_t;
typedef unsigned long int uintmax_t;
#line 72 "c:/users/foobar/desktop/331 project/securitas/ssd1306.c"
uint8_t _i2caddr, _vccstate, x_pos = 1, y_pos = 1, wrap = 1;
#line 96 "c:/users/foobar/desktop/331 project/securitas/ssd1306.c"
const char Font[] = {
0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x5F, 0x00, 0x00,
0x00, 0x07, 0x00, 0x07, 0x00,
0x14, 0x7F, 0x14, 0x7F, 0x14,
0x24, 0x2A, 0x7F, 0x2A, 0x12,
0x23, 0x13, 0x08, 0x64, 0x62,
0x36, 0x49, 0x56, 0x20, 0x50,
0x00, 0x08, 0x07, 0x03, 0x00,
0x00, 0x1C, 0x22, 0x41, 0x00,
0x00, 0x41, 0x22, 0x1C, 0x00,
0x2A, 0x1C, 0x7F, 0x1C, 0x2A,
0x08, 0x08, 0x3E, 0x08, 0x08,
0x00, 0x80, 0x70, 0x30, 0x00,
0x08, 0x08, 0x08, 0x08, 0x08,
0x00, 0x00, 0x60, 0x60, 0x00,
0x20, 0x10, 0x08, 0x04, 0x02,
0x3E, 0x51, 0x49, 0x45, 0x3E,
0x00, 0x42, 0x7F, 0x40, 0x00,
0x72, 0x49, 0x49, 0x49, 0x46,
0x21, 0x41, 0x49, 0x4D, 0x33,
0x18, 0x14, 0x12, 0x7F, 0x10,
0x27, 0x45, 0x45, 0x45, 0x39,
0x3C, 0x4A, 0x49, 0x49, 0x31,
0x41, 0x21, 0x11, 0x09, 0x07,
0x36, 0x49, 0x49, 0x49, 0x36,
0x46, 0x49, 0x49, 0x29, 0x1E,
0x00, 0x00, 0x14, 0x00, 0x00,
0x00, 0x40, 0x34, 0x00, 0x00,
0x00, 0x08, 0x14, 0x22, 0x41,
0x14, 0x14, 0x14, 0x14, 0x14,
0x00, 0x41, 0x22, 0x14, 0x08,
0x02, 0x01, 0x59, 0x09, 0x06,
0x3E, 0x41, 0x5D, 0x59, 0x4E,
0x7C, 0x12, 0x11, 0x12, 0x7C,
0x7F, 0x49, 0x49, 0x49, 0x36,
0x3E, 0x41, 0x41, 0x41, 0x22,
0x7F, 0x41, 0x41, 0x41, 0x3E,
0x7F, 0x49, 0x49, 0x49, 0x41,
0x7F, 0x09, 0x09, 0x09, 0x01,
0x3E, 0x41, 0x41, 0x51, 0x73,
0x7F, 0x08, 0x08, 0x08, 0x7F,
0x00, 0x41, 0x7F, 0x41, 0x00,
0x20, 0x40, 0x41, 0x3F, 0x01,
0x7F, 0x08, 0x14, 0x22, 0x41,
0x7F, 0x40, 0x40, 0x40, 0x40,
0x7F, 0x02, 0x1C, 0x02, 0x7F,
0x7F, 0x04, 0x08, 0x10, 0x7F,
0x3E, 0x41, 0x41, 0x41, 0x3E,
0x7F, 0x09, 0x09, 0x09, 0x06,
0x3E, 0x41, 0x51, 0x21, 0x5E,
0x7F, 0x09, 0x19, 0x29, 0x46,
0x26, 0x49, 0x49, 0x49, 0x32,
0x03, 0x01, 0x7F, 0x01, 0x03,
0x3F, 0x40, 0x40, 0x40, 0x3F,
0x1F, 0x20, 0x40, 0x20, 0x1F,
0x3F, 0x40, 0x38, 0x40, 0x3F,
0x63, 0x14, 0x08, 0x14, 0x63,
0x03, 0x04, 0x78, 0x04, 0x03,
0x61, 0x59, 0x49, 0x4D, 0x43,
0x00, 0x7F, 0x41, 0x41, 0x41,
0x02, 0x04, 0x08, 0x10, 0x20,
0x00, 0x41, 0x41, 0x41, 0x7F,
0x04, 0x02, 0x01, 0x02, 0x04,
0x40, 0x40, 0x40, 0x40, 0x40,
0x00, 0x03, 0x07, 0x08, 0x00,
0x20, 0x54, 0x54, 0x78, 0x40,
0x7F, 0x28, 0x44, 0x44, 0x38,
0x38, 0x44, 0x44, 0x44, 0x28,
0x38, 0x44, 0x44, 0x28, 0x7F,
0x38, 0x54, 0x54, 0x54, 0x18,
0x00, 0x08, 0x7E, 0x09, 0x02,
0x18, 0xA4, 0xA4, 0x9C, 0x78,
0x7F, 0x08, 0x04, 0x04, 0x78,
0x00, 0x44, 0x7D, 0x40, 0x00,
0x20, 0x40, 0x40, 0x3D, 0x00,
0x7F, 0x10, 0x28, 0x44, 0x00,
0x00, 0x41, 0x7F, 0x40, 0x00,
0x7C, 0x04, 0x78, 0x04, 0x78,
0x7C, 0x08, 0x04, 0x04, 0x78,
0x38, 0x44, 0x44, 0x44, 0x38,
0xFC, 0x18, 0x24, 0x24, 0x18,
0x18, 0x24, 0x24, 0x18, 0xFC,
0x7C, 0x08, 0x04, 0x04, 0x08,
0x48, 0x54, 0x54, 0x54, 0x24,
0x04, 0x04, 0x3F, 0x44, 0x24,
0x3C, 0x40, 0x40, 0x20, 0x7C,
0x1C, 0x20, 0x40, 0x20, 0x1C,
0x3C, 0x40, 0x30, 0x40, 0x3C,
0x44, 0x28, 0x10, 0x28, 0x44,
0x4C, 0x90, 0x90, 0x90, 0x7C,
0x44, 0x64, 0x54, 0x4C, 0x44,
0x00, 0x08, 0x36, 0x41, 0x00,
0x00, 0x00, 0x77, 0x00, 0x00,
0x00, 0x41, 0x36, 0x08, 0x00,
0x02, 0x01, 0x02, 0x04, 0x02
};

void ssd1306_command(uint8_t c) {
 uint8_t control = 0x00;
  I2C1_Start ();
  I2C1_Wr (_i2caddr);
  I2C1_Wr (control);
  I2C1_Wr (c);
  I2C1_Stop ();
}

void SSD1306_Init(uint8_t vccstate, uint8_t i2caddr) {
 _vccstate = vccstate;
 _i2caddr = i2caddr;

  RA0_bit  = 0;

  TRISA0_bit  = 0;

 delay_ms(10);
  RA0_bit  = 1;


 ssd1306_command( 0xAE );
 ssd1306_command( 0xD5 );
 ssd1306_command(0x80);

 ssd1306_command( 0xA8 );
 ssd1306_command( 64  - 1);

 ssd1306_command( 0xD3 );
 ssd1306_command(0x0);
 ssd1306_command( 0x40  | 0x0);
 ssd1306_command( 0x8D );
 if (vccstate ==  0x01 )
 { ssd1306_command(0x10); }
 else
 { ssd1306_command(0x14); }
 ssd1306_command( 0x20 );
 ssd1306_command(0x00);
 ssd1306_command( 0xA0  | 0x1);
 ssd1306_command( 0xC8 );








 ssd1306_command( 0xDA );
 ssd1306_command(0x12);
 ssd1306_command( 0x81 );
 if (vccstate ==  0x01 )
 { ssd1306_command(0x9F); }
 else
 { ssd1306_command(0xCF); }
#line 261 "c:/users/foobar/desktop/331 project/securitas/ssd1306.c"
 ssd1306_command( 0xD9 );
 if (vccstate ==  0x01 )
 { ssd1306_command(0x22); }
 else
 { ssd1306_command(0xF1); }
 ssd1306_command( 0xDB );
 ssd1306_command(0x40);
 ssd1306_command( 0xA4 );
 ssd1306_command( 0xA6 );

 ssd1306_command( 0x2E );

 ssd1306_command( 0xAF );
}

void SSD1306_StartScrollRight(uint8_t start, uint8_t stop) {
 ssd1306_command( 0x26 );
 ssd1306_command(0X00);
 ssd1306_command(start);
 ssd1306_command(0X00);
 ssd1306_command(stop);
 ssd1306_command(0X00);
 ssd1306_command(0XFF);
 ssd1306_command( 0x2F );
}

void SSD1306_StartScrollLeft(uint8_t start, uint8_t stop) {
 ssd1306_command( 0x27 );
 ssd1306_command(0X00);
 ssd1306_command(start);
 ssd1306_command(0X00);
 ssd1306_command(stop);
 ssd1306_command(0X00);
 ssd1306_command(0XFF);
 ssd1306_command( 0x2F );
}

void SSD1306_StartScrollDiagRight(uint8_t start, uint8_t stop) {
 ssd1306_command( 0xA3 );
 ssd1306_command(0X00);
 ssd1306_command( 64 );
 ssd1306_command( 0x29 );
 ssd1306_command(0X00);
 ssd1306_command(start);
 ssd1306_command(0X00);
 ssd1306_command(stop);
 ssd1306_command(0X01);
 ssd1306_command( 0x2F );
}

void SSD1306_StartScrollDiagLeft(uint8_t start, uint8_t stop) {
 ssd1306_command( 0xA3 );
 ssd1306_command(0X00);
 ssd1306_command( 64 );
 ssd1306_command( 0x2A );
 ssd1306_command(0X00);
 ssd1306_command(start);
 ssd1306_command(0X00);
 ssd1306_command(stop);
 ssd1306_command(0X01);
 ssd1306_command( 0x2F );
}

void SSD1306_StopScroll(void) {
 ssd1306_command( 0x2E );
}

void SSD1306_Dim(uint8_t dim) {
 uint8_t contrast;
 if (dim & 1)
 contrast = 0;
 else {
 if (_vccstate ==  0x01 )
 contrast = 0x9F;
 else
 contrast = 0xCF;
 }


 ssd1306_command( 0x81 );
 ssd1306_command(contrast);
}

void SSD1306_SetTextWrap(uint8_t w) {
 wrap = w & 1;
}

void SSD1306_InvertDisplay(uint8_t i) {
 if (i & 1)
 ssd1306_command( 0xA7 );
 else
 ssd1306_command( 0xA6 );
}

void SSD1306_GotoXY(uint8_t x, uint8_t y) {
 if((x >  128  / 6) || y >  64  / 8)
 return;
 x_pos = x;
 y_pos = y;
}

void SSD1306_PutC(char c) {
 uint8_t i, font_c;
 if((c < ' ') || (c > '~'))
 c = '?';
 ssd1306_command( 0x21 );
 ssd1306_command(6 * (x_pos - 1));
 ssd1306_command(6 * (x_pos - 1) + 4);

 ssd1306_command( 0x22 );
 ssd1306_command(y_pos - 1);
 ssd1306_command(y_pos - 1);

  I2C1_Start ();
  I2C1_Wr (_i2caddr);
  I2C1_Wr (0x40);

 for(i = 0; i < 5; i++ ) {
 font_c = font[(c - 32) * 5 + i];

  I2C1_Wr (font_c);
 }
  I2C1_Stop ();


 x_pos = x_pos % 21 + 1;
 if (wrap && (x_pos == 1))

 y_pos = y_pos % 8 + 1;
#line 400 "c:/users/foobar/desktop/331 project/securitas/ssd1306.c"
}

void SSD1306_PutCustomC(char *c) {
 uint8_t i, line;
 ssd1306_command( 0x21 );
 ssd1306_command(6 * (x_pos - 1));
 ssd1306_command(6 * (x_pos - 1) + 4);

 ssd1306_command( 0x22 );
 ssd1306_command(y_pos - 1);
 ssd1306_command(y_pos - 1);

  I2C1_Start ();
  I2C1_Wr (_i2caddr);
  I2C1_Wr (0x40);

 for(i = 0; i < 5; i++ ) {
 line = c[i];
  I2C1_Wr (line);
 }
  I2C1_Stop ();


 x_pos = x_pos % 21 + 1;
 if (wrap && (x_pos == 1))

 y_pos = y_pos % 8 + 1;
#line 437 "c:/users/foobar/desktop/331 project/securitas/ssd1306.c"
}

void SSD1306_Print(char *s) {
 uint8_t i = 0;
 while (s[i] != '\0'){
 if (s[i] == ' ' & x_pos == 1)
 i++;
 else
 SSD1306_PutC(s[i++]);
 }
}

void SSD1306_ClearDisplay() {
 uint16_t i;
 ssd1306_command( 0x21 );
 ssd1306_command(0);

 ssd1306_command(127);
#line 459 "c:/users/foobar/desktop/331 project/securitas/ssd1306.c"
 ssd1306_command( 0x22 );
 ssd1306_command(0);

 ssd1306_command(7);
#line 469 "c:/users/foobar/desktop/331 project/securitas/ssd1306.c"
  I2C1_Start ();
  I2C1_Wr (_i2caddr);
  I2C1_Wr (0x40);

 for(i = 0; i <  64  *  128  / 8; i++ )
  I2C1_Wr (0);

  I2C1_Stop ();

}

void SSD1306_FillScreen() {
 uint16_t i;
 ssd1306_command( 0x21 );
 ssd1306_command(0);

 ssd1306_command(127);
#line 490 "c:/users/foobar/desktop/331 project/securitas/ssd1306.c"
 ssd1306_command( 0x22 );
 ssd1306_command(0);

 ssd1306_command(7);
#line 500 "c:/users/foobar/desktop/331 project/securitas/ssd1306.c"
  I2C1_Start ();
  I2C1_Wr (_i2caddr);
  I2C1_Wr (0x40);

 for(i = 0; i <  64  *  128  / 8; i++ )
  I2C1_Wr (0xFF);

  I2C1_Stop ();

}
#line 22 "C:/Users/foobar/Desktop/331 Project/Securitas/Securitas.c"
unsigned int i;
#line 27 "C:/Users/foobar/Desktop/331 Project/Securitas/Securitas.c"
unsigned char memChar;
int userExists;
char inputPinCode[4] = {'0','0','0','0'};
char memoryPinCode[4] = {'0','0','0','0'};
char currentUser;

unsigned char readEEPROM(unsigned char address);
void writeEEPROM(unsigned char address, unsigned char datas);
int isUserExistent(char user);
int getUserNumber(char user);
int pinMatched();
void getPinFromMemory(char user);
#line 43 "C:/Users/foobar/Desktop/331 Project/Securitas/Securitas.c"
unsigned char keyPressed = 0;
unsigned char KEY_ARRAY[4][4] = {{'7', '8', '9', 'A'}, {'4', '5', '6', 'B'}, {'1', '2', '3', 'C'}, {'F', '0', 'E', 'D'}};
unsigned char keypadRow, keypadColumn;

unsigned char keypadKey();
#line 52 "C:/Users/foobar/Desktop/331 Project/Securitas/Securitas.c"
void printToXY(int row, int col, char *str, int flagClearScreen);
#line 57 "C:/Users/foobar/Desktop/331 Project/Securitas/Securitas.c"
void rotate0Deg();
void rotate90Deg();
#line 64 "C:/Users/foobar/Desktop/331 Project/Securitas/Securitas.c"
void mainMenuView();
void mainMenuInputHandler();

void openLockerView();
void openLockerInputHandler();

void changePinView();
void changePinInputHandler();

void addUserView();
void addUserViewInputHandler();

void removeUserView();
void removeUserInputHandler();

void aboutView();
void aboutViewInputHandler();



void main()
{


 TRISA = 0b11111111;


 TRISD = 0XF0;
 OPTION_REG &= 0X7F;


 TRISB = 0;

 I2C1_Init(400000);


 SSD1306_Init( 0x02 ,  0x7A );

 SSD1306_ClearDisplay();

 if( !isUserExistent('A') ){


 writeEEPROM(0, 1);
 writeEEPROM(1, '1');
 writeEEPROM(2, '2');
 writeEEPROM(3, '3');
 writeEEPROM(4, '4');
 }


 while (1){
 mainMenuView();
 mainMenuInputHandler();
 }




}




void mainMenuView(){
 printToXY(1, 1, "Securitas!", 1);
 printToXY(2, 2, "1.Open", 0);
 printToXY(3, 2, "2.Cng", 0);
 printToXY(4, 2, "3.Add", 0);
 printToXY(5, 2, "4.Rmv", 0);
 printToXY(6, 2, "5.Inf", 0);
 delay_ms(500);
}

void mainMenuInputHandler()
{
 keyPressed = keyPadKey();

 switch (keyPressed)
 {
 case '1':
 openLockerView();
 openLockerInputHandler();
 break;
 case '2':
 break;
 case '3':
 break;
 case '4':
 break;
 case '5':
 aboutView();
 aboutViewInputHandler();
 break;
 default:
 printToXY(1, 1, "Wrong!", 1);
 delay_ms(2000);
 break;
 }
}

void openLockerView() {
 printToXY(1, 1, "User:", 1);
 printToXY(2, 2, "[A] [B] [C] [D]", 0);
}

void openLockerInputHandler() {
 keyPressed = keyPadKey();
#line 178 "C:/Users/foobar/Desktop/331 Project/Securitas/Securitas.c"
 userExists = isUserExistent(keyPressed);
 if(userExists){
 printToXY(1,1,"Enter Pin: ",1);

 currentUser = keyPressed;

 keyPressed = keyPadKey();
 delay_ms(400);
 inputPinCode[3] = keyPressed;
 SSD1306_GotoXY( 2, 3);
 SSD1306_PUTC(keyPressed);

 keyPressed = keyPadKey();
 delay_ms(400);
 inputPinCode[2] = keyPressed;
 SSD1306_GotoXY( 3, 3);
 SSD1306_PUTC(keyPressed);

 keyPressed = keyPadKey();
 delay_ms(400);
 inputPinCode[1] = keyPressed;
 SSD1306_GotoXY( 4, 3);
 SSD1306_PUTC(keyPressed);

 keyPressed = keyPadKey();
 delay_ms(400);
 inputPinCode[0] = keyPressed;
 SSD1306_GotoXY( 5, 3);
 SSD1306_PUTC(keyPressed);

 getPinFromMemory(currentUser);

 if(pinMatched()){
 rotate90Deg();
 printToXY(1,1,"Lock Opened!",1);
 keyPressed = keyPadKey();
 rotate0Deg();
 return;
 }
 else{
 printToXY(1,1,"Wrong Pin!",1);
 delay_ms(1500);
 return;
 }


 }
 else {
 printToXY(1,1,"Intruder!",1);
 delay_ms(1500);
 }
}

void changePinView()
{
}
void changePinInputHandler() {}

void addUserView() {}
void addUserViewInputHandler() {}

void removeUserView() {}
void removeUserInputHandler() {}

void aboutView()
{
#line 249 "C:/Users/foobar/Desktop/331 Project/Securitas/Securitas.c"
}

void aboutViewInputHandler()
{
 keyPressed = keyPadKey();
}

unsigned char keypadKey()
{
#line 262 "C:/Users/foobar/Desktop/331 Project/Securitas/Securitas.c"
 PORTD = 0x00;

 while (1)
 {
  RD0_bit  = 1;
  RD1_bit  =  RD2_bit  =  RD3_bit  = 0;
 SSD1306_GotoXY(1, 1);
 if ( RD4_bit  ||  RD5_bit  ||  RD6_bit  ||  RD7_bit )
 {
 keypadRow = 0;
 break;
 }
  RD1_bit  = 1;
  RD0_bit  = 0;
 if ( RD4_bit  ||  RD5_bit  ||  RD6_bit  ||  RD7_bit )
 {
 keypadRow = 1;
 break;
 }
  RD2_bit  = 1;
  RD1_bit  = 0;
 if ( RD4_bit  ||  RD5_bit  ||  RD6_bit  ||  RD7_bit )
 {
 keypadRow = 2;
 break;
 }
  RD3_bit  = 1;
  RD2_bit  = 0;
 if ( RD4_bit  ||  RD5_bit  ||  RD6_bit  ||  RD7_bit )
 {
 keypadRow = 3;
 break;
 }
 }

 if ( RD4_bit  == 1)
 {
 keypadColumn = 0;
 }
 else if ( RD5_bit  == 1)
 {
 keypadColumn = 1;
 }
 else if ( RD6_bit  == 1)
 {
 keypadColumn = 2;
 }
 else if ( RD7_bit  == 1)
 {
 keypadColumn = 3;
 }

 return (KEY_ARRAY[keypadRow][keypadColumn]);
}

void printToXY(int row, int col, char *str, int flagClearScreen)
{
 if (flagClearScreen)
 {
 SSD1306_ClearDisplay();
 }
 SSD1306_GotoXY(col, row);
 SSD1306_Print(str);
}

unsigned char readEEPROM(unsigned char address)
{
 EEADR = address;
 EECON1.EEPGD = 0;
 EECON1.RD = 1;
 return EEDATA;
}

void writeEEPROM(unsigned char address, unsigned char datas)
{
 unsigned char INTCON_SAVE;
 EEADR = address;
 EEDATA = datas;
 EECON1.EEPGD = 0;
 EECON1.WREN = 1;
 INTCON_SAVE=INTCON;
 INTCON=0;
 EECON2=0x55;
 EECON2=0xAA;
 EECON1.WR = 1;
 INTCON = INTCON_SAVE;
 EECON1.WREN = 0;
 while(PIR2.EEIF == 0)
 { }
 PIR2.EEIF = 0;
}

int getUserNumber(char user){
 int userNum;
 switch(user){
 case 'A':
 userNum = 0;
 break;
 case 'B':
 userNum = 1;
 break;
 case 'C':
 userNum = 2;
 break;
 case 'D':
 userNum = 3;
 break;
 }
 return userNum;
}

int isUserExistent(char user){
 int userNum;
 switch(user){
 case 'A':
 userNum = 0;
 break;
 case 'B':
 userNum = 1;
 break;
 case 'C':
 userNum = 2;
 break;
 case 'D':
 userNum = 3;
 break;
 default:
 return 0;
 }
 userExists = readEEPROM(5*userNum);

 if(userExists == 1){
 return 1;
 }
 else{
 return 0;
 }
}

void rotate0Deg(){
 for(i=0;i<50;i++)
 {
 PORTB.F0 = 1;
 delay_us(1499);
 PORTB.F0 = 0;
 delay_us(18501);
 }
}

void rotate90Deg(){
 for(i=0;i<50;i++)
 {
 PORTB.F0 = 1;
 delay_us(2100);
 PORTB.F0 = 0;
 delay_us(17900);
 }
}

int pinMatched(){
 for(i=0; i<4; i++){
 if(inputPinCode[i] != memoryPinCode[i]){
 return 0;
 }
 }
 delay_ms(5000);
 return 1;
}

void getPinFromMemory(char user){
 int userNumber;
 userNumber = getUserNumber(user);

 SSD1306_GotoXY( i+1, 6);
 SSD1306_PUTC(usernumber+48);
 memoryPinCode[3] = readEEPROM(userNumber*5+1);
 memoryPinCode[2] = readEEPROM(userNumber*5+2);
 memoryPinCode[1] = readEEPROM(userNumber*5+3);
 memoryPinCode[0] = readEEPROM(userNumber*5+4);

}
