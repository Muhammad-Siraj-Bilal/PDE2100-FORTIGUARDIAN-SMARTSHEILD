#include <SoftwareSerial.h>

// Pin configuration for HC-05
#define RX_PIN D0
#define TX_PIN D1

int pos = 0;
int inputPin = D4; // signal receiver pin ECHO to D4
int outputPin = D5; // signal transmitter pin TRIG to D5
const int flamePin = D2; 
int state = 0;         // variable for reading status
int sensorValue = 0;
const int analogInPin = A0;

#define LED_PIN D10
#define BUZZER_PIN D11

SoftwareSerial hc05(RX_PIN, TX_PIN);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  hc05.begin(115200);

  pinMode(LED_PIN, OUTPUT);
  pinMode(BUZZER_PIN, OUTPUT);
  pinMode(inputPin, INPUT);
  pinMode(outputPin, OUTPUT);
  pinMode(flamePin, INPUT); 
  pinMode(D8, OUTPUT);
  digitalWrite(D8, LOW);
}

void loop() {
  int dis = checkUltrasonic(inputPin, outputPin);
  delay(10);
  int heat = flameState(flamePin);
  delay(10);
  int ldr = ldrValue(analogInPin);

  if (hc05.available()) {
    // Read the next character from the HC-05 module
    //uint8_t data = hc05.read();
    int data = hc05.read();
    //int data = hc05.read();
    //Serial.println(data);
    
    if (data == 254 || data == 252 || data == 255) {
      digitalWrite(D8, HIGH);
      delay(1000);
      digitalWrite(D8, LOW);
    }
  }

  if (dis <= 10) {
    digitalWrite(LED_PIN, HIGH);
    digitalWrite(BUZZER_PIN, HIGH);
    delay(1000);
    digitalWrite(LED_PIN, LOW);
    digitalWrite(BUZZER_PIN, LOW);
    delay(100);
    digitalWrite(LED_PIN, HIGH);
    digitalWrite(BUZZER_PIN, HIGH);
    delay(1000);
    digitalWrite(LED_PIN, LOW);
    digitalWrite(BUZZER_PIN, LOW);
    //Serial.print("Ultrasonic value is: ");
    //Serial.println(dis);
  }

  if (heat == LOW) {
    digitalWrite(LED_PIN, HIGH);
    digitalWrite(BUZZER_PIN, HIGH);
    delay(1000);
    digitalWrite(LED_PIN, LOW);
    digitalWrite(BUZZER_PIN, LOW);
    delay(100);
    digitalWrite(LED_PIN, HIGH);
    digitalWrite(BUZZER_PIN, HIGH);
    delay(1000);
    digitalWrite(LED_PIN, LOW);
    digitalWrite(BUZZER_PIN, LOW);
    //Serial.print("Fire Detected");
  }

  if (ldr <= 250) {
    digitalWrite(LED_PIN, HIGH);
    digitalWrite(BUZZER_PIN, HIGH);
    delay(1000);
    digitalWrite(LED_PIN, LOW);
    digitalWrite(BUZZER_PIN, LOW);
    delay(100);
    digitalWrite(LED_PIN, HIGH);
    digitalWrite(BUZZER_PIN, HIGH);
    delay(1000);
    digitalWrite(LED_PIN, LOW);
    digitalWrite(BUZZER_PIN, LOW);
//    //Serial.print("LDR value is: ");
//    //Serial.println(ldr);
  }

  Serial.print(dis);
  Serial.print(",");
  Serial.print(ldr);
  Serial.print(",");
  Serial.print(heat);
  Serial.print("\n");
  delay(500);
}


int checkUltrasonic(int inputPin, int outputPin) {
  digitalWrite(outputPin, LOW);
  delayMicroseconds(2);
  digitalWrite(outputPin, HIGH); // Pulse for 10μs to trigger ultrasonic detection
  delayMicroseconds(10);
  digitalWrite(outputPin, LOW);
  int distance = pulseIn(inputPin, HIGH); // Read receiver pulse time
  distance = distance / 58;               // Transform pulse time to distance
  return distance;
  delay(50);
}

int flameState(int flamePin) {
  // Read the state of the flame sensor pin:
  state = digitalRead(flamePin);
  return state;
  delay(50);
}

int ldrValue(int analogInPin) {
  // Read the sensor value
  int value = analogRead(analogInPin);
  return value;
  delay(50);
}
