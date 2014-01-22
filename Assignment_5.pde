class GeneralFish { //Parent Class

  //Fields
  float fishX, fishY, velX, velY, fishSize, inc;
  color col1, col2, col3;
  boolean angle, collided;

  //Constructor
  GeneralFish() {
    fishX = random(width);
    fishY = random(height);
    velX = random(2);
    velY = random(2);
    fishSize = random(0.3,0.6);
    col1 = color(random(255),random(255),random(255));
    col2 = color(random(255),random(255),random(255));
    col3 = color(random(255),random(255),random(255));
    inc = 0.02;
  }

  //Movement method
  void update() {
    fishX += velX;
    fishY += velY*sin(inc);
    inc += 0.01;
  }

  //Draw method
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
    curve(-85,150,-65,0,65,0,85,150);
    curve(-85,-150,-65,0,65,0,85,-150);
    strokeWeight(1);
    line(10,0,-65,0);
    line(10,-10,-50,-10);
    line(10,10,-50,10);
    line(10,10,0,-15);
    line(0,15,-10,-15);
    line(-10,15,-20,-15);
    line(-20,15,-30,-15);
    line(-30,15,-40,-15);
    line(-40,15,-50,-10);
    line(-50,10,-58,-8);


    //the gill
    stroke(col1);
    strokeWeight(2);
    fill(col2);
    curve(65,-15,15,-15,15,15,65,15);

    //the tail
    fill(col2);
    triangle(-85,-20,-65,0,-85,20);
    line(-65,0,-85,-10);
    line(-65,0,-85,0);
    line(-65,0,-85,10);

    //the upper fin
    stroke(col1);
    fill(col1);
    curve(10,30,-50,-10,30,-16,20,150);

    //the lower fin
    curve(30,-30,-5,14,5,18,120,-70);

    //the antennas
    stroke(col1);
    noFill();
    curve(-150,-3,60,-3,-5,-40,85,-40);
    curve(-150,-3,60,3,-5,40,85,40);

    //the eye
    noStroke();
    fill(255);
    ellipse(40,-8,10,10);
    fill(0);
    ellipse(40,-8,5,5);

    //the mouth
    fill(col3);
    ellipse(60,0,5,10);
    popMatrix();
  }

  //Walls checking method
  void walls() {
    if ((fishX+(65*fishSize)) > width) {
      fishX = width-(65*fishSize);
    }
    if ((fishX-(65*fishSize)) < 0) {
      fishX = (65*fishSize);
    }
    if ((fishY+(27*fishSize)) > height) {
      fishY = height-(27*fishSize);
    }
    if ((fishY-(27*fishSize)) < 0) {
      fishY = (27*fishSize);
    }
  }

  //Kill fish method
  void destroy(ArrayList fish) {
    fish.remove(this);
  }

  //Check the collision between fish
  boolean detectCollision(GeneralFish otherFish) {
    if (dist(fishX, fishY, otherFish.fishX, otherFish.fishY) < (65*fishSize)+(65*otherFish.fishSize) || (dist(fishX, fishY, otherFish.fishX, otherFish.fishY) < (15*fishSize)+(15*otherFish.fishSize))) {
      return true;
    }
    return false;
  }

  //Fish bouncing off each other
  void bounce(EnemyFish otherFish) {
    if (dist(fishX, fishY, otherFish.fishX, otherFish.fishY) < (65*fishSize)+(65*otherFish.fishSize) || (dist(fishX, fishY, otherFish.fishX, otherFish.fishY) < (15*fishSize)+(15*otherFish.fishSize))) {
      float angle = atan2(fishY - otherFish.fishY, fishX - otherFish.fishY);
      velX = 1 * cos(angle);
      velY = 1 * sin(angle);
      otherFish.velX = 1 * cos(angle - PI);
      otherFish.velY = 1 * sin(angle - PI);
    }
  }

  //Check if the fish is facing each other
  boolean checkHeadOn(GeneralFish otherFish) {
    if(velX*otherFish.velX < 0) {
      return true;
    }
    return false;
  }

  //Draw traces
  void drawTraces(GeneralFish otherFish) {
    strokeWeight(5);
    stroke(otherFish.col2);
    noFill();
    ellipse(otherFish.fishX, otherFish.fishY, 50, 50);
    ellipse(otherFish.fishX, otherFish.fishY, 75, 75);
    ellipse(otherFish.fishX, otherFish.fishY, 100, 100);
  }
}

