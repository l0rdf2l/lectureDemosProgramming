class Catcher {
  float r;
  float x, y;

  Catcher(float tempRadius) {
    r = tempRadius;
    x = width/2;
    y = height/2;
  }
  void update() {
    x = mouseX;
    y = mouseY;
  }
  void display() {
    //stroke(255,0,0);
    //strokeWeight(2);
    noStroke();
    fill(0,255,0,128);
    ellipse(x,y,r*2,r*2);
    image(ship, x-r, y-r);
  }
}
