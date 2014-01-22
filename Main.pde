import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import controlP5.*;

//Instantiation
ControlP5 controlP5;
boolean start;
boolean instructions;
boolean have_shark;
boolean restart;
float size;
int r1, g1, b1, r2, g2, b2;
PImage backgroundImage; //Background Image
PFont imagine;  //Font

//Song variables
Minim minim;
AudioPlayer song;
FFT fft;

//Variables
ArrayList enemyFish = new ArrayList();
PlayerFish avatar;
Shark shark;
boolean up, down, left, right;
int amount_of_enemy_fish = 1;
int score;
int lives = 5;
color c = color(random(255),random(255),random(255));
boolean gameOver = false;
Texts txt = new Texts();

//Key control
void keyPressed() {
  if (key == 'w') up = true;
  if (key == 's') down = true;
  if (key == 'a') left = true;
  if (key == 'd') right = true;
}

//keyReleased
void keyReleased() {
  if (key == 'w') up = false;
  if (key == 's') down = false;
  if (key == 'a') left = false;
  if (key == 'd') right = false;
}

//Respawn
PlayerFish respawn() {
  return new PlayerFish();
}

void setup() {
  size (1024,768,OPENGL);
  smooth();
  controlP5 = new ControlP5(this);
  minim = new Minim(this);
  song = minim.loadFile("Fireflies.mp3");
  song.loop();
  fft = new FFT(song.bufferSize(), song.sampleRate());
  imagine = loadFont("imagine-font-65.vlw");

  //intro page
  txt.intro();

  //toggles for start and instructions page
  controlP5.addToggle("start", false, 100, 200, 100, 25);
  controlP5.addToggle("instructions", false, 100, 250, 100, 25);

  //sliders for color of the player fish's body and stroke
  controlP5.addSlider("amount_of_enemy_fish", 0, 8, 1, 100, 500, 100, 15);
  controlP5.addSlider("r1", 0, 255, 0, 60, 560, 100, 15);
  controlP5.addSlider("g1", 0, 255, 0, 60, 580, 100, 15);
  controlP5.addSlider("b1", 0, 255, 0, 60, 600, 100, 15);

  controlP5.addSlider("r2", 0, 255, 0, 60, 640, 100, 15);
  controlP5.addSlider("g2", 0, 255, 0, 60, 660, 100, 15);
  controlP5.addSlider("b2", 0, 255, 0, 60, 680, 100, 15);

  controlP5.addToggle("have_shark", false, 150, 720, 100, 25);
  backgroundImage = loadImage("underwater2.jpg"); //Loading image
  for (int i = 0; i < amount_of_enemy_fish; i++) {
    enemyFish.add(new EnemyFish());
  }
  avatar = respawn();
  shark = new Shark();
}

void draw() {
  drawSample(400,600);
  if (start) {
    playGame();
    txt.displayInfo(score, lives);
    controlP5.hide();
    avatar.col1 = color(r1,g1,b1);
    avatar.col2 = color(r2,g2,b2);
    if (lives <= 0) { 
      txt.gameOver(score);
      if (key == 'r') { //restart the game by pressing r when the game is over
        shark.live = 3;
        lives = 5;
        score = 0;
      }
    }
  }
  if(instructions) {
    txt.inst();
    drawSample(400,600);
  }
}














//a method to start the game
void playGame() {
  image(backgroundImage,0,0);  //Set the image as the background
  fft.forward(song.mix);
  float song = fft.getBand(0);
  noFill();
  strokeWeight(3);
  stroke(c);
  ellipse(710,405,song,song);
  ellipse(730,400,song,song);
  fill(song);
  textAlign(CENTER);
  textFont(imagine, 65);
  text("Catfish! Catfish!", width/2, height/2);
  if (up) avatar.moveUp();
  if (down) avatar.moveDown();
  if (left) avatar.moveLeft();
  if (right) avatar.moveRight();

  avatar.walls();
  avatar.drawMe();

  if (have_shark) {
    shark.drawMe();
    shark.update();
    shark.walls();
    shark.die();

    //Shark eats the player fish
    if (shark.eat(avatar)) {
      shark.drawTraces(avatar); 
      avatar = respawn();
      shark.live = 3;
      lives--;
    }

    //Eat shark
    avatar.eat(shark);

    if (shark.alive < 0) {
      if (random(0,2) > 1) shark = new Shark(0);
      else shark = new Shark(width);
    }
  }








  for (int i=0; i<enemyFish.size(); i++) {
    EnemyFish enemyFishi = (EnemyFish)enemyFish.get(i);
    enemyFishi.drawMe();
    enemyFishi.update();
    enemyFishi.walls();

    //Eat player fish
    if (enemyFishi.eat(avatar)) {
      enemyFishi.drawTraces(avatar);
      avatar = respawn();
      lives--;
    }

    //Shoot in random location
    if (enemyFish.size() < amount_of_enemy_fish) {
      if (random(0,2) > 1) {
        enemyFish.add(new EnemyFish(0));
      } 
      else {
        enemyFish.add(new EnemyFish(width));
      }
    }

    //Eat enemy fish
    avatar.eat(enemyFishi);
    if (enemyFish.size() < amount_of_enemy_fish) {
      avatar.drawTraces(enemyFishi);
    }


    //Fish bouncing off each other
    for (int j=0; j<enemyFish.size(); j++) {
      EnemyFish enemyFishj = (EnemyFish)enemyFish.get(j);
      if (i != j) {
        enemyFishj.bounce(enemyFishi);
      }
    }
    shark.bounce(enemyFishi);
  }
}

//the method to illustrate a sample fish when choosing the color
void drawSample(int x, int y) {
  pushMatrix();
  translate(x,y);
  rectMode(CENTER);
  fill(128);
  noStroke();
  rect(0,0,200,100);
  //the body&head
  stroke(r1, g1, b1);
  strokeWeight(2);
  fill(r2, g2, b2);
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
  stroke(r1, g1, b1);
  strokeWeight(2);
  fill(r2, g2, b2);
  curve(65,-15,15,-15,15,15,65,15);

  //the tail
  fill(r2, g2, b2);
  triangle(-85,-20,-65,0,-85,20);
  line(-65,0,-85,-10);
  line(-65,0,-85,0);
  line(-65,0,-85,10);

  //the upper fin
  stroke(r1, g1, b1);
  fill(r1, g1, b1);
  curve(10,30,-50,-10,30,-16,20,150);

  //the lower fin
  curve(30,-30,-5,14,5,18,120,-70);

  //the antennas
  stroke(r1, g1, b1);
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
  fill(150,0,0);
  ellipse(60,0,5,10);
  popMatrix();
}

