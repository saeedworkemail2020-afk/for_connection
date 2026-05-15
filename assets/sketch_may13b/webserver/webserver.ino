#include <WiFi.h>
#include <WebServer.h>

const char* ap_ssid = "ESP32_AP"; // اسم شبکه وای‌فای که ESP32 ایجاد می‌کنه
const char* ap_password = "12345678"; // رمز عبور شبکه (حداقل ۸ کاراکتر)

WebServer server(80);

String receivedText = "";
int receivedNumber = 0;

// صفحه اصلی که اطلاعات رو نمایش میده


// دریافت داده با POST
void handlePostData() {
  String textData = "";
  int numberData = 0;
// آیا در درخواست HTTP ارسالی، پارامتر/آرگومان با نام text وجود دارد؟
  if (server.hasArg("text")) {
    textData = server.arg("text");
  }
  if (server.hasArg("number")) {
    // تبدیل رشته به عدد صحیح
    numberData = server.arg("number").toInt();
  }

  // به‌روزرسانی متغیرهای سراسری
  receivedText = textData;
  receivedNumber = numberData;

  // ارسال پاسخ به کلاینت (مثلاً Flutter)
  server.send(200, "text/plain", "Data received successfully!");

  // چاپ در سریال مانیتور برای دیباگ
  Serial.println("--- Data Received ---");
  Serial.print("Text: ");
  Serial.println(receivedText);
  Serial.print("Number: ");
  Serial.println(String(receivedNumber));
  Serial.println("-------------------");
}

void setup() {
  Serial.begin(921600);
  Serial.println();
  Serial.println("Configuring Access Point...");

  // راه‌اندازی ESP32 به عنوان Access Point
  WiFi.softAP(ap_ssid, ap_password);

  IPAddress IP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(IP); // این آی‌پی رو باید تو Flutter استفاده کنی (معمولاً 192.168.4.1)

  // تعریف روت‌ها (مسیرهای URL)
  server.on("/postData", HTTP_POST, handlePostData); // وقتی کسی با POST به /postData داده می‌فرسته

  server.begin(); // راه‌اندازی وب‌سرور
  Serial.println("HTTP server started");
}

void loop() {
  server.handleClient(); // پردازش درخواست‌های ورودی
}
