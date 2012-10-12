import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*; // for BandPass

////////////////////////////////////
String notesLow[], notesHigh[], notesMid[];

int pitchLow = 1;
int pitchMid = 3;
int pitchHigh = 6;

float[][] vals;
int nn = 10;

String notes[]= {
  "A", "C", "E", "G"
};

int period = 200;
////////////////////////////////////

boolean neg = false;

float amp = 0.2;
int num = 1;
float dur = 10;

Minim minim;
AudioOutput out;
Waveform disWave;

int cnt = 0;
int melody = 0;


////////////////////////////////////



void setup()
{
  size( 600, 320, P2D );

  textFont(loadFont("53Maya-8.vlw"));
  textMode(SCREEN);


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
    disWave = Waves.TRIANGLE;
  }

  notesLow = new String[notes.length];
  notesMid = new String[notes.length];

  notesHigh = new String[notes.length];

  for (int i = 0 ; i < notes.length;i++) {
    notesLow[i] = notes[i]+""+pitchLow;
    notesMid[i] = notes[i]+""+pitchMid;

    notesHigh[i] = notes[i]+""+pitchHigh;
  }
}

////////////////////////////////////


void draw() {
  noStroke();
  fill(noise(frameCount)*30+40, 25, neg?250:25, random(90, 120));
  rect(0, 0, width, height);


  if (frameCount%period==0) {
    addNotesNow();
  }

  pushMatrix();

  translate(width/2, height/2);
  rotate(frameCount/3.0);


  ////////////////////////////////////


  // draw the waveforms
  for ( int i = 0; i < out.bufferSize() - 1; i++ )
  {
    // find the x position of each buffer value
    float x1  =  map( i, 0, out.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
    // draw a line from one buffer position to the next for both channels


    int cnt = 0;

    for (int j = 2 ; j < nn;j++) {

      if (j==2) {
        resetMatrix();

        translate(map(i, 0, out.bufferSize(), 0, width), height/2);
        //rotate(radians(frameCount*8.0));
      }


      for (int z = 200 ; z < 10000;z+=2000) {

        vals[j][i] += ((out.left.get(i)*noise((i+j+frameCount)/30.0)*z)-vals[j][i])/(float)(j+800.1+2.0);

        translate(j/30.0, vals[j][i]);
        rotate(i/(out.bufferSize()+0.0));


        stroke(noise(0, (frameCount+i+j+z)/200.0)*255, 35, neg?24:250, 15);
        //  stroke( 255, 15);

        point(0, 0);
      }
    }
  }

  popMatrix();

  ////////////////////////////////////


  pushStyle();
  resetMatrix();
  strokeWeight(10);
  stroke(0);
  noFill();
  rect(0, 0, width, height);
  popStyle();


  fill(neg?0:255, 50);
  textAlign(RIGHT);
  text("Random Generative Composition by Kof "+nf(month(), 2)+"/"+nf(day(), 2)+"/"+year(), width-10, height-8);
}


void addNotesNow() {

  pitchLow = (int)random(1, 3);
  pitchMid = (int)random(3, 6);

  pitchHigh = (int)random(6, 8);

  makeScale();

  for (int i = 0 ; i < num ; i++ ) {
    out.playNote( i*(dur/(num+0.0))+random(-1.0, 1.0), (dur/(num+0.0)+random(0.0, 1.0)), new ToneInstrument( notesLow[(int)random(notesLow.length)]+" ", amp, disWave, out ) );
    out.playNote( i*(dur/(num+0.0))+random(-1.0, 1.0), (dur/(num+0.0)+random(0.0, 1.0)), new ToneInstrument( notesMid[(int)random(notesHigh.length)]+" ", amp, disWave, out ) );
    out.playNote( i*(dur/(num+0.0))+random(-1.0, 1.0), (dur/(num+0.0)+random(0.0, 1.0)), new ToneInstrument( notesHigh[(int)random(notesHigh.length)]+" ", amp, disWave, out ) );


    // out.playNote( (dur/(num+0.0))*2, 0.5, new ChikInstrument( out ) );
  }

  out.playNote( 0, 0.5, new ChikInstrument( out ) );

  cnt++;
  
  neg=!neg;
  
  rectMode(CENTER);
  noStroke();
  fill(neg?0:255);
  pushMatrix();
  translate(random(width),random(height));
  
  rotate(random(-PI,PI));
 // rect(0,0,80,80);
  popMatrix();
rectMode(CORNER);

  if (cnt%2==0)
    melody++;

  switch(melody%4) {
  case 0:

    out.playNote( 1.f, 4.4f, new WaveShaperInstrument( Frequency.ofPitch("C1").asHz(), 0.1, out ) );
    out.playNote( 1.2f, 1.2f, new WaveShaperInstrument( Frequency.ofPitch("C6").asHz(), 0.1, out ) );
    break;

  case 1:

    out.playNote( 1.f, 4.4f, new WaveShaperInstrument( Frequency.ofPitch("E1").asHz(), 0.1, out ) );
    out.playNote( 1.2f, 1.2f, new WaveShaperInstrument( Frequency.ofPitch("E7").asHz(), 0.1, out ) );
    break;

  case 2:

    out.playNote( 1.f, 4.4f, new WaveShaperInstrument( Frequency.ofPitch("A2").asHz(), 0.1, out ) );
    out.playNote( 1.2f, 1.2f, new WaveShaperInstrument( Frequency.ofPitch("A5").asHz(), 0.1, out ) );
    break;

  case 3:

    out.playNote( 1.f, 4.4f, new WaveShaperInstrument( Frequency.ofPitch("G1").asHz(), 0.1, out ) );
    out.playNote( 1.2f, 1.2f, new WaveShaperInstrument( Frequency.ofPitch("G3").asHz(), 0.1, out ) );
    break;
  }
  //out.playNote( 5.f, 1.0f, new WaveShaperInstrument( Frequency.ofPitch(notesHigh[(int)random(notesLow.length)]).asHz(), 0.2, out ) );
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

