import processing.serial.*;
import processing.video.*;

Serial myPort;
Movie movie1;
Movie movie2;

//動画を増やす場合以下をコピーして数字を増やす
///////////////////////////////
//Movie movie3;

int val = 0;
boolean condition1 = false;
boolean condition2 = false;

void setup() {
  //画面サイズを設定
  //////////////////////////////////
  size(560, 400);
  background(0);

  //データの受け取り方の設定
  ///////////////////////////////////////////
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);

  //動画1と動画2を読み込み(""の中にファイル名を書く)
  ///////////////////////////////////////////
  movie1 = new Movie(this, "Sample1.mp4");
  movie2 = new Movie(this, "Sample2.mp4");
  //3本以上使う場合はコピーして数字を増やす
  ///////////////////////////////////////////
  //movie3 = new Movie(this, "Sample3.mp4");
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read();         // read it and store it in val
    //センサの値を確認
    println(val);
  }

  //センサのデータを受け取るところ
  ////////////////////////////////////////////////////////////////

  //if()の中で閾値を変更
  //光センサ、温度センサ、音の大きさは(0~255)で設定
  //回転は時計回りだと0、反時計回りだと255
  //タッチセンサは0が触れてない、1が触れている
  ////////////////////////////////////////////////////////////////
  if (val < 127) { //この行を変更 初期値:センサの値が127未満の場合
    //動画2を停止
    movie2.pause();
    if (condition1 == false) {
      //動画1を最初からループ再生
      movie1.jump(0);
      movie1.loop();
      condition1 = true;
    } else if (condition1 == true) {
      movie1.loop();
    }
    //実際に動画1のコマを描画する
    image(movie1, 0, 0, width, height);
    condition2 = false;
    //if()の中で閾値を変更
    //光センサ、温度センサ、音の大きさは(0~255)で設定
    //回転は1だと左回り、2だと右回り
    //タッチセンサは0が触れてない、1が触れている
    ////////////////////////////////////////////////////////////////
  } else if (val >= 127) { //この行を変更 初期値:センサの値が127以上の場合
    //動画1を停止
    movie1.pause();
    if (condition2 == false) {
      //動画2の最初からループ再生
      movie2.jump(0);
      movie2.loop();
      condition2 = true;
    } else if (condition2 == true) {
      movie2.loop();
    }
    image(movie2, 0, 0, width, height);
    condition1 = false;
  }
  //動画を増やす場合/*と*/の間をコピーして1行前にペーストし、movieの数字を増やしてセンサの閾値を変更する
  /////////////////////////////////////////////////////
  /*
    else if (mouseY < height /2) {
   //動画1を停止
   movie1.pause();
   if (condition2 == false) {
   //動画2の最初からループ再生
   movie2.jump(0);
   movie2.loop();
   condition2 = true;
   } else if (condition2 == true) {
   movie2.loop();
   }
   image(movie2, 0, 0, width, height);
   condition1 = false;
   }
   */
}
