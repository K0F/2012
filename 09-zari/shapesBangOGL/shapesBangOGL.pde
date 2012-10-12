import processing.opengl.*;

Shape left,right;

///////////////////
boolean render = false;

boolean inv = false;
boolean reversal =  false;
int z,zz;


void setup(){

  size(1280,720,OPENGL);
  frameRate(200);
  
  hint(ENABLE_OPENGL_4X_SMOOTH);

  left = new Shape(width/3,height/2,0);
  right = new Shape(width/3*2,height/2,1);
  smooth();

z = 2;//(int)random(1,100);
zz = 7;//(int)random(1,100);

}


void draw(){
  
  left.move(width/3+(noise(frameCount/3.0,0)-0.5)*4.0,height/2);
  right.move(width/3*2+(noise(0,frameCount/3.0)-0.5)*4.0,height/2);
  
  z = (int)(noise(frameCount/300.0,0)*4+2);
   zz = (int)(noise(0,frameCount/300.0)*4+2);

  background(inv?0:255);

/*
if(frameCount%50==0){
z = (int)random(2,20);
zz = (int)random(2,5);
}*/


  if(reversal){
  if(frameCount%z==0){
  fill(inv?#EEEDE6:0);
    left.draw();
right.draw();

  }

  if(frameCount%zz==0)
    inv=!inv;

  }else{
 if(frameCount%zz==0){
  fill(inv?#EEEDE6:0);
    left.draw();
right.draw();

  }

  if(frameCount%z==0)
    inv=!inv;



  }

  if(frameCount%99==0){
    reversal = !reversal;
  }


  if(render)
    saveFrame("render/fr#####.tga");

}

class Shape{

  PVector pos;
  int type;
  float s = 200;

  Shape(float x,float y,int _type){
    type = _type;
    pos = new PVector(x,y);

  }

  void draw(){

    noStroke();
    pushMatrix();
    translate(pos.x,pos.y);
    
    switch(type){
    case 0:
      rotate(millis()/(frameCount/10.0+1));
    break;
    case 1:
    rotate(-millis()/(frameCount/10.0+1));
    break;
    }
    PVector one = new PVector(cos(0)*s,sin(0)*s);
    PVector two = new PVector(cos(radians(120))*s,sin(radians(120))*s);
    PVector three = new PVector(cos(radians(240))*s,sin(radians(240))*s);
    triangle(one.x,one.y,two.x,two.y,three.x,three.y);
    popMatrix();

  }
  
  void move(float x,float y){
   pos = new PVector(x,y); 
  }


}
