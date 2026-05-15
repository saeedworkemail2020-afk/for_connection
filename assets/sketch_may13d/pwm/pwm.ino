int led=12;
int pwmFrequency=5000;
int pwmResolution=8;
void setup(){
  Serial.begin(921600);
  ledcAttach(led,pwmFrequency,pwmResolution);
}
void loop(){
ledcWrite(led,50);
delay(100); 
ledcWrite(led,200);
delay(100); 
ledcWrite(led,80);
delay(100); 
ledcWrite(led,255);
delay(100); 
ledcWrite(led,80);
delay(100); 
ledcWrite(led,255);
delay(100); 
ledcWrite(led,100);
delay(100); 
ledcWrite(led,255);
}