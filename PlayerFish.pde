class PlayerFish extends GeneralFish { //Child class
  float speed = 5; //Controlling speed

  //Constructor
  PlayerFish() {
    super();
    fishSize = 0.4;
    col1 = color(r1, g1, b1);
    col2 = color(r2, g2, b2);
    col3 = color (150,0,0);
  }

  //Eat enemy fish method
  void eat(EnemyFish otherFish) {
    if (fishSize > otherFish.fishSize && detectCollision(otherFish) && checkHeadOn(otherFish)) {
      if (fishSize < 2) fishSize *= 1.1;
      otherFish.destroy(enemyFish);
      if (otherFish.fishSize > 0.95*fishSize) score += 40;
      if (otherFish.fishSize > 0.5*fishSize && otherFish.fishSize < 0.95*fishSize) score += 20;
      if (otherFish.fishSize < 0.5*fishSize) score += 10;
    }
  }

  //Eat shark method
  void eat(Shark otherFish) {
    if ((dist(fishX, fishY, otherFish.fishX, otherFish.fishY) < ((150*otherFish.fishSize)+(65*fishSize))) && (!checkHeadOn(otherFish))) {
      otherFish.bodyColor = 255;
      otherFish.live--;
      otherFish.velX *= -1;
    }
  }


  //Controller
  void moveUp() {
    fishY -= speed;
  }
  void moveDown() {
    fishY += speed;
  }
  void moveLeft() {
    if (velX > 0) {
      velX *= -1;
    }
    fishX -= speed;
  }
  void moveRight() {
    if (velX < 0) {
      velX += speed;
    }
    fishX += speed;
  }
}

