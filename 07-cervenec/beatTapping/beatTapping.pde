import processing.opengl.*;
import javax.media.opengl.GL;
import ddf.minim.*;
import promidi.*;

int ctl[] = new int[64];

Shaper shaper;

float al;
float avg = 0;

float tras = 20.0;


MidiIO midiIO;

Minim minim;
AudioInput in;

PGraphicsOpenGL pgl; //need to use this to stop screen tearing
GL gl;

int chill = 100;


float time1, time2;
float mezi = 250;

void setup() {

  size(1280, 720, OPENGL);

  pgl = (PGraphicsOpenGL) g; //processing graphics object
  gl = pgl.beginGL(); //begin opengl
  gl.setSwapInterval(1); //set vertical sync on
  pgl.endGL(); //end opengl

  frameRate(100);

  shaper = new Shaper(40);


  minim = new Minim(this);
  minim.debugOn();

  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, width);


  minim = new Minim(this);
  minim.debugOn();

  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, width);
  background(0);

  //get an instance of MidiIO
  midiIO = MidiIO.getInstance(this);
  println("printPorts of midiIO");

  //print a list of all available devices
  midiIO.printDevices();

  //open the first midi channel of the first device
  midiIO.openInput(0, 0);

  preset();
}


void draw() {
  background(0);

  //////////////////////////////////////////
  // REACTIVE //////////////////////////////
  ////////////////////////////////////////// VV

  


  for (int i = 0; i < in.bufferSize() - 1; i++)
  {

    stroke(((in.left.get(i)+in.right.get(i))*ctl[22]*4));
    line(i, 0, i, height);


    avg += ((in.left.get(i)+in.right.get(i))*2000.0-avg)/30000.0;
  }

  //////////////////////////////////////////


  translate((noise(frameCount, 0)-0.5)*tras, 
  (noise(0, frameCount)-0.5)*tras);

  chill --;


  if (millis()%(int)mezi<50 && chill<0) {

    fill(random(255), random(255), random(255), ctl[33]*2);
    stroke(255, ctl[34]*2);
    strokeWeight(ctl[35]);




    pushMatrix();
    translate(width/2, height/2);
    //ellipse(width/2,height/2,400,400);
    shaper.draw();

    shaper.gen();
    popMatrix();
  }
  else {
    shaper.gen();
  }
}

void keyPressed() {

  if (keyCode==ENTER) {
    time1 = time2;
    time2 = millis();

    mezi += ((time2-time1)-mezi)/1.2;

    chill = 50;
  }
}


void controllerIn(promidi.Controller controller, int device, int channel) {
  try {
    int num = controller.getNumber();
    int val = controller.getValue();

    ctl[num] = val;
    println(num);
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

