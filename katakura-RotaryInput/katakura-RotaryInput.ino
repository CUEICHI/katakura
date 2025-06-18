//　ロータリーエンコーダー入力で 0xFF / 0x00 を出力
// GP13をGNDに接続すると文字で出力
// GP13をGNDに接続しないとバイナリで出力（CC=0x00,CCW=0xFF）

// エンコーダー入力ピン
#define CLK     2
#define DT      3
#define SW_PIN 13   // 切り替えスイッチ用のデジタルピン

int prevCLK;

void setup() {
  // ピンの設定
  pinMode(SW_PIN, INPUT_PULLUP);  // スイッチピンをプルアップ入力に設定
  pinMode(CLK, INPUT);
  pinMode(DT, INPUT);
  Serial.begin(115200);

  // 初期状態を取得
  prevCLK = digitalRead(CLK);
}

void loop() {
  int currCLK = digitalRead(CLK);
  if (currCLK != prevCLK) {  // CLK の状態変化を検知
    if (digitalRead(DT) != currCLK) {
      // CCW の場合
      if (digitalRead(SW_PIN) == LOW) {  
        Serial.println("CCW");
      } else {
        Serial.write(0xFF);  // バイナリで 0xFF を送信
      }
    } else {
      // CW の場合
      if (digitalRead(SW_PIN) == LOW) {  
        Serial.println("CW");
      } else {
        Serial.write(0x00);  // バイナリで 0x00 を送信
      }
    }
  }
  prevCLK = currCLK;
}
