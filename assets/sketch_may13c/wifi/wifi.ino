#include <WiFi.h>

// مشخصات وای‌فای که خود ESP32 راه می‌اندازد
const char* ssid = "ESP32-Control";
const char* password = "12345678";

WiFiServer server(80);

// اگر ال‌ای‌دی بیرونی نداری، از ال‌ای‌دی روی خود برد (پین 2) استفاده کن
const int ledPin = 12;
bool status=false;

void setup() {
  Serial.begin(921600);
  pinMode(ledPin, OUTPUT);

  // استارت Access Point
  WiFi.softAP(ssid, password);

  // نمایش IP روی سریال مانیتور
  Serial.print("AP IP address: ");
  Serial.println(WiFi.softAPIP());

  server.begin();
}

void loop() {
  WiFiClient client = server.available();
  if (!client) {
    // return;
    Serial.println("is connect");
  }
  String req = client.readStringUntil('\r');
  Serial.println(req);
  client.flush();

  // سناریوی فرمان (آدرس دهی ساده)
  if (req.indexOf("GET /led/on") >= 0) {
    status=true;
  }
 else if (req.indexOf("GET /led/off") >= 0) {
    status=false;
  }
if(status){
 digitalWrite(ledPin, HIGH);
 delay(1111);
 digitalWrite(ledPin, LOW);

 }
}
