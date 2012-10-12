import processing.opengl.*;

import javax.media.opengl.GL;
/**
 * This sketch demonstrates how to use the averaging abilities of the FFT. <br />
 * Logarithmically spaced averages (i.e. averages that are grouped by octave) are requested 
 * by specifying the band width of the smallest octave and how many bands to split each 
 * octave into. The result is averages that more closely map to how humans perceive sound.
 */

import ddf.minim.analysis.*;
import ddf.minim.*;


PGraphicsOpenGL pgl; //need to use this to stop screen tearing
GL gl;

float am = 5.0;
Minim minim;

float r = 300.0;

FFT fft;
AudioInput in;

void setup()
{
  size(800, 600, OPENGL);

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 2048);
  // loop the file
  //jingle.loop();
  // create an FFT object that has a time-domain buffer the same size as jingle's sample buffer
  // note that this needs to be a power of two 
  // and that it means the size of the spectrum will be 1024. 
  // see the online tutorial for more info.
  fft = new FFT(in.bufferSize(), in.sampleRate());
  // calculate averages based on a miminum octave width of 22 Hz
  // split each octave into three bands
  fft.logAverages(22, 3);
  rectMode(CORNERS);
  
  pgl = (PGraphicsOpenGL) g; //processing graphics object
  gl = pgl.beginGL(); //begin opengl
  gl.setSwapInterval(1); //set vertical sync on
  pgl.endGL(); //end opengl
}

float tras = 3.0;
boolean invert = false;

void draw()
{
  if(frameCount%7==0)
  invert = !invert;
  
  r = sin(frameCount/30.0)*600.0;

  background(invert?0:255);


  translate((noise(frameCount/3.0, 0)-0.5)*tras, (noise(0, frameCount/3.0)-0.5)*tras );

  // perform a forward FFT on the samples in jingle's mix buffer
  // note that if jingle were a MONO file, this would be the same as using jingle.left or jingle.right
  fft.forward(in.mix);
  // avgWidth() returns the number of frequency bands each average represents
  // we'll use it as the width of our rectangles

  noStroke();


  int w = int(width/fft.avgSize());
  for (int i = 0; i < fft.avgSize(); i+=2)
  {

    fill(invert?255:0, noise(i+frameCount/33.0)*125.0);

    pushMatrix();
    translate(random(-fft.getAvg(i)*am, fft.getAvg(i)*am), random(-fft.getAvg(i)*am, fft.getAvg(i)*am));
    ellipse(width/2, height/2, r, r);
    popMatrix();
  }
}

void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();

  super.stop();
}

