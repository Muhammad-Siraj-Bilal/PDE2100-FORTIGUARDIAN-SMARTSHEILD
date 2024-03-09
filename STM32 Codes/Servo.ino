#include <Servo.h>

int pos = 0;
Servo servo1;
int prevValue = LOW; // Variable to store the previous state of the input pin

void setup() {
  Serial.begin(9600);
  servo1.attach(9); // Assuming you meant pin 9, not D9
  pinMode(D8, INPUT);
}

void loop() {
  int value = digitalRead(D8);
  Serial.println(value);
  // Check if the input pin transitioned from LOW to HIGH
  if (value == HIGH && prevValue == LOW) {
    rotateServo();
  }
  
  // Update the previous state of the input pin
  prevValue = value;
  delay(100);
}

void rotateServo() {
  // Rotate smoothly from 0 to 180 degrees
  for (int targetPos = 0; targetPos <= 90; targetPos++) {
    int mappedPos = map(targetPos, 0, 90, servo1.read(), 90);
    servo1.write(mappedPos);
    delay(10); // Adjust delay for smoother movement
  }
  
  delay(1000);
  
  // Rotate smoothly back from 180 to 0 degrees
  for (int targetPos = 90; targetPos >= 0; targetPos--) {
    int mappedPos = map(targetPos, 0, 90, servo1.read(), 0);
    servo1.write(mappedPos);
    delay(10); // Adjust delay for smoother movement
  }
}
