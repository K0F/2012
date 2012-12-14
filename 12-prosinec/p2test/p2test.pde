
void setup(){
  size(1024,768,P2D);

}


void draw(){
  background(0);
  stroke(255);

  int x = frameCount%width;
  line(x,0,x,height);

}
