//import processing.opengl.*;
//import javax.media.opengl.GL;

import promidi.*;

int ctl[][] = new int[10][64];
import ddf.minim.analysis.*;
import ddf.minim.*;

int phase = 1;


////////////////// ONE ////////////////

ArrayList p;
String filenames[] = {
  "souhvezdi.txt", "people.txt", "brain.txt", "lines.txt", "city.txt"
};
int cycle = 0;

boolean pulsating = true;

PImage podklad;

float snapDist = 5.0;
float tras = 9;

PFont figurative,tiny;

float strokeW = 2;


////////////// TWO ////////////////////


Minim minim;
FFT fft;

//float tras = 0;

boolean boosh = false;


AudioInput in;



//PGraphicsOpenGL pgl; //need to use this to stop screen tearing
//GL gl;

//import codeanticode.gsvideo.*;
//GSMovieMaker mm;
int fps = 100;
//GSPipeline pipeline;

float vals[];
float cx, cy;


int mcntr = 0, minut=0;
boolean once = true;

MidiIO midiIO;







/////////// three ////////////



float rots[];


float rotsX[]; 
float rotsY[];
float rotsZ[];

float avg = 0;

float al = 40;





////////// four ///////////////


Shaper shaper;

int chill = 100;


float time1, time2;
float mezi = 250;

/////////////////////////////////

void setup() {

  size(1280, 720, P2D);
  frameRate(fps);
  // smooth();


  ///////////////////
  podklad = loadImage("people.jpg");

  p = new ArrayList();

  loadPoints();



  //////////////

  tiny = loadFont("65Amagasaki-8.vlw");
  figurative = loadFont("CharisSIL-BoldItalic-48.vlw");
  textMode(SCREEN);

  cx = width/2;
  cy = height/2;

  minim = new Minim(this);

  //  jingle = minim.loadFile("siteUnseen.mp3", 2048);
  vals = new float[1025];
  //jingle.play();

  in = minim.getLineIn(Minim.STEREO, 1024);


  //get an instance of MidiIO
  midiIO = MidiIO.getInstance(this);
  println("printPorts of midiIO");

  //print a list of all available devices
  midiIO.printDevices();

  //open the first midi channel of the first device
  midiIO.openInput(0, 0);

  preset();


  /////////////////////////// three /////////////////

  fft = new FFT(in.bufferSize(), in.sampleRate());

  rots = new float[in.bufferSize()];


  rotsX = new float[in.bufferSize()];
  rotsY = new float[in.bufferSize()];
  rotsZ = new float[in.bufferSize()];


/////////// four /////////////////////////////////

shaper = new Shaper(40);

  background(0);
}

/*
void keyPressed() {
 if (key == ' ') {
 mm.finish();
 exit();
 }
 }*/


int shift = 0;

void draw() {

  switch(phase) {
  case 1:
    jedna();
    break;
  case 2:
    dva();
    break;

  case 3:
    tri();
    break;
    
  case 4:
    ctyri();
    break;
    
    
  default:
    background(0);
  }
  // dva();
}



void keyPressed() {
  
  if (keyCode==ENTER) {
    time1 = time2;
    time2 = millis();

    mezi += ((time2-time1)-mezi)/1.2;

    chill = 50;
  }else if (keyCode==DELETE) {
    erasePoints();
  }
  else if (keyCode==RIGHT) {
    phase++;
  }
  else if (keyCode==LEFT) {
    phase--;
  }
  else {
    if (key=='s') {
      savePoints();
    }
    else if (key=='l') {
      loadPoints();
    }
    else if ((int)key-48 >= 1 && (int)key-48 <= 9) {
      cycle = (int)key-49;
      println(cycle);
      loadPoints();
    }
    else if (key==' ') {
      boosh=!boosh;
    }
  }
}




void controllerIn(promidi.Controller controller, int device, int channel) {
  try {
    int num = controller.getNumber();
    int val = controller.getValue();

    ctl[phase][num] = val;
    println(num + " - "+val);
  }
  catch(Exception e) {
  }
}

void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();

  super.stop();
}

