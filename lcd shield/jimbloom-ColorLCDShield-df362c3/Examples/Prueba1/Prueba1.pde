/*
  TestPattern - An example sketch for the Color LCD Shield Library
  by: Jim Lindblom
  SparkFun Electronics
  date: 6/23/11
  license: CC-BY SA 3.0 - Creative commons share-alike 3.0
  use this code however you'd like, just keep this license and
  attribute. Let me know if you make hugely, awesome, great changes.

  This sketch has example usage of the Color LCD Shield's three
  buttons. It also shows how to use the setRect and contrast
  functions.
  
  Hit S1 to increase the contrast, S2 decreases the contrast, and
  S3 sets the contrast back to the middle.
*/
#include "ColorLCDShield.h"

LCDShield lcd;

int buttons[3] = {3, 4, 5};  // S1 = 3, S2 = 4, S3 = 5
byte cont = 40;  // Good center value for contrast
int x,y;

void setup()
{
  for (int i=0; i<3; i++)
  {
    pinMode(buttons[i], INPUT);  // Set buttons as inputs
    digitalWrite(buttons[i], HIGH);  // Activate internal pull-up
  }
  
//  lcd.init(EPSON);  // Initialize the LCD, try using PHILLIPS if it's not working
  lcd.init(PHILLIPS);
  lcd.contrast(cont);  // Initialize contrast
  lcd.clear(WHITE);  // Set background to white
//  lcd.printLogo();  // Print SparkFun test logo
//  lcd.setChar('X', 0, 0, RED, WHITE);
//  lcd.setStr("Xload rules!!!", 10, 10, BLUE, WHITE);
//  testPattern();  // Print color bars on bottom of screen
}

void loop()
{

  /*
  int x=60,y=0;
  for (y = 0; y < 130; y++)   
   {
    lcd.setPixel(RED, x, y);
   }
   */


  delay(10000);
  lcd.printLine(0, "Movistar    100%", RED, WHITE);
  lcd.printLine(7, "      Menu", GREEN, WHITE);  
//  lcd.setStr("123456789_123456",16, 0, BLACK, WHITE);
  delay(10000);  // Delay to give each button press a little more meaning
//  x=x+16;
//  y=1;
}

