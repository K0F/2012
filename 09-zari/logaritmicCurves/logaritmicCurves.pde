void setup(){
  size(320,240,P2D);
}
int x = 1;
int y = 1;
void draw(){
  background(0);
  stroke(255,45);
  for(int z = frameCount ; z < 400+frameCount; z+=1){
    for(int i = 0 ; i < width; i++){
      x ^= z;
      y ^= x;
      x = x % width;
      y = y % height;

      point(x,y);
    }
  }

  blend(g,0,0,width,height,0,0,width,height,SUBTRACT);
  //filter(BLUR,2);

}

