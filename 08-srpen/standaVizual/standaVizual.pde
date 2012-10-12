/////////////////////////////////

float reaktivita = 1.0;
int sirka = 1024;
int vyska = 768;
int fps = 100;

//////////////////////////////////


import ddf.minim.analysis.*;
import ddf.minim.*;

int ctl[] = new int[64];

Minim minim;
FFT fft;

float tras = 0;

boolean boosh = false;


AudioInput in;

//////////////////////





float vals[];
float cx, cy;


int mcntr = 0,minut=0;
boolean once = true;
//////////////////////

void setup() {

  size(sirka, vyska, P2D);
  frameRate(fps);
  smooth();

  textFont(loadFont("65Amagasaki-8.vlw"));
  textMode(SCREEN);

  cx = width/2;
  cy = height/2;

  minim = new Minim(this);
  vals = new float[1025];
  in = minim.getLineIn(Minim.STEREO, 1024);

  println("printPorts of midiIO");

  preset();

  fft = new FFT(in.bufferSize(), in.sampleRate());

  background(0);
}

//////////////////////
int shift = 0;
void draw() { 
  jedna();
}

//////////////////////

void keyPressed() {
  if (key==' ') {
    boosh=!boosh;
  }
}


