/**
 * Autoscroll pro Standu
 * mezernik: vyp. / zap. skrolovani
 * sipka nahoru / dolu: meni pocet preskocenych radku
 * sipka doleva / doprava: meni kadenci scroll
 *
 * kof, 2012
 */

///// limit skrolovani ////////////////////////
int limit = 300;
/////////////////////////////


///// rychlost skrolovani ////////////////////
int slowdown = 1;
////////////////////////////////////////////////





int counter = 0;

import java.awt.Robot;
Robot robot;

boolean scrolling = false;
int speed = 1;
////////////////////////////////////////

void setup() {
  size(200, 150);

  frameRate(25);

  try {
    robot = new Robot();
  }
  catch(Exception e) {
    println("Chyba: "+e);
  }

  textFont(loadFont("SempliceRegular-8.vlw"));
}


////////////////////////////////////////

void draw() {
  background(0);
  fill(255);
  text("Skrolování: ", 20, 20);

  if (scrolling) {
    fill(0, 255, 0);
    text(" zapnuto!");
  }
  else {
    fill(255, 0, 0);
    text(" vypnuto!");
  }

  fill(255);
  text("Rychlost: "+speed, 20, 32);

  if (frameCount % slowdown == 0) {
    if (scrolling) {
      robot.mouseWheel(speed);
      counter+=speed;
    }
    fill(255, 0, 0);
    noStroke();
  }
  else {
    fill(255);
  }
  text("FPS: "+slowdown, 20, 46);
  rect(160, 12, 20, 20);

  text("counter: "+counter, 20, 58);
  
  if(counter>=limit){
    robot.mouseWheel(-limit);
    counter =0 ;
  }
}

////////////////////////////////////////

void keyPressed() {
  if (key == ' ') {
    scrolling = !scrolling;
  } 
  else if (keyCode==UP) {
    speed--;
  }
  else if (keyCode==DOWN) {
    speed++;
  }
  else if (keyCode==LEFT) {
    slowdown++;
    slowdown = constrain(slowdown, 0, 1000);
  }
  else if (keyCode==RIGHT) {
    slowdown--;
    slowdown = constrain(slowdown, 0, 1000);
  }
}

