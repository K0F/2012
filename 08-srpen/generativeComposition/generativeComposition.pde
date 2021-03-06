import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.ugens.*;


////////////////////////////////////
String notesLow[], notesHigh[];

int pitchLow = 1;
int pitchHigh = 4;

float[][] vals;
int nn = 30;

String notes[]= {
  "A","F","E","D","C"
};

int period = 200;

////////////////////////////////////



float amp = 0.15;
int num = 1;
float dur = 10;

Minim minim;
AudioOutput out;
Waveform disWave;
BandPass bp;


////////////////////////////////////



void setup()
{
  size( 800,600, P2D );
  
  textFont(loadFont("53Maya-8.vlw"));
  textMode(SCREEN);
  
  frameRate(30);


  makeScale();

  // initialize the minim and out objects
  minim = new Minim( this );
  out = minim.getLineOut( Minim.STEREO, 1024 );

  vals = new float[nn][out.bufferSize()];

  colorMode(HSB);

  background(0);
    addNotesNow();

}

////////////////////////////////////


void makeScale() {

  if (random(50)<40) {
    disWave = Waves.SINE;
  }
  else {
    disWave = Waves.SINE;
  }

  notesLow = new String[notes.length];
  notesHigh = new String[notes.length];

  for (int i = 0 ; i < notes.length;i++) {
    notesLow[i] = notes[i]+""+pitchLow;
    notesHigh[i] = notes[i]+""+pitchHigh;
  }
}

////////////////////////////////////


void draw() {
  noStroke();
  fill(noise(frameCount)*40+20, 40, 25, random(35, 75));
  rect(0, 0, width, height);


  if (frameCount%period==0) {
    addNotesNow();
  }

////////////////////////////////////


  // draw the waveforms
  for ( int i = 0; i < out.bufferSize() - 1; i++ )
  {
    // find the x position of each buffer value
    float x1  =  map( i, 0, out.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
    // draw a line from one buffer position to the next for both channels


    int cnt = 0;

    for (int j = 2 ; j < nn;j+=5) {

      if (j==2) {
        resetMatrix();

        translate(map(i, 0, out.bufferSize(), 0, width), height/2);
        rotate(radians(frameCount/300.0*8.0));
      }


      for (int z = 200 ; z < 10000 ; z+=5000) {

        vals[j][i] += ((out.left.get(i)*noise((i+j+frameCount)/30.0)*z)-vals[j][i])/(float)(j+z/6.0+2.0);

        translate(0, vals[j][i]*2);
        rotate(i/(out.bufferSize()+0.0));


        stroke(noise(0, (frameCount+i+j+z)/200.0)*255, 35, 200, 50);
        //  stroke( 255, 15);

        point(0, 0);
      }
    }
  }

////////////////////////////////////

  
  pushStyle();
  resetMatrix();
  strokeWeight(10);
  stroke(0);
  noFill();
  rect(0,0,width,height);
  popStyle();
  
  fill(255,50);
  textAlign(RIGHT);
  text("Random Generative Composition by Kof "+
  nf(hour(),2)+":"+nf(minute(),2)+":"+nf(second(),2)+
  "  "+nf(day(),2)+"/"+nf(month(),2)+"/"+year(),
  width-10,height-8);
  
  
}

void keyPressed() {

  addNotesNow();
}

void addNotesNow() {
  
    pitchLow = (int)random(-3, 4);
    pitchHigh = (int)random(4, 7);

    makeScale();
  
  for (int i = 0 ; i < num ; i++ ) {
    out.playNote( i*(dur/(num+0.0)), (dur/(num+0.0)+random(0.0, 1.0)), new ToneInstrument( notesLow[(int)random(notesLow.length)]+" ", amp, disWave, out ) );
    out.playNote( i*(dur/(num+0.0)), (dur/(num+0.0)+random(0.0, 1.0)), new ToneInstrument( notesHigh[(int)random(notesHigh.length)]+" ", amp, disWave, out ) );
  }
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

