Shape shape;

///////////////////
boolean render = false;

boolean inv = false;
boolean reversal =  false;
int z,zz;


void setup(){

  size(640,480,P2D);
  frameRate(100);

  shape = new Shape(width/2,height/2,1);
  smooth();

z = (int)random(1,100);
zz = (int)random(1,100);

}


void draw(){

  background(inv?0:255);

if(frameCount%50==0){
z = (int)random(2,3);
zz = (int)random(2,6);
}


  if(reversal){
  if(frameCount%z==0){
  fill(inv?#EEEDE6:0);
    shape.draw();

  }

  if(frameCount%zz==0)
    inv=!inv;

  }else{
 if(frameCount%zz==0){
  fill(inv?#EEEDE6:0);
    shape.draw();

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
    rotate(frameCount/30.0);
    PVector one = new PVector(cos(0)*s,sin(0)*s);
    PVector two = new PVector(cos(radians(120))*s,sin(radians(120))*s);
    PVector three = new PVector(cos(radians(240))*s,sin(radians(240))*s);
    triangle(one.x,one.y,two.x,two.y,three.x,three.y);
    popMatrix();

  }


}
