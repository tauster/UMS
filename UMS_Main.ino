/* Ultrasonic Mapping System (UMS)
   
   The C&DH system for the UMS. Obtains sensory data and controls
   the servo while keeping track of its current angle. Data is then
   sent to the ground station's MATLAB interface using the Xbee via
   'Serial(one)' protocol. Data is also saved on SD card for back up.
   
   by Tausif Sharif
*/

#include <Wire.h>
#include <SRF02.h>
#include <Servo.h>
#include <SPI.h>
#include <SD.h>

// Initializing address specific sensor for radius and height.
// Use SRFAddressChange to chance physical address on board.
#define R_ADDRESS 0x70
#define H_ADDRESS 0x71

SRF02 radius(R_ADDRESS, SRF02_INCHES);
SRF02 height(H_ADDRESS, SRF02_INCHES);

Servo theta;

File dataLog;
const int chipSelect = 8;

unsigned long nextPrint = 0;
unsigned int r, h;
unsigned int angle = 0;
int mode = -1;
int i;
boolean angleMode = false;

void setup()
{
  Serial1.begin(9600);
  
  // Required for Arduino Leonardo to initalize a serial communication.
  while (!Serial1){};
  
  Wire.begin();
  theta.attach(9);
  
  // Waiting for a request from MATLAB to connect Serial ports.
  char a = 'b';
  while(a != 'a')
  {
    a = Serial1.read();
  }
  Serial1.println('a');
  
  // Initializing SD card.
  if(!SD.begin(chipSelect))
  {
    Serial.println("SD Card Failed");
    return;
  }
}

void loop()
{
  // Mode dictates sweep direction. 
  mode = -1;
  
  if(angle == 0)
  {
    angleMode = false;
  }
  if(angle == 165)
  {
    angleMode = true;
  }
  
  switch(angleMode)
  {
    case false:
      angle++;
      theta.write(angle);
      Send();
      delay(30);
      break;
      
    case true:
      angle--;
      theta.write(angle);
      Send();
      delay(30);
      break;
      
    default:
      break;
  }
  // Write most recent data points to SD card.
  WriteSD();
}
