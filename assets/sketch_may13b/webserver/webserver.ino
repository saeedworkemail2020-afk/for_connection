#include <WiFi.h>
#include <WebServer.h>

const char* ssid = "YOUR_WIFI";
const char* password = "YOUR_PASSWORD";

WebServer server(80);

// داده‌های نمونه
String deviceName = "ESP32-1";
float tempValue = 36.5;
bool stateValue = true;

void handleData() {
  String json = "{";
  json += "\"name\":\"" + deviceName + "\",";
  json += "\"temp\":" + String(tempValue, 1) + ",";
  json += "\"state\":" + String(stateValue ? "true" : "false");
  json += "}";
  server.send(200, "application/json", json);
}

void setup() {
  Serial.begin(921600);

  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.println("Connecting...");
  }

  Serial.println("WiFi connected.");
  Serial.print("IP: ");
  Serial.println(WiFi.localIP());

  server.on("/data", HTTP_GET, handleData); // این متد مربوط به WebServer است
  server.begin();
}

void loop() {
  server.handleClient(); // این متد مربوط به WebServer است
}
