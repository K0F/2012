/**
*
*    Spectral Scenery, kof 2012, PAF Olomouc
*
*/


import promidi.*;

import oscP5.*;
import netP5.*;

import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;




import processing.opengl.*;
import javax.media.opengl.*;


boolean sw = true;
boolean dumbie = true;


///////////////////////////////////////////////////

float sx = 0, sy = 0, sz = 0;
float zoom = 100.0;

int maxW; 

PGraphicsOpenGL pgl;
GL gl;

int mode = 0;

boolean ogl = false;

int W = 0, H = 0;

PGraphics img;
OscP5 oscP5;

int crop = 0;

float sc = 200.0;
int detail = 3;

PeasyCam cam;
ArrayList[] vals;

Minim minim;
FFT fft;


MidiIO midiIO;
MidiOut midiOut;
PeasyDragHandler ZoomDragHandler;


DumbSender dumb;

void enableVSync()
{
  pgl = (PGraphicsOpenGL)g;
  gl = pgl.beginGL( );
  gl.setSwapInterval( 1 ); // use value 0 to disable v-sync
  pgl.endGL( );

  hints();
}

void hints() {
}


boolean hasSignal = false;
int oscInput = 1;
float valInput = 1;

AudioInput in;

PFont font, font2;

int ctl[];
// preset 1, group 2

int ctlMap[] = {
  9, 10, 11, 12, 13, 14, 15, 16, 
  81, 82, 83, 84, 85, 86, 87, 88, 
  89, 90, 91, 92, 93, 94, 95, 96, 
  97, 98, 99, 100, 101, 102, 103, 104
};


String txt = "kof & lasonick";

////////////////////////////////////////////////////////

void setup() {
  size(1280, 720, ogl ? OPENGL : P3D);

  noiseSeed(7);

  hints();
  frameRate(60);
  noSmooth();
  ctl = new int[32];

  if (ogl)
    enableVSync();

  cam = new PeasyCam(this, 700);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(5000);
  cam.setActive(true);


  //ZoomDragHandler = cam.getZoomDragHandler();
  //ZoomDragHandler.handleDrag(10,10);

  midiIO = MidiIO.getInstance(this);
  println("printPorts of midiIO");
  midiIO.printDevices();
  println();
  midiIO.openInput(0, 0);
  midiOut = midiIO.getMidiOut(0, 1);

  initMidi();


  oscP5 = new OscP5(this, 12000);

  dumb = new DumbSender();


  font = loadFont("53Seed-8.vlw");
  font2 = loadFont("AllerDisplay-92.vlw");

  textFont(font, 8);
  //textMode(SCREEN);




  minim = new Minim(this);

  //  jingle = minim.loadFile("siteUnseen.mp3", 2048);
  //vals = new float[1025];
  //jingle.play();

  in = minim.getLineIn(Minim.STEREO, 512);
  in.mute();


  vals = new ArrayList[(int)in.sampleRate()];
  for (int i = 0 ;i < vals.length;i++)
    vals[i] = new ArrayList();


  vls = new float[nn][in.bufferSize()];


  fft = new FFT(in.bufferSize(), in.sampleRate());

  maxW = fft.specSize()*3;

  W = 0 ;
  H = 0 ;

  for (int y = crop ; y < in.bufferSize(); y += detail) {
    H++;
    W = 0;
    for (int x = 0 ; x < maxW; x += detail) {
      W++;
    }
  }

  println("creating image buffer object, dimmnesions: "+W+"x"+H);

  img = createGraphics(W, H, P2D);

  change();
  noCursor();


  background(0);
  back();
  //pruhy();




  //////////////////////
  zeroSetup();

  /////////////////////
}

////////////////////////////////////////////////////////


void draw() {

  //mode = (int)(ctl[0]/(127.0 / 6.0 ));
  //println(step);
  rot();

  switch(mode) {
  case 0:
    zero();
    break;
  case 1:
    one();
    break;
  case 2:
    oneB();
    break;
  case 3:
    two();
    break;
  case 4:
    three();
    break;
    case 5:
    four();
    break;
  
  }

  if (ctl[25]>5)
    fastblur(g, (int)(ctl[25]/3.0));
}

////////////////////////////////////////////////////////

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.checkTypetag("if")) {
    oscInput = theOscMessage.get(0).intValue();
    valInput = theOscMessage.get(1).floatValue();
    fades[oscInput-1] = constrain(valInput*255.0+100,0,255);

    
    //println(oscInput +" "+valInput);
    hasSignal = true;
  }
}


////////////////////////////////////////////////////////

void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();

  super.stop();
}

void rot() {

  sx += (ctl[29]/20.4-sx)/map(ctl[27],0,127,2.0,400.0);
  sy += (ctl[30]/20.4-sy)/map(ctl[27],0,127,2.0,400.0);
  sz += (ctl[31]/20.4-sz)/map(ctl[27],0,127,2.0,400.0);
  zoom += (map(ctl[28], 0, 127, 1200, 200)-zoom)/map(ctl[27],0,127,2.0,400.0);
  // println(zoom);

  cam.setRotations(sx, sy, sz);
  //cam.rotateX(sx);

  float [] pos = cam.getLookAt();
  cam.lookAt(pos[0], pos[1], pos[2], (double)zoom, 0);
  //cam.rotateX(ctl[29]/(ctl[28]*10.0+1.0)); 
  //cam.rotateY(ctl[30]/(ctl[28]*10.0+1.0));
  //cam.rotateZ(ctl[31]/(ctl[28]*10.0+1.0));
}

void tras(float _ctl) {
  float tras = _ctl;

  translate((noise(frameCount/2.0, 0, 0)-0.5)*tras, 
  (noise(0, frameCount/2.0, 0)-0.5)*tras, 
  (noise(0, 0, frameCount/2.0)-0.5)*tras);
}



////////////////////////////////////////////////////////

void keyPressed(){
  
  if(key=='0'){
   mode = 0; 
  }
  
  if(key=='1'){
   mode = 1; 
  }
  
  if(key=='2'){
   mode = 2; 
  }
  
  if(key=='3'){
   mode = 3; 
  }
  
  if(key=='3'){
   mode = 3; 
  }
  
  if(key=='4'){
   mode = 4; 
  }
  
  if(key=='5'){
   mode = 5; 
  }
  
  if(key=='6'){
   mode = 6; 
  }
  
  if(key=='7'){
   mode = 7; 
  }
  
  if(key=='8'){
   mode = 8; 
  }
  
  
}

