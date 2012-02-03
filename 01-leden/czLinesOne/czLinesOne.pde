import processing.pdf.*;
PImage map;
ArrayList positions;

void setup(){
 map = loadImage("mapaMask.png");

 size(map.width,map.height);
  
  
  positions = new ArrayList();
  
  map.loadPixels();
  
  for(int y = 0 ; y<height;y++){
    
  for(int x = 0 ; x<width;x++){
      if(brightness(map.pixels[y*width+x])>128){
        
        
        positions.add(new PVector(x,y,0));
      }
    }  
  }
  rectMode(CENTER);

  noFill();
  stroke(0,15);
  background(0);
}


void draw(){
  
  beginRecord(PDF, "Lines5.pdf"); 
  
  for(int i = 0;i<positions.size();i+=(int)random(4080)){
   
    PVector one = (PVector)positions.get((int)random(positions.size()));
   PVector two = new PVector(width/2,height/2,0);
   
   float d = 10000;
   while(d>150){
     two = (PVector)positions.get((int)random(positions.size()));
     d = dist(one.x,one.y,two.x,two.y);
   }
   
   
   
   boolean valid = true;;
   for(float f =0 ;f<1.0;f+=0.01){
     int xx = (int)lerp(one.x,two.x,f);
     int yy = (int)lerp(one.y,two.y,f);
     if(brightness(map.pixels[yy*width+xx])<128)
     valid=false;
   }
   
   
   if(valid){
   
     float f = dist(one.x,one.y,two.x,two.y);
     strokeWeight(1);
   stroke(255,20);
   
   line(one.x,one.y,two.x,two.y);
   }
   
   
    
  }
  
  
  
  endRecord();
  noLoop();
}



void mousePressed() {
  beginRecord(PDF, "Lines2.pdf"); 
  background(255);
}

void mouseReleased() {
  endRecord();
  background(255);
}

