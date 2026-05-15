#include <BluetoothSerial.h>
char c;
BluetoothSerial myBT;
int led =12;
void setup() {



pinMode(led,OUTPUT);



myBT.begin("ESP32_Controller");



Serial.begin(115200);



Serial.println("ESP32 conected .. ");
}
void loop() {



if(myBT.available())
{
c=myBT.read();



Serial.println("كاراكتر دريافتى");


Serial.println(c);



if(c == '1'){
digitalWrite(led,1);



Serial.println("LED ON");
}
else if(c == '0'){
digitalWrite(led,0);



Serial.println("LED off");
}}
delay(20) ;
}