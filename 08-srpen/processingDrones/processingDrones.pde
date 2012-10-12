/*
 * SynthCreate: Create a synth, map frequency to mouse position. 
 * Before using, start SC server and load the included SynthDefs
 * (see the "SynthDef" tab above) 
 *
 * The "Hello World" of SuperCollider for Processing.
 *
 * Note the "stop" method, called when ESC is pressed, which
 * frees the synth on the server-side.
 *
 * Part of the SuperCollider for Processing distribution.
 *   <http://www.erase.net/projects/processing-sc/>
 *
 * This program can be freely distributed and modified under the
 * terms of the GNU General Public License version 2.
 *   <http://www.gnu.org/copyleft/gpl.html> 
 *
 *-------------------------------------------------------------------*/

import supercollider.*;
import oscP5.*;

int num = 330;
ArrayList synth;

void setup ()
{
  size(800, 200, P2D);

  noiseSeed(19);

  frameRate(30);
  // uses default sc server at 127.0.0.1:57110    
  // does NOT create synth!

  synth = new ArrayList();

  for (int i = 0;i<num;i++) {

    Synth tmp = new Synth("sine_double");

    synth.add(tmp);
    tmp.create();
  }

  // set initial arguments
  // synth.set("amp", 0.5);
  // synth.set("freqx", 80);

  // create synth
}


float X, Y;

void draw ()
{
  background(0);
  for (int i = 0;i<num;i++) {
    Synth tmp = (Synth)synth.get(i);

    float X = 40 + ( noise((frameCount+i)/300.0, 0)*width  );
    float Y = 40 + ( noise(0, (frameCount+i)/300.0)*height );
    tmp.set("freqx", X+i*0.01);
    tmp.set("freqy", Y+i*0.4);

    tmp.set("amp", noise((frameCount+i*200.0)/30000.0 )*0.05);
    stroke(255, noise((frameCount+i*200.0)/30000.0 )*90);
    line(X+7, Y, X-7, Y);
    line(X, Y+7, X, Y-7);
  }
}


void exit()
{
  for (int i = 0;i<num;i++) {
    Synth tmp = (Synth)synth.get(i);
    tmp.free();
  }
  super.exit();
}

