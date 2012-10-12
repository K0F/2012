import processing.pdf.*;

///////////////////////////////////////
//  Geometry variations #1 Kof 2012  //
///////////////////////////////////////
 
float r1, r2;
 
boolean inverse = false;
boolean flicker = false;
boolean interactive = false;

boolean rec = false;
 
void setup() {
  size(600, 300, P2D);
 
  // damn fast framerate
  frameRate(120);
  noStroke();
 
  ellipseMode(CENTER);
  rectMode(CENTER);
 
  smooth();
}
 
 
void draw() {
  
  if(rec)
   beginRecord(PDF, "filename.pdf"); 
 
  background(inverse?0:255);
 
 
  // flicker on / off
  if (flicker) {
    if (frameCount%10==0)
      inverse = !inverse;
  }
  
  noStroke();
 
  for (int i = 1 ; i < 131; i+=1) {
 
    // all the magic happens here
    r1 = sin(millis()/(300.+i))*height/2;
    r2 = sin(millis()/(600.+i))*height/2;
 
    fill(inverse?255:0);
 
    if (i%2==0)
      fill(inverse?0:255);
 
    ellipse(r2+width/2, height/2., r1, r1);
  }
  
  if(rec){
  endRecord();
  exit();
  }
}
void keyPressed(){
 rec = true; 
}
 
void mousePressed() {
  if(interactive)
  inverse = !inverse;
}

