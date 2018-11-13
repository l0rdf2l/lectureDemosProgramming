//jumping
//TODO: platform, images, platforms, shooting, enemies

Unicorn u;

boolean left, right, up, down, space;

void setup() {
  size(800, 600);

  left = false;
  right = false;
  up = false;
  down = false;
  space = false;


  //unicorn values
  u = new Unicorn();
}

void draw() {
  background(255);
  u.update();
  u.display();
  displayPositionData();
}

void displayPositionData() {
  fill(0);
  String s = "\nvx: "+u.vx+"  vy: "+u.vy + 
    "\ncollisionSide: "+u.collisionSide;
  text(s, 50, 50);
}

void keyPressed() {
  switch (keyCode) {
  case 37://left
    left = true;
    break;
  case 39://right
    right = true;
    break;
  case 38://up
    up = true;
    break;
  case 40://down
    down = true;
    break;
  case 32: //space
    space = true;
    break;
  }
}
void keyReleased() {
  switch (keyCode) {
  case 37://left
    left = false;
    break;
  case 39://right
    right = false;
    break;
  case 38://up
    up = false;
    break;
  case 40://down
    down = false;
    break;
  case 32: //space
    space = false;
    break;
  }
}
