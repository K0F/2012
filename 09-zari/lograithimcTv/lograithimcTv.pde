/**
 watch
 __/\\\\\\\\\\\\\\\__/\\\________/\\\_
 _\///////\\\/////__\/\\\_______\/\\\_
 _______\/\\\_______\//\\\______/\\\__
 _______\/\\\________\//\\\____/\\\___
 _______\/\\\_________\//\\\__/\\\____
 _______\/\\\__________\//\\\/\\\_____
 _______\/\\\___________\//\\\\\______
 _______\/\\\____________\//\\\_______
 _______\///______________\///________
 
 modded by kof
 */



/////////////////////// RESOLUTION 

float res = 1;
HashMap pnts;

/////////////////////// BASIC VARS

float X, Y, pX, pY;

float tras = 10.0;

import codeanticode.gsvideo.*;
GSPipeline pipeline;


void setup() {
  pipeline = new GSPipeline(this, "mmssrc location=mms://82.137.248.17/srtv/tv/English/NEWS/EN/31072012.asf ! decodebin ! ffmpegcolorspace");
  pipeline.play();

  size(320*2, 200*2, P2D);





  colorMode(HSB);

  pnts = new HashMap();

  int cnt = 0;

  for (float y = 0;y<height/2;y+=res)
    for (float x = 0;x<width/2;x+=res) {
      pnts.put(cnt, new Pnt(new PVector(x*2, y*2)));
      cnt++;
    }

  background(0);
}

int dir = 1;
int pos = 1;

void draw() {

  pipeline.read();
  pipeline.loadPixels();

  /////////////////////// SLOW FADE
  fill(0, 150);
  noStroke();
  rect(0, 0, width, height);



  /////////////////////// CAMERA SHAKE
  translate((noise(frameCount/2.0, 0)-0.5)*tras, (noise(0, frameCount/2.0)-0.5)*tras);

  pX = X;
  pY = Y;

  X = mouseX;//noise(frameCount/30.0,0)*width;
  Y = mouseY;//noise(0,frameCount/30.0)*height;


  int pos = frameCount%height;

  loadPixels();

  int idx= 0;


  if (pipeline.pixels.length>0) {

    int cnt = 0;
    for (int y = 0 ; y < pipeline.height;y+=res) {
      for (int x = 0 ; x < pipeline.width;x+=res) {
        idx = y*pipeline.width+x;
        Pnt tmp = (Pnt)pnts.get(cnt);
        tmp.c = lerpColor(color(pipeline.pixels[idx]),tmp.c,0.75);



        cnt++;
        //mem[pos][x][y] = pipeline.pixels[idx];
      }
    }
  }


  int cnt = 0;
  for (int y = 0 ; y < pipeline.height;y+=res) {
    for (int x = 0 ; x < pipeline.width;x+=res) {
      Pnt tmp = (Pnt)pnts.get(cnt);
      tmp.update();
      tmp.draw();
      cnt++;
    }
  }

  /////////////////////// PIX EFFECTS
  fastblur(g, 2); 
  blend(g, 0, 0, width, height, 0, 0, width, height, ADD);
}


void captureEvent(GSPipeline c) {
  c.read();
  c.loadPixels();
}

