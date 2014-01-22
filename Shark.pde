class Shark extends EnemyFish {
  int live = 3; //shark's health
  int timer = 50; //a timer

  color bodyColor = color(139,180,227);
  color eyeColor = color(176,0,17);

  //a constructor
  Shark() {
    super();
    fishSize = 0.7;
  }

  //another constructor (overloading contructor)
  Shark(float fishX) {
    super();
    fishSize = 0.7;
    this.fishX = fishX;
    if (this.fishX == width) {
      if (velX > 0) {
        velX *= -1;
      }
    }
  }


  //update method (movement)
  void update() {
    timer--;
    fishX += velX;
    fishY += velY*sin(inc);
    inc += 0.01;
    if (timer == 0) { //time the body color when the tail is bitten
      bodyColor = color(139,180,227);
      timer = 100;
    }
  }

  //drawMe method
  void drawMe() {
    pushMatrix();
    translate(fishX,fishY);
    if (velX > 0) {
      rotateY(PI);
    }
    scale(fishSize);
    //head&body
    fill(bodyColor);
    strokeWeight(2);
    stroke(0);
    curve(-200,500,-200,0,200,0,1000,500);
    curve(-200,-500,-200,0,200,0,1000,-500);
    curve(-180,-30,-180,20,-100,10,-150,20);
    line(-96,20,-106,-5);

    //tail
    triangle(200,0,250,50,270,-100);

    //gill
    line(-60,-30,-50,0);
    line(-50,0,-60,30);
    line(-50,-30,-40,0);
    line(-40,0,-50,30);
    line(-40,-30,-30,0);
    line(-30,0,-40,30);

    //the eye
    fill(eyeColor);
    line(-150,-30,-110,-40);
    curve(-150,-90,-150,-30,-110,-40,-110,-100);

    //fins
    fill(bodyColor);
    beginShape();
    curveVertex(-80,-62);
    curveVertex(-80,-62);
    curveVertex(-50,-110);
    curveVertex(-30,-62);
    curveVertex(-40,-62);
    endShape(CLOSE);
    beginShape();
    curveVertex(-70,50);
    curveVertex(-70,50);
    curveVertex(-10,110);
    curveVertex(-30,50);
    curveVertex(-30,50);
    endShape();
    popMatrix();
  }

  //Check if the fish hits the wall (overriding)
  void walls() {
    if ((fishX-(200*fishSize)) > width) {
      alive--;
    }
    if ((fishX+(200*fishSize)) < 0) {
      alive--;
    }
    if ((fishY-(50*fishSize)) > height) {
      alive--;
    }
    if ((fishY+(50*fishSize)) < 0) {
      alive--;
    }
  }

  //die method, when the shark's live is 0
  void die() {
    if (live <= 0) {
      fill(255);
      bodyColor = 255;
      //      curve(fishX-150,fishY+500,fishX-150,fishY,fishX+150,fishY,fishX+150,fishY);
      //      curve(fishX-150,fishY,fishX-150,fishY,fishX+150,fishY,fishX+150,fishY-500);
      beginShape();
      vertex(fishX-150,fishY);
      vertex(fishX-130,fishY-100);
      vertex(fishX-100,fishY-80);
      vertex(fishX,fishY-90);
      vertex(fishX+150,fishY-30);
      vertex(fishX+150,fishY+50);
      vertex(fishX,fishY+50);
      vertex(fishX-100,fishY+80);
      endShape(CLOSE);
      fill(eyeColor);
      line(fishX-150,fishY-30,fishX-110,fishY-40);
      curve(fishX-150,fishY-90,fishX-150,fishY-30,fishX-110,fishY-40,fishX-110,fishY-100);
      velX=0;
      fishY+=5;
      if (live == 0 || fishX == height) {
        score += 400;
        lives ++;
      }
    }
  }

  //eat player fish method
  boolean eat(PlayerFish otherFish) {
    if ((dist(fishX, fishY, otherFish.fishX, otherFish.fishY) < 150*fishSize) && checkHeadOn(otherFish)) {
      return true;
    } 
    else {
      return false;
    }
  }

  //Fish bouncing off each other
  void bounce(EnemyFish otherFish) {
    if (dist(fishX, fishY, otherFish.fishX, otherFish.fishY) < ((200*fishSize)+(65*otherFish.fishSize)) || dist(fishX, fishY, otherFish.fishX, otherFish.fishY) < ((15*fishSize)+(15*otherFish.fishSize))) {
      float angle = atan2(fishY - otherFish.fishY, fishX - otherFish.fishY);
      velX = 1 * cos(angle);
      velY = 1 * sin(angle);
      otherFish.velX = 1 * cos(angle - PI);
      otherFish.velY = 1 * sin(angle - PI);
    }
  }
}

