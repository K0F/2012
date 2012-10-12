/*
*  Interferences by kof, 2012
*/

import krister.Ess.*;

float mova = 18.0;

int harms = 5;
AudioStream myStream[];
float[] streamBuffer;

float osc1 = 13.0;
float osc2 = 49.3;

void setup() {
  size(320, 240, P2D); 
  colorMode(HSB);
  loadPixels();
  noiseSeed(19);


  Ess.start(this);

myStream = new AudioStream[harms];

for(int i  = 0 ; i < harms;i++){
  myStream[i]=new AudioStream();
  myStream[i].sampleRate(44100-(int)(i*1000.0)+i*333.3);
  myStream[i].bufferSize(width);
   myStream[i].start();
}
  
  
  streamBuffer=new float[myStream[0].size];
  
  
}


void draw() {


  int cnt =0 ;
  for (int i = 0 ; i < pixels.length;i+=1) {
    float d1 = norm(dist(noise(frameCount/mova, 0)*width, noise(0, frameCount/mova)*width, i%width, i/width), 360, 0);

    if (i / ( ((frameCount)%height+1) )==0) {
   
      streamBuffer[cnt] = map(brightness(pixels[i]), 0, 255, -0.97, 0.97);
     cnt++;
      }
      
      
    
     
   
   
    pixels[i] = lerpColor(color(
    (sin((frameCount/osc1*sin(frameCount/osc2)/d1))+1.0)*127
      ), pixels[i], d1);
  }

  updatePixels();
}

void audioStreamWrite(AudioStream theStream) {
  for(int i  = 0 ; i < harms;i++){
  System.arraycopy(streamBuffer, 0, myStream[i].buffer, 0, streamBuffer.length);
  }
}

public void stop() {
  Ess.stop();
  super.stop();
}

