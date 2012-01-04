Parser parser;

void setup(){
  size(512,512,P3D);
  parser = new Parser("skeleton.bvh");
  
  noSmooth();
  
}

void draw(){
 background(255);
 fill(255,128,0);
 strokeWeight(10);
 lights();
 stroke(0,35);
 parser.draw(); 
 
 noStroke();
 parser.drawHieratical(); 
 }
