// --------------------------------------
// i2c_scanner
//
// Modified from https://playground.arduino.cc/Main/I2cScanner/
// --------------------------------------

#include <Wire.h>

// Set I2C bus to use: Wire, Wire1, etc.
#define WIRE Wire

int ADXLAddress = 0x68; //MPU 9250 address

#define Z_Axis_Register_DATAX0 0x41 //z axis H
#define Z_Axis_Register_DATAX1 0x42 //z axis L
#define Power_Register 0x01

int Z0, Z1, Z_out;
int LSBit = 2; //digital pin 2
  
void setup() {
  WIRE.begin();

  Serial.begin(9600);
  while (!Serial)
     delay(10);
  Serial.println("\nI2C Scanner");
  Wire.beginTransmission(ADXLAddress);
  Wire.write(Power_Register);
  Wire.write(8);
  Wire.endTransmission();

  pinMode(LSBit, OUTPUT);    // sets the digital pin 2 (D2) as output
}


void loop() {
  byte error, address;
  int nDevices;

  digitalWrite(LSBit, LOW); // sets pin low, making address  b1101000 \
  //search for I2C devices
/*
  Serial.println("Scanning...");

  nDevices = 0;
  for(address = 1; address < 127; address++ ) 
  {
    // The i2c_scanner uses the return value of
    // the Write.endTransmisstion to see if
    // a device did acknowledge to the address.
    WIRE.beginTransmission(address);
    error = WIRE.endTransmission();

    if (error == 0)
    {
      Serial.print("I2C device found at address 0x");
      if (address<16) 
        Serial.print("0");
      Serial.print(address,HEX);
      Serial.println("  !");

      nDevices++;
    }
    else if (error==4) 
    {
      Serial.print("Unknown error at address 0x");
      if (address<16) 
        Serial.print("0");
      Serial.println(address,HEX);
    }    
  }
  if (nDevices == 0)
    Serial.println("No I2C devices found\n");
  else
    Serial.println("done\n");
*/

  Wire.beginTransmission(ADXLAddress);
  Wire.write(Z_Axis_Register_DATAX0);
  Wire.write(Z_Axis_Register_DATAX1);
  Wire.endTransmission();
  Wire.requestFrom(ADXLAddress,2);//

  if(Wire.available()<=2) {
    Z0 = Wire.read();
    Z1 = Wire.read();
  }

  Serial.print("Z = ");
  Serial.println(Z0*255+Z1);
  

  delay(100);           // wait
}
