import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*; // for BandPass


Grid g;

Minim minim;
AudioOutput out;
Waveform disWave;


void setup() {
  size(340, 380, P2D);
  g = new Grid(40);

  minim = new Minim( this );
  out = minim.getLineOut( Minim.STEREO, 1024 );
  disWave = Waves.SINE;
  
  textFont(loadFont("65Amagasaki-8.vlw"));
  textMode(SCREEN);
  
  

  background(0);
}


void draw() {

  background(0); 

  g.draw();
  
  buttons();
}




// stop is run when the user presses stop
void stop()
{
  // close the AudioOutput
  out.close();
  // stop the minim object
  minim.stop();
  // stop the processing object
  super.stop();
}

