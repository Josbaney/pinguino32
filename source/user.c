/*
  AnalogReadSerial
 Reads an analog input on pin 0, prints the result to the serial monitor 
 
 This example code is in the public domain.
 */

void setup() {
  serial_begin(9600);
}

void loop() {
  int sensorValue = analogread(A0);
  serial_println(sensorValue, DEC);
}

