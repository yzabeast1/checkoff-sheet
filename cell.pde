class checkCell {
  boolean value=false;
  int x, y, w, h;
  checkCell(int x, int y, int w, int h) {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
  }
  void draw() {
    fill(value?color(0, 255, 0):color(255, 0, 0));
    rect(x, y, w, h);
  }
  void mousePressed() {
    if (mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h) {
      if (value) {
        totalDone--;
        totalUndone++;
      } else {
        totalDone++;
        totalUndone--;
      }
      value=!value;
    }
  }
}
class textCell {
  boolean value=false;
  int x, y, w, h;
  String text;
  textCell(int x, int y, int w, int h, String text) {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.text=text;
  }
  void draw() {
    fill(255);
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(h);
    text(text, x+w/2, y+h/3);
  }
}
class numberCell {
  int value=0;
  int x, y, w, h;
  numberCell(int x, int y, int w, int h) {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
  }
  void draw() {
    fill(boolean(value)?color(0, 255, 0):color(255, 0, 0));
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    text((boolean(value)?str(value):(" ")), x+w/2, y+h/2);
  }
  void mousePressed() {
    if (mouseX>x&&mouseX<x+w/2&&mouseY>y&&mouseY<y+h) {
      if (value==1) {
        totalUndone++;
      }
      if (value>0) {
        totalDone--;
        value--;
      }
    }
    if (mouseX>x+w/2&&mouseX<x+w&&mouseY>y&&mouseY<y+h) {
      value++;
      totalDone++;
      if (value==1)totalUndone--;
    }
  }
}
//class cell {
//  int x, y, w, h;
//  cell(int x, int y, int w, int h) {
//    this.x=x;
//    this.y=y;
//    this.w=w;
//    this.h=h;
//  }
//}
