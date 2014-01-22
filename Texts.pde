class Texts {
  PFont infoFont;
  PFont gameOverFont;

  Texts() {
    infoFont = createFont("LucidaGrande-48", 31, true);
    gameOverFont = createFont("LucidaGrande-48", 48, true);
  }

  //display the score and lives
  void displayInfo (int score, int lives) {
    textAlign(LEFT);
    fill(255);
    textFont(infoFont);
    text("Score: "+score, 50, 50);
    text("Lives: "+lives, 50, 100);
  }

  //shows game over when out of lives
  void gameOver(int score) {
    background(0);
    textFont(gameOverFont);
    fill(255);
    textAlign(CENTER);
    text("GAME OVER", width/2, height/2);
    textFont(gameOverFont, 24);
    text("Final Score: "+score, width/2, height/2+50);
    text("Press 'R' to restart", width/2, height/2+100);
  }

  //introduction page
  void intro() {
    background(0);
    textFont(imagine);
    fill(255);
    textAlign(CENTER);
    text("Catfish! Catfish!", width/2, 100);
    textFont(infoFont, 13);
    text("YOU NEED TO BE SMART TO SURVIVE IN THE OCEAN...", width/2+200, 115);
    textFont(infoFont, 12);
    text("Created by: Tim Heng", width-80, height-20);
    textFont(infoFont, 18);
    text("Settings: ", 100, 470);
    textAlign(LEFT);
    textFont(infoFont, 12);
    text("Change the color of your fish:",60, 550);
    text("Enable shark:",60,740);
  }

  //enable instructions
  void inst() {
    background(0);
    fill(255);
    textFont(imagine);
    textAlign(CENTER);
    text("Catfish! Catfish!", width/2, 100);
    textFont(infoFont);
    textAlign(CORNER);
    text("Key Control", width/2+100, 200);

    stroke(255);
    noFill();
    rectMode(CENTER);
    rect(width/2+185, 300, 100, 100);
    textFont(infoFont, 18);
    textAlign(CENTER);
    text("W = UP", width/2+185, 300);
    rect(width/2+185, 410, 100, 100);
    text("S = DOWN", width/2+185, 410);
    rect(width/2+295, 410, 100, 100);
    text("D = RIGHT", width/2+295, 410);
    rect(width/2+75, 410, 100, 100);
    text("A = LEFT", width/2+75, 410);

    textFont(infoFont, 18);
    text("Settings: ", 100, 470);
    textAlign(LEFT);
    textFont(infoFont, 12);
    text("Change the color of your fish:",60, 550);
    text("Enable shark:",60,740);

    textFont(infoFont,12);
    textAlign(RIGHT);
    text("Use the Key Control to control your fish and try to eat as many fish as you can.", width-50, height-200);
    text("You can kill the shark by biting its tail for 3 times. HAVE FUN!", width-50, height-150);
  }
}

