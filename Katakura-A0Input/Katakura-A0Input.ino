// Analog Input from A0 pin 
// GP13をGNDに接続すると数字で出力
// GP13をGNDに接続しないとバイナリで出力

#define analogPin  A0   // 使用するアナログ入力ピン
#define SW_PIN     13   // スイッチ用のデジタルピン
#define delay      100  // 必要に応じて調整

void setup() {
  Serial.begin(115200);  // シリアル通信を開始
  pinMode(SW_PIN, INPUT_PULLUP);  // スイッチピンをプルアップ入力に設定
}

void loop() {
  int analogValue = analogRead(analogPin);                     // 0〜1023 を取得
  byte normalized = map(analogValue, 0, 1023, 0, 255);         // 0〜255に正規化
  if (digitalRead(SW_PIN) == LOW) {                            // スイッチが押された場合
    Serial.println(normalized);
  }else
    Serial.write(normalized);                                    // バイナリ（1バイト）で送信  
  } 
  delay(DLY); 
}

