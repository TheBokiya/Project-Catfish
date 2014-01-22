class EnemyFish extends GeneralFish { //Child class

  int alive = 60; //Enemy fish health

  //Constructor
  EnemyFish() {
    super(); //Inherit from the parent class
  }

  //Another constructor (Overloading)
  EnemyFish(float fishX) {
    super();
    this.fishX = fishX;
    if (this.fishX == width) {
      if (velX > 0) {
        velX *= -1;
      }
    }
  }

  //Draw method (Overriding)
  void drawMe() {
    pushMatrix();
    translate(fishX,fishY);
    if (velX < 0) {
      rotateY(PI);
    }
    scale(fishSize);
    //the body&head
    stroke(col1);
    strokeWeight(2);
    fill(col2);
    ellipse(0, 0, 100, 70);


    //the gill
    stroke(col1);
    strokeWeight(2);
    fill(col2);
    curve(65,-15,15,-15,15,15,65,15);

    //the tail
    fill(col2);
    triangle(-85,-20,-50,0,-85,20);


    //the lower fin
    curve(30,-30,-5,14,5,18,120,-70);

    //the eye
    noStroke();
    fill(255);
    ellipse(40,-8,10,10);
    fill(0);
    ellipse(40,-8,5,5);

    //the mouth
    fill(col3);
    ellipse(45,0,5,10);
    popMatrix();
  }

  //Check if the fish hits the wall (overriding)
  void walls() {
    if ((fishX-(65*fishSize)) > width) {
      alive--;
    }
    if ((fishX+(65*fishSize)) < 0) {
      alive--;
    }
    if ((fishY-(15*fishSize)) > height) {
      alive--;
    }
    if ((fishY+(30*fishSize)) < 0) {
      alive--;
    }
    if (alive < 0) {
      enemyFish.remove(this);
      destroy(enemyFish);
    }
  }
  
  //Enemy fish eats the player fish
  boolean eat(PlayerFish otherFish) {
    if (fishSize > otherFish.fishSize && detectCollision(otherFish) && checkHeadOn(otherFish)) {
        return true;
      }
    return false;
  }
}

