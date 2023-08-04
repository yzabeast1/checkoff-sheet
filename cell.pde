int hoverColor=200;
int nonHoverColor=255;
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
    if (!mouseOverRow())fill(value?color(0, nonHoverColor, 0):color(nonHoverColor, 0, 0));
    else fill(value?color(0, hoverColor, 0):color(hoverColor, 0, 0));
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
  boolean mouseOverRow() {
    return mouseY>y&&mouseY<y+h;
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
    fill(mouseOverRow()?color(hoverColor):color(nonHoverColor));
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(h);
    text(text, x+w/2, y+h/3);
  }
  boolean mouseOverRow() {
    return mouseY>y&&mouseY<y+h;
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
    if (!mouseOverRow())fill(boolean(value)?color(0, nonHoverColor, 0):color(nonHoverColor, 0, 0));
    else fill(boolean(value)?color(0, hoverColor, 0):color(hoverColor, 0, 0));
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
  boolean mouseOverRow() {
    return mouseY>y&&mouseY<y+h;
  }
}
