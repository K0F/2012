///////////////////////////////////////////////
//  Geometry variations, Studie #2 Kof 2012  //
///////////////////////////////////////////////


PFont nadpis,popiska;

void setup() {
  size(720, 576);
  noCursor();
  smooth();
  frameRate(25);
  rectMode(CENTER);
  
  nadpis = createFont("Teuton Weiss",36,false);
  popiska = createFont("Teuton Weiss",16,false);
  textAlign(CENTER);
 // textMode(SCREEN);
}


void draw() {
  background(0);

  noStroke();

  hint(DISABLE_DEPTH_TEST);

  int cnt = 0;
  for (int x = 0 ; x <= width;x+=120) {
    for (int i = 0 ; i < height;i+=15) {

      if (cnt%2==0)
        fill(255);
      else
        fill(0);

      cnt += 1;

      pushMatrix();

      translate(x, i);


      rotate(sin(frameCount/30.0+i/160.0+x/((sin(frameCount/300.0)+3.0)*10.0))*2.1);

      rect(
      0, 0, 
      120, 120
        );
      popMatrix();
    }
  }

  if (frameCount<255*2) {
    fill(0, 255*2-frameCount);
    rect(width/2, height/2, width, height);
  }


  if (frameCount>15000-255*2) {
    fill(0, map(frameCount, 15000-255*2, 15000, 0, 255));

    rect(width/2, height/2, width, height);
  }
  
  
  if(frameCount<255){
   fill(255,255-frameCount);
   textFont(nadpis);
   text("study 2",width/2,height/2-10);
  
   textFont(popiska);
    text("10 minute loop\n Geometry series, Kryštof Pešek 2012",width/2,height/2+20); 
  }
  
  
  
  saveFrame("/home/kof/render/GVUN/Studie2/fr#####");
  
  if(frameCount>=15000)
  exit();
}

