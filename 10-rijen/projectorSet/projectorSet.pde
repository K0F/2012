void setup(){

  size(800,600,P2D);
  frame.setLocation(0,0);

}


void init(){

  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();
  super.init();

}

float y = 0;
float x = 0;
boolean inverse;

void draw(){
  background(inverse?0:255);

  stroke(inverse?255:0);
  line(0,y,width,y);
  line(x,0,x,height);


  if(x==width-1||y==height-1)
    inverse = !inverse;

  y = frameCount%height;
  x = frameCount%width;
}
