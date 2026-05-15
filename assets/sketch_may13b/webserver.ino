#include <WiFi.h>
#include <WebServer.h>

// مشخصات وای‌فای که خود ESP32 راه می‌اندازد
const char* ssid = "ESP32-Control";
const char* password = "12345678";
float tempValue = 36.5;
bool stateValue = true;
String deviceName = "ESP32-1";

WiFiServer wifiserver(80);
WebServer server(85);
// اگر ال‌ای‌دی بیرونی نداری، از ال‌ای‌دی روی خود برد (پین 12) استفاده کن
const int ledPin = 12;

void setup() {

  Serial.begin(921600);
  pinMode(ledPin, OUTPUT);

  // استارت Access Point
  WiFi.softAP(ssid, password);

  // نمایش IP روی سریال مانیتور
  Serial.print("AP IP address: ");
  Serial.println(WiFi.softAPIP());
  // while (WiFi.status() != WL_CONNECTED) {
  //   delay(500);
    // Serial.println("Connecting...");
  // }
  server.on("/data", handleData);
    Serial.print("++++++++++++1");
    Serial.println("Connecting...d");
  //  server.on("/data", HTTP_GET, handleData);
  server.begin();
    Serial.print("++++++++++++2");

  wifiserver.begin();
    Serial.print("++++++++++++3");


}

void loop() {
  WiFiClient client = wifiserver.available();
  if (!client) {
    return;
  }

  String req = client.readStringUntil('\r');
  Serial.println(req);
  client.flush();
  String req2 = client.readStringUntil('\n');
  Serial.println(req2);
  // سناریوی فرمان (آدرس دهی ساده)
  if (req.indexOf("GET /led/on") >= 0) {
    digitalWrite(ledPin, HIGH);
  }
  if (req.indexOf("GET /led/off") >= 0) {
    digitalWrite(ledPin, LOW);
  }
//=============
if (req.indexOf("GET /set?") >= 0) {
  // extract text=
  int tStart = req.indexOf("text=") + 5;
  int tEnd = req.indexOf("&num=", tStart);
  String textVal = req.substring(tStart, tEnd);

  // extract num=
  int nStart = req.indexOf("num=", tEnd) + 4;
  int nEnd = req.indexOf(' ', nStart); // تا قبل از فضای بعدی (HTTP/1.1)
  String numStr = req.substring(nStart, nEnd);
  int numVal = numStr.toInt();

  Serial.print("Received text: ");
  String chap=urlDecode(textVal);
  Serial.println(chap);
  Serial.print("Received num: ");
  Serial.println(numVal);
  }
  

  // پاسخ ساده به کلاینت
  client.println("HTTP/1.1 200 OK");
  client.println("Content-Type: text/html");
  client.println();
  client.println("<!DOCTYPE HTML>");
  client.println("<html><body>");
  client.println("<h1>ESP32 Control</h1>");
  client.println("<p>Use /led/on or /led/off</p>");
  client.println("</body></html>");
  //loop
      server.handleClient();
  delay(8); // کوچولو
}
 
//decode
   String urlDecode(String input) {
  input.replace("+", " ");
  return input;
}
//handel
void handleData() {
  String json = "{";
  json += "\"name\":\"" + deviceName + "\",";
  json += "\"temp\":" + String(tempValue, 1) + ",";
  json += "\"state\":" + String(stateValue ? "true" : "false");
  json += "}";
  
  server.send(200, "application/json", json);
}
//==============
// String → مستقیم
// int → با toInt()
// float → با toFloat()
// bool → معمولاً با مقایسه‌ی متن:
// cpp
//   if (value == "true") ...