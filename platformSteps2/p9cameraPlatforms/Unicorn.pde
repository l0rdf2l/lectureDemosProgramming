class Unicorn {

  float w, h, x, y, vx, vy, 
    accelerationX, accelerationY, 
    speedLimit;

  //world variables
  float friction, bounce, gravity;

  boolean isOnGround;
  float jumpForce;

  float halfWidth, halfHeight;
  String collisionSide;

  //image variables
  int currentFrame;
  boolean facingRight;
  int frameSequence;
  int frameOffset;

  color c;
  
  Unicorn() {
    w = 100;//was 140. shrink to be centered on body
    h = 65;//was 95. shrink to be centered on body
    x = 400 - w/2;
    y = (gameWorld.y + gameWorld.h/2) - h/2;
    vx = 0;
    vy = 0;
    accelerationX = 0;
    accelerationY = 0;
    speedLimit = 10;
    isOnGround = false;
    jumpForce = -10;

    //world values
    friction = 0.96;
    bounce = -0.7;
    gravity = .3;

    halfWidth = w/2;
    halfHeight = h/2;

    collisionSide = "";
    currentFrame = 0;
    facingRight = true;
    frameSequence = 6;//number of frames in each animation sequence
    frameOffset = 0;
    
    c = color(255);
  }

  void update() {
    //start all moves off with friction at 1

    if (left && !right) {
      accelerationX = -0.2;
      friction = 1;
      facingRight = false;
    }
    if (right && !left) {
      accelerationX = 0.2;
      friction = 1;
      facingRight = true;
    }
    if (!left&&!right) {
      accelerationX = 0;
    }

    if (up && !down && isOnGround) {
      //accelerationY = -0.2;
      //friction = 1;
      vy = jumpForce;
      isOnGround = false;
      //gravity = 0;
      friction = 1;
    }

    if (!up && down ) {
      //accelerationY = 0.2;
      //friction = 1;
    }

    //removing impulse reintroduces friction
    if (!up && !down && !left && !right) {
      friction = 0.96; 
      //gravity = 0.3;
    }

    vx += accelerationX;
    vy += accelerationY;

    //friction 1 = no friction
    vx *= friction;

    //apply gravity
    vy += gravity;

    ////correct for maximum speeds
    if (vx > speedLimit) {
      vx = speedLimit;
    }
    if (vx < -speedLimit) {
      vx = -speedLimit;
    }
    //need to let gravity ramp it up
    if (vy > 3 * speedLimit) {
      vy = 3 * speedLimit;
    }
    //don't need when jumping
    if (vy < -speedLimit) {
      vy = -speedLimit;
    }

    //correct minimum speeds
    if (abs(vx) < 0.2) {
      vx = 0;
    }

    if (abs(vy) < 0.2) {
      vy = 0;
    }

    ////move the player
    //x+=vx;
    //y+=vy;
    x = Math.max(0, Math.min(x + vx, gameWorld.w - w)); 
    y = Math.max(0, Math.min(y + vy, gameWorld.h - h));

    checkBoundaries();
    //checkPlatforms();
  }
  void checkPlatforms() {
    ////update for platform collisions
    if (collisionSide == "bottom" && vy >= 0) {
      if (vy < 1) {
        isOnGround = true;
        vy = 0;
      } else {
        //reduced bounce for floor bounce
        vy *= bounce/2;
      }
    } else if (collisionSide == "top" && vy <= 0) {
      vy = 0;
    } else if (collisionSide == "right" && vx >= 0) {
      vx = 0;
    } else if (collisionSide == "left" && vx <= 0) {
      vx = 0;
    }
    if (collisionSide != "bottom" && vy > 0) {
      isOnGround = false;
    }
  }

  void checkBoundaries() {
    ////check boundaries
    ////left
    if (x <= 0) {
      vx *= bounce;
      //x = 0;
      facingRight = !facingRight;
    }
    //// right
    if (x >= gameWorld.w - w) {
      vx *= bounce;
      //x = gameWorld.w - w;
      facingRight = !facingRight;
    }
    ////top
    if (y <= 0) {
      vy *= bounce;
      y = 0;
    }
    if (y >= gameWorld.h - h) {
      if (vy < 1) {
        isOnGround = true;
        vy = 0;
      } else {
        //reduced bounce for floor bounce
        vy *= bounce/2;
      }
      y = height - h;
    }
  }



  void display() {
    fill(0, 255, 0, 128);
    rect(x, y, w, h);
    tint(c);
    if (facingRight) {
      if (abs(vx) > 0) {
        image(spriteImages[currentFrame+0], x-27, y-27);
      } else {
        image(spriteImages[currentFrame+12], x-27, y-27);
      }
    } else {
      if (abs(vx) > 0) {
        image(spriteImages[currentFrame+6], x-10, y-27);
      } else {
        image(spriteImages[currentFrame+18], x-10, y-27);
      }
    }
    if (isOnGround) {
      currentFrame = (currentFrame + 1)%frameSequence;
    } else {
      currentFrame = 0;
    }
    tint(255);
  }
}
