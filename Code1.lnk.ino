unsigned long previousMicros1 = 0;      // Start of first prototask (Audio)
unsigned long previousMicros2 = -500000;// Start of second prototask
unsigned long tidMellanOutput = 125;      // (delta T)

int mic0;
int mic1;
int mic2;
int mic3;
String string0;
String string1;
String string2;
String string3;
String printString;

char buf[100];

void setup()
{
  Serial.begin(2000000);//start Serial in case we need to print debugging info
}
void loop()
{
  while(1){
  unsigned long currentMicros = micros();//Read current clock
    if (currentMicros - previousMicros1 >= tidMellanOutput)
  {
    mic0 = analogRead(A7);
    mic1 = analogRead(A6);
    mic2 = analogRead(A3);
    mic3 = analogRead(A0);

    string0 =  String(mic0, DEC);
    string1 =  String(mic1, DEC);
    string2 =  String(mic2, DEC);
    string3 =  String(mic3, DEC);

    printString = string0 + " " + string1 + " " + string2 + " " + string3 + "\n";
    printString.toCharArray(buf, 100);
    SerialUSB.write(buf);
        
    //previousMicros1 = previousMicros1 + tidMellanOutput;
    previousMicros1 = micros() + tidMellanOutput;
    }
  }
    /*
  if (currentMillis - previousMillis2 >= tidMellanOutput)
  {
    //SerialUSB.write("Skriv ut data från gyroskåpet");
    //previousMillis2 (negativ) styr då denna börjar körs.
    //Skapa en tidMellanOutput2 för att ändra uppdateringsfrekvensen för gyroskåpet.
    //Den bör inte uppdateras lika ofta, tror jag...
    previousMillis2 = previousMillis2 + tidMellanOutput;
  }
  */
}
