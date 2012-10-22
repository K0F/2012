
import controlP5.*;
import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;

//float r = 300.0;

FFT fft;


ControlP5 cp5;

Tab one, two, three, four, five, six, seven, eight, nine;

ControlWindow controlWindow;

float fade = 0;

float alphas[];
boolean on1, on2, on3, on4, on5, on6, on7, on8, on9;

boolean guidone = false;
boolean inv = false;

void setup() {

  alphas = new float[3];


  size(1024, 768, P2D); 

  rectMode(CENTER);
  frameRate(100);
  colorMode(HSB);
  background(0);
  noCursor();

  setupOne();
  setupThree();
  setupFour();
  setupFive();
  setupSix();
  setupSeven();
  setupEight();
  
}

void init() {
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify(); 
  super.init();
}

void draw() {
  // background(0);

  if (frameCount==50) {
    frame.setLocation(0, 0);
    initGUI();
  }

  if (on1) {
    one();
  }


  if (on2) {
    two();
  }

  if (on3) {
    three();
  }

  if (on4) {
    four();
  }

  if (on5) {
    five();
  }

  if (on6) {
    six();
  }


  if (on7) {
    seven();
  }



  if (on8) {
    eight();
  }


  if (fade>=10) {
    rectMode(CORNER);
    resetMatrix();
    noStroke();
    fill(0, fade);
    rect(0, 0, width, height);
  }

  //blend(g,0,0,width,height,0,0,width,height,OVERLAY);
}

