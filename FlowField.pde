
class Point {
  float maxSpeed = 0;
  Boolean finished = false;
  float r = 0;
  float theta = random(PI*2);
  PVector vel, loc, acc;
  float saturation = random(100);
  Point(float x, float y) {
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    
  }

  void behavior1() {
    if (changeColor == true) {
      stroke(220, 10, 30, 60);
    } else if (changeColor == false) {
      colorMode(HSB,360,100,100);
      saturation = noise(loc.x*.01, loc.y*.01)*120;
      stroke(220,saturation,100, 70);
      colorMode(RGB,255);
    }
    strokeWeight(noise(loc.x*.01, loc.y*.01)*6);
    theta += 1;
    vel.x = sin(noise(loc.x*.01, loc.y*.01)*TWO_PI);
    vel.y = cos(noise(loc.x*.01, loc.y*.01)*TWO_PI);
    loc.x += vel.x;
    loc.y += vel.y;
    line(loc.x+vel.x, loc.y+vel.y, loc.x, loc.y);
  }

  //void behavior2(PVector target) {
  //  stroke(255, 20);
  //  strokeWeight(1);
  //  acc = target.sub(loc);
  //  acc.mult(0.01);
  //  vel.add(acc);
  //  loc.add(vel);
  //  if (abs(loc.x-width/2)<5 && abs(loc.y-height/2)<5) {
  //    this.finished =true;
  //  }
  //  point(loc.x, loc.y);
  //}

  void boundry() {
    if (loc.x>width) {
      this.finished = true;
    } else if (loc.x<0) {
      this.finished = true;
    }
    if (loc.y>height) {
      this.finished = true;
    } else if (loc.y<0) {
      this.finished = true;
    }

    if (vel.x>maxSpeed) {
      vel.x = maxSpeed;
    } else if (vel.x<-maxSpeed) {
      vel.x = -maxSpeed;
    }
    if (vel.y>maxSpeed) {
      vel.y = maxSpeed;
    } else if (vel.y<-maxSpeed) {
      vel.y = -maxSpeed;
    }
  }
}