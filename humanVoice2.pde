import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
Boolean md = false;
ArrayList points = new ArrayList();
ArrayList fs = new ArrayList();

int num = 0;
boolean test = false;
boolean state = false;
boolean record = false;
float time;
boolean switch3 = false;
float timer3 = 0.0;
float interval = 500.0;
float acc = 1;
boolean changeColor = false;
int fillcolor = 255;

void setup() {
  //fullScreen();
  size(1280, 800, P3D);
  background(0);
  //////////////////////////////////////////////////
  minim = new Minim(this);
  song = minim.loadFile("the dry banks.mp3", 2048);
  //song.loop();
  beat = new BeatDetect();
  ////////////////////////////////////////
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("192.168.0.8", 12000);
  ////////////////////////////////////////////////////
}

void draw() {
  float initial = random(width);
  fill(0, 30);
  //if no voice, blank the canvas
  if (ampValue < 65 && frameCount%5 ==0) {
    rect(0, 0, width, height);
  }
  //beat.detect(song.mix);
  /*if vioce has been detected, start drawing*/
  if (ampValue > 65) {
    for (int i=0; i<1; i++) {
      points.add(new Point(initial+random(-20, 20), random(height-100, height)));
    }
    num++;
  }
  /* level 1 particles display */
  noiseDetail(8, 0);
  for (int i=points.size()-1; i>0; i--) {
    Point p = (Point)points.get(i);
    p.behavior1();
    p.boundry();
    if (p.finished) {
      points.remove(i);
    }
  }
  /*level2: if both pitch and amp are high, start blooming */
  if (pitchValue>340 && ampValue>70 && points.size()>0 && fs.size()<12) {
    if (test == false && frameCount%10 == 0) {
      int k = int(random(points.size()));
      Point p = (Point)points.get(k); 
      PVector pos = p.loc;
      PVector vel = p.vel;
      fs.add(new singleFlower(pos, vel));
      int last = fs.size()-1;
      singleFlower sF = (singleFlower)fs.get(last);
      sF.addPetal();
      test = true;
    }
  }
  if (pitchValue<=360 || ampValue<65 ) {
    test = false;
  }
  /*****level 2: flowers display **************************/
  //if (fs.size()>=1) {
  //  int i = fs.size()-1;
  //  singleFlower k = (singleFlower)fs.get(i);\
  //  k.update();
  //  k.run();
  //  k.check();
  //  if (k.finished == true) {
  //    fs.remove(i);
  //  }
  //}
  for (int i = fs.size()-1; i>=0; i--) {
    singleFlower k = ( singleFlower)fs.get(i);
    k.run();
    k.check();
    if (k.finished == true) {
      fs.remove(i);
    }
  }
  println(frameRate, "kakaakakakak");
  /********* level 3 initialize ************/
  if (fs.size()>9 && ampValue >75) {
    switch3 = true;
  } else if (fs.size()<10 || ampValue <60) {
    changeColor = false;
    switch3 = false;
  }
  if (switch3 == true) {
    if (timer3 < 5) {
      if (acc == -1) {
        fill(0, 80);
        changeColor = true;
      } else if ( acc == 1) {
        fill(255, 80);
        changeColor = false;
      }
      rect(0, 0, width, height);
      timer3 ++;
    } else {
      timer3 =0; 
      acc *= -1;
    }
    switch3 = false;
  }
  //////////////////////////////////////////////
}