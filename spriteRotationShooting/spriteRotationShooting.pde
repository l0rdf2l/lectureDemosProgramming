//true rotated rectangle collision detection
//https://www.gamedev.net/articles/programming/general-and-gameplay-programming/2d-rotated-rectangle-collision-r2604
//this is pseudo rotated rect collision

Sprite s;
Enemy e;
boolean left, right, up, down, space;
PImage spriteImage;
PImage enemyImage;

Timer firingTimer;
Bullet [] bullets;
int nextBullet;

void setup() {
  size(800, 600);
  background(255);
  smooth();

  spriteImage = loadImage("data/unicorn0001.png");
  s = new Sprite();
  e = new Enemy();

  bullets = new Bullet [100];
  for (int i = 0; i < bullets.length; ++i) {
    bullets[i] = new Bullet();
  }
  nextBullet = 0;

  firingTimer = new Timer(50);
  firingTimer.start();//shift to appropriate state function once states are implemented

  left = false;
  right = false;
  up = false;
  down = false;
  space = false;
}

void draw() {
  background(255);
  s.update();
  s.display();
  e.display();

  ////bullets
  if (space) {
    if (firingTimer.complete()) {
      bullets[nextBullet].fire(s.x, s.y, s.rotation);
      nextBullet = (nextBullet+1)%bullets.length;
      firingTimer.start();
    }
  }
  for (int i = 0; i < bullets.length; ++i) {
    bullets[i].update();
    //will need something like this to manage the enemy collisions
    //for (int j = 0; j < enemies.length; j++) {
    //  if (rectangleCollisionBvE(bullets[i], enemies[j]) && !enemies[j].dead) {
    //    enemies[j].die();
    //    bullets[i].reset();
    //    score += 20;
    //  }
    //}
  }
  
  for (int i = 0; i < bullets.length; ++i) {
    bullets[i].display();
  }

  if (rectangleIntersect(s, e)) {
    fill(255, 255, 0, 128);
    rect(0, 0, width, height);
  }
}
boolean rectangleIntersect(Sprite r1, Enemy r2) {
  //what is the distance apart on x-axis
  float distanceX = (r1.x + r1.w/2) - (r2.x + r2.w/2);
  //what is the distance apart on y-axis
  float distanceY = (r1.y + r1.h/2) - (r2.y + r2.h/2);

  //what is the combined half-widths
  float combinedHalfW = r1.w/2 + r2.w/2;
  //what is the combined half-heights
  float combinedHalfH = r1.h/2 + r2.h/2;

  //check for intersection on x-axis
  if (abs(distanceX) < combinedHalfW) {
    //check for intersection on y-axis
    if (abs(distanceY) < combinedHalfH) {
      //huzzah they are intersecting
      return true;
    }
  }
  return false;
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
