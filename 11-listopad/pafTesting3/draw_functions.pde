
void plot() {

  int l = W;
  float ww = l / 7.0;

  img.beginDraw();
  img.imageMode(CORNER);
  img.background(0);
  img.noStroke();
  
  for (int i = 0 ; i < fades.length;i++) {
    img.fill(fades[i]);
    float X = map(i, 0, fades.length, 0, W-ww);
    img.rect(X, 0, ww, H);
    fades[i]-=40;
  }
  img.endDraw();
  
  //cam.beginHUD();
  //image(img,0,0);
  //cam.endHUD();
}

////////////////////////////////////////////////////////
void back() {
  img.beginDraw();
  img.background(255);
  img.endDraw();
}
////////////////////////////////////////////////////////
void change() {
  img.beginDraw();
  img.background(0);
  img.textFont(font2);
  img.textAlign(CENTER);
  //img.textMode(SCREEN);
  img.fill(255);

  //for(int i = 0 ; i < 4;i++)

  int pos = (int)random(txt.length());

  txt = txt.substring(0, pos)+(char)( ((txt.charAt(pos)+1)%(60)+60))+txt.substring(pos+1, txt.length());
  img.text(txt, 0, 0, 300, img.height);


  img.endDraw();
}
////////////////////////////////////////////////////////
void pruhy() {
  float shift = noise(frameCount/1200.0)*200;

  img.beginDraw();
  img.background(0);
  for (float i = -shift ; i <img.width;i+=15) {
    img.strokeWeight(5);
    img.stroke(255);
    img.line(i, 0, i+shift, img.height);
  }

  img.endDraw();
}

////////////////////////////////////////////////////////

void drawShape() {
  float m = map(valInput, 0, 1, 0, 200);
  int X = 0;

  switch(oscInput) {
  case 1:
    fill(255, m);
    X = 50;
    break;
  case 2:
    fill(255, 0, 0, m);
    X = 100;
    break;
  case 3:
    X = 150;
    fill(255, 255, 0, m);
    break;
  case 4:
    X = 200;
    fill(0, 0, 255, m);
    break;
  case 5:
    X = 250;
    fill(0, 255, 255, m);
    break;
  case 6:
    X = 300;
    fill(23, 23, 123, m);
    break;
  } 

  noStroke();
  pushStyle();
  rectMode(CENTER);
  rect(X, img.height/2, 50, height);
  popStyle();
}

////////////////////////////////////////////////////////

void oscPruhy() {
  float shift = noise(frameCount/1200.0)*200;

  float xmod = fft.specSize()*3/6.0;


  float m = map(valInput, 0, 1, 0, 255);
  float X = 0;


  img.beginDraw();
  //img.background(0);


  switch(oscInput) {
  case 1:
    //img.fill(255, m);
    X = xmod;
    break;
  case 2:
    //img.fill(255, 0, 0, m);
    X = xmod*2;
    break;
  case 3:
    X = xmod*3;
    //img.fill(255, 255, 0, m);
    break;
  case 4:
    X = xmod*4;
    //img.fill(0, 0, 255, m);
    break;
  case 5:
    X = xmod*5;
    //img.fill(0, 255, 255, m);
    break;
  case 6:
    X = xmod*6;
    //img.fill(23, 23, 123, m);
    break;
  }

  img.fill(255, m);

  img.rectMode(CENTER);
  img.rect(X, img.height/2, xmod, img.height);



  img.endDraw();
}
////////////////////////////////////////////////////////

