/**************************************************************************************

  Securitas - Secure Lock System

***************************************************************************************/

// define SSD1306 reset pin (if available)
#define SSD1306_RST RA0_bit
#define SSD1306_RST_DIR TRISA0_bit

#include <SSD1306.c> // include SSD1306 OLED driver source file

#define R1 RD0_bit
#define R2 RD1_bit
#define R3 RD2_bit
#define R4 RD3_bit
#define C1 RD4_bit
#define C2 RD5_bit
#define C3 RD6_bit
#define C4 RD7_bit

unsigned int i;
/*
  EEPROM related variables and functions
*/

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

/*
   Keypad Variables and constants
*/
unsigned char keyPressed = 0;
unsigned char KEY_ARRAY[4][4] = {{'7', '8', '9', 'A'}, {'4', '5', '6', 'B'}, {'1', '2', '3', 'C'}, {'F', '0', 'E', 'D'}};
unsigned char keypadRow, keypadColumn;

unsigned char keypadKey();

/*
   Function to display in screen
*/
void printToXY(int row, int col, char *str, int flagClearScreen);

/*
   Function to rotate Servo
*/
void rotate0Deg();
void rotate90Deg();

/*
  All the views and input handlers:
*/

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

  // For Display
  TRISA = 0b11111111;

  // For Keypad
  TRISD = 0XF0;
  OPTION_REG &= 0X7F; //ENABLE PULL UP

  // For Buzzer and Servo
  TRISB = 0;

  I2C1_Init(400000); // initialize I2C communication with clock frequency of 400KHz

  // initialize the SSD1306 OLED with an I2C addr = 0x7A (default address)
  SSD1306_Init(SSD1306_SWITCHCAPVCC, SSD1306_I2C_ADDRESS);
  // clear the screen
  SSD1306_ClearDisplay();

  if( !isUserExistent('A') ){
    // If admin account doesn't exist
    // Create new account with 1234 PIN
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
// End of main()



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

  /*userExists = readEEPROM(0);
  SSD1306_GotoXY( 2, 2);
  SSD1306_PUTC(userExists+48);
  delay_ms(500); */

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
  /*printToXY(1, 1, "By:", 1);
  printToXY(2, 2, "Sabbir", 0);
  printToXY(3, 2, "Rafi", 0);
  printToXY(4, 2, "Rifat", 0);
  printToXY(6, 2, "[x]", 0);  */
}

void aboutViewInputHandler()
{
  keyPressed = keyPadKey();
}

unsigned char keypadKey()
{
  /*
        Returns character of the key pressed in the keypad
    */

  PORTD = 0x00;

  while (1)
  {
    R1 = 1;
    R2 = R3 = R4 = 0;
    SSD1306_GotoXY(1, 1);
    if (C1 || C2 || C3 || C4)
    {
      keypadRow = 0;
      break;
    }
    R2 = 1;
    R1 = 0;
    if (C1 || C2 || C3 || C4)
    {
      keypadRow = 1;
      break;
    }
    R3 = 1;
    R2 = 0;
    if (C1 || C2 || C3 || C4)
    {
      keypadRow = 2;
      break;
    }
    R4 = 1;
    R3 = 0;
    if (C1 || C2 || C3 || C4)
    {
      keypadRow = 3;
      break;
    }
  }

  if (C1 == 1)
  {
    keypadColumn = 0;
  }
  else if (C2 == 1)
  {
    keypadColumn = 1;
  }
  else if (C3 == 1)
  {
    keypadColumn = 2;
  }
  else if (C4 == 1)
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
  SSD1306_GotoXY(col, row); // move cursor to column col, row row
  SSD1306_Print(str);       // print text
}

unsigned char readEEPROM(unsigned char address)
{
  EEADR = address; //Address to be read
  EECON1.EEPGD = 0;//Selecting EEPROM Data Memory
  EECON1.RD = 1; //Initialise read cycle
  return EEDATA; //Returning data
}

void writeEEPROM(unsigned char address, unsigned char datas)
{
  unsigned char INTCON_SAVE;//To save INTCON register value
  EEADR = address; //Address to write
  EEDATA = datas; //Data to write
  EECON1.EEPGD = 0; //Selecting EEPROM Data Memory
  EECON1.WREN = 1; //Enable writing of EEPROM
  INTCON_SAVE=INTCON;//Backup INCON interupt register
  INTCON=0; //Diables the interrupt
  EECON2=0x55; //Required sequence for write to internal EEPROM
  EECON2=0xAA; //Required sequence for write to internal EEPROM
  EECON1.WR = 1; //Initialise write cycle
  INTCON = INTCON_SAVE;//Enables Interrupt
  EECON1.WREN = 0; //To disable write
  while(PIR2.EEIF == 0)//Checking for complition of write operation
  {  }
  PIR2.EEIF = 0; //Clearing EEIF bit
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
      return  0;
  }
  userExists =  readEEPROM(5*userNum);

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
    delay_us(1499); // pulse of 800us
    PORTB.F0 = 0;
    delay_us(18501);
  }
}

void rotate90Deg(){
  for(i=0;i<50;i++)
  {
    PORTB.F0 = 1;
    delay_us(2100); // pulse of 800us
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
