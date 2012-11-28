/**
Coded by Kof @ 
Fri Nov  9 03:45:50 CET 2012



   ,dPYb,                  ,dPYb,
   IP'`Yb                  IP'`Yb
   I8  8I                  I8  8I
   I8  8bgg,               I8  8'
   I8 dP" "8    ,ggggg,    I8 dP
   I8d8bggP"   dP"  "Y8ggg I8dP
   I8P' "Yb,  i8'    ,8I   I8P
  ,d8    `Yb,,d8,   ,d8'  ,d8b,_
  88P      Y8P"Y8888P"    PI8"8888
                           I8 `8,
                           I8  `8,
                           I8   8I
                           I8   8I
                           I8, ,8'
                            "Y8P'
                            
*/

float box_size = 20;

float sp1 = 100.0;
float sp2 = 300.0;
float sp3 = 200.0;
float ammount = 5.0;

float rozestup = 1.2;


void setup(){
  size(1280,720,P3D);
  ortho(-width/2,width/2,-height/2,height/2,-100,100);
  rectMode(CENTER);

  colorMode(HSB);
}


void draw(){
  background(0);
  noStroke();

  ammount = noise(millis()/1000.0)*3.0;


  for(float y = 0 ; y < height ; y +=box_size*rozestup){
    for(float x = 0 ; x < width ; x +=box_size*rozestup){
      pushMatrix();
      float d = dist(x,y,mouseX,mouseY)/100.0+1.0;
      translate((x-mouseX)/d+x,(y-mouseY)/d+y);
      rotateX(noise(((frameCount+x)/sp1),(frameCount+d)/sp1)*ammount);
      rotateY(noise(((frameCount+x)/sp2),(frameCount+d)/sp2)*ammount);
      rotateZ(noise(((frameCount+x)/sp3),(frameCount+d)/sp3)*ammount);
      //box(box_size);
      
      rect(0,0,box_size+d*3,box_size+d*3);
      popMatrix();
    }
  }
}
