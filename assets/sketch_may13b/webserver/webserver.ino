#include <WiFi.h>
#include <WebServer.h>

const char* ap_ssid = "ESP32_AP";
const char* ap_password = "12345678";

WebServer server(80);

String sensorText = "Hello Flutter";
int sensorNumber = 42;


void handleData() {
  String json = "{";
  json += "\"text\":\"" + sensorText + "\",";
  json += "\"number\":" + String(sensorNumber);
  json += "}";
  
  server.send(200, "application/json", json);
}

void setup() {
  Serial.begin(921600);
  Serial.println();

  WiFi.softAP(ap_ssid, ap_password);
  Serial.println("AP started");
  Serial.print("AP IP: ");
  Serial.println(WiFi.softAPIP());

  server.on("/data", HTTP_GET, handleData);

  server.begin();
  Serial.println("HTTP server started");
}

void loop() {
  server.handleClient();
delay(1000);
sensorNumber++;
}
