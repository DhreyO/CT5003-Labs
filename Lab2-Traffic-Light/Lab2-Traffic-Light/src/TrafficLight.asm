// ---------------- PIN SETUP ----------------
// ---------------- PIN SETUP ----------------
int leftG = 11;
int leftY = 12;
int leftR = 13;

int rightG = 5;
int rightY = 6;
int rightR = 7;

int pedG = 9;
int pedR = 10;

int buttonPin = 2;

// ---------------- SETUP ----------------
void setup() {
  pinMode(leftG, OUTPUT);
  pinMode(leftY, OUTPUT);
  pinMode(leftR, OUTPUT);

  pinMode(rightG, OUTPUT);
  pinMode(rightY, OUTPUT);
  pinMode(rightR, OUTPUT);

  pinMode(pedG, OUTPUT);
  pinMode(pedR, OUTPUT);

  pinMode(buttonPin, INPUT_PULLUP);

  Serial.begin(9600);

  // Start with traffic green, pedestrians red
  setLeftG();
  setRightG();
  setPedR();
}

// ---------------- MAIN LOOP ----------------
void loop() {

  // Wait for button press
  if (digitalRead(buttonPin) == LOW) {
    Serial.println("Pedestrian button pressed");
    pedestrianCycle();
  }

  // Otherwise do nothing — keep cars green
}

// ---------------- PEDESTRIAN CYCLE ----------------
void pedestrianCycle() {

  // Cars to yellow
  setLeftY();
  setRightY();
  delay(2000);

  // Cars to red
  setLeftR();
  setRightR();
  delay(1000);

  // Pedestrian green
  setPedG();
  delay(4000);

  // Flashing pedestrian green
  for (int i = 0; i < 4; i++) {
    digitalWrite(pedG, LOW);
    delay(300);
    digitalWrite(pedG, HIGH);
    delay(300);
  }

  // Pedestrian red
  setPedR();
  delay(1000);

  // Cars red + yellow
  setLeftRY();
  setRightRY();
  delay(2000);

  // Cars green again
  setLeftG();
  setRightG();
}

// ---------------- LIGHT CONTROL FUNCTIONS ----------------
void setLeftG(){ digitalWrite(leftG, HIGH); digitalWrite(leftY, LOW); digitalWrite(leftR, LOW); }
void setLeftY(){ digitalWrite(leftG, LOW); digitalWrite(leftY, HIGH); digitalWrite(leftR, LOW); }
void setLeftR(){ digitalWrite(leftG, LOW); digitalWrite(leftY, LOW); digitalWrite(leftR, HIGH); }
void setLeftRY(){ digitalWrite(leftG, LOW); digitalWrite(leftY, HIGH); digitalWrite(leftR, HIGH); }

void setRightG(){ digitalWrite(rightG, HIGH); digitalWrite(rightY, LOW); digitalWrite(rightR, LOW); }
void setRightY(){ digitalWrite(rightG, LOW); digitalWrite(rightY, HIGH); digitalWrite(rightR, LOW); }
void setRightR(){ digitalWrite(rightG, LOW); digitalWrite(rightY, LOW); digitalWrite(rightR, HIGH); }
void setRightRY(){ digitalWrite(rightG, LOW); digitalWrite(rightY, HIGH); digitalWrite(rightR, HIGH); }

void setPedG(){ digitalWrite(pedG, HIGH); digitalWrite(pedR, LOW); }
void setPedR(){ digitalWrite(pedG, LOW); digitalWrite(pedR, HIGH); }
