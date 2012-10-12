//////////////////////////////////////////////
//  Geometry variations, Studie #1 Kof 2012 //
//////////////////////////////////////////////
 
float r1, r2;
 
boolean inverse = true;
boolean flicker = false;
boolean interactive = false;


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
}


void draw(){
  
 
 
  background(inverse?0:255);
  noStroke();
 
 
  // flicker on / off
  if (flicker) {
    if (frameCount%10==0)
      inverse = !inverse;
  }
 
  for (int i = 1 ; i < 131; i+=1) {
 
    // all the magic happens here
    r1 = sin(frameCount/(30.+i/30.3333))*height/2;
    r2 = sin(frameCount/(60.+i/30.0))*height/2;
 
    fill(inverse?255:0);
 
    if (i%2==0)
      fill(inverse?0:255);
 
    ellipse(r2+width/2, height/2., r1, r1);
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
   text("study 1",width/2,height/2-10);
  
   textFont(popiska);
   text("10 minute loop\n Geometry series, Kryštof Pešek 2012",width/2,height/2+20); 
  }
  
  
  
  //saveFrame("/home/kof/render/GVUN/Studie1/fr#####");
  
  if(frameCount>=15000)
  exit();
  
}
