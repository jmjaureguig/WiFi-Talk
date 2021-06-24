// Coil pins
#define coilA 9
#define coilB 10
#define coilC 11
#define coilD 12

byte rxByte;
String inStr = "";
bool rxComplete = false;
const byte numChars = 12;
char rcvChars[numChars];

unsigned int stepsCounter = 0;

// Coil states
int enCoil[8][4] = {
  {1, 0, 0, 0},
  {1, 1, 0, 0},
  {0, 1, 0, 0},
  {0, 1, 1, 0},
  {0, 0, 1, 0},
  {0, 0, 1, 1},
  {0, 0, 0, 1},
  {1, 0, 0, 1},
};

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(coilA, OUTPUT);
  pinMode(coilB, OUTPUT);
  pinMode(coilC, OUTPUT);
  pinMode(coilD, OUTPUT);
  coilsOff();
  Serial.begin(9600);
}

void coilsOff() {
  digitalWrite(coilA, 0);
  digitalWrite(coilB, 0);
  digitalWrite(coilC, 0);
  digitalWrite(coilD, 0);  
}

void coilsWrite(int state){
  digitalWrite(coilA, enCoil[state & 0x07][0]);
  digitalWrite(coilB, enCoil[state & 0x07][1]);
  digitalWrite(coilC, enCoil[state & 0x07][2]);
  digitalWrite(coilD, enCoil[state & 0x07][3]);
}

void rxWithEnd() {
  static byte ndx = 0;
  char endChar = '\r';
  char rc;

  while (Serial.available() > 0 ) {
    rc = Serial.read();

    rcvChars[ndx] = rc;
    
    // If endChar or more than numChars complete reception
    if ( ( rc == endChar ) || ( ndx == (numChars-1)) ){
      
      rxComplete=true;
      ndx=0;
    }
    else{
      ndx++;  
    }

  }
}

void reset() {
  stepsCounter = 0;
  Serial.println("SET:STEP:0");
}

void counterRead() {
  Serial.print("READ:STEP:");
  Serial.println(stepsCounter);
}

void goStep() {
  unsigned int k,c,d,u=0;
  unsigned int requested;
  k=1000 * (rcvChars[1]-48);
  c= 100 * (rcvChars[2]-48);
  d=  10 * (rcvChars[3]-48);
  u=       (rcvChars[4]-48);
  requested = k+c+d+u;

  if (requested > 4095){
    requested = 4095;
  }

  while (requested != stepsCounter){
    if (requested > stepsCounter){
      stepsCounter++;
    }
    if (requested < stepsCounter){
      stepsCounter--;
    }
    coilsWrite(stepsCounter);
    delay(5);    
  }

  Serial.print("MOV:DONE:");
  Serial.println(requested);

}

void printNew() {
  if (rxComplete == true) {

    switch(rcvChars[0]) {
      case 'R' : reset();
                 break;
      case 'c' : counterRead();
                 break;
      case 'g' : goStep();
                 break;
      default:   Serial.println("???");
        
    }
    
    rxComplete=false;
  }
}

void loop() {
  // 8-states per motor cycle
  // 512 cycles for a full turn
  // 4096 total states/rev

  while(true){
    rxWithEnd();
    printNew();
  }
  
}
