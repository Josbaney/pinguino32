/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.
 
  This example code is in the public domain.
 */
 
// Pin 13 has an LED connected on most Arduino boards:
#define PIN 13

void setup() {                
  // initialize the digital pin as an output
  pinMode(PIN, OUTPUT);
}

void loop() {
  digitalWrite(PIN, HIGH);   // set the LED on
  delay(500);              // wait for a second
  digitalWrite(PIN, LOW);    // set the LED off
  delay(500);              // wait for a second
}
