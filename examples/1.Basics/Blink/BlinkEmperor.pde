/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.
 
  This example code is in the public domain.
 */

void setup() {                
  // initialize the digital pin as an output.
  // Pin 13 has an LED connected on most Arduino boards:
  pinMode(48, OUTPUT);
  //pinMode(49, OUTPUT);    
}

void loop() {
  digitalWrite(48, HIGH);   // set the LED on
  delay(100);              // wait for a second
  digitalWrite(48, LOW);    // set the LED off
  delay(100);              // wait for a second
  //toggle(49);
}
