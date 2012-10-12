float r;
ArrayList print;
int len = 1000;

void setup(){

  size(400,400,P2D);

  r = 400;

  print = new ArrayList();
  rectMode(CENTER);
}



void draw(){

  background(255);


for(float z=  1 ; z < 20;z+=4){

  float X = noise(frameCount/(3000.0/(float)z),0)*width;
  float Y = noise(0,frameCount/(3000.0/(float)z))*height;


  print.add(new PVector(X,Y));

  stroke(0,5);
  fill(255,10);

  for(int i = 0 ;i < print.size();i++){
    PVector tmp = (PVector)print.get(i);
    pushMatrix();
    translate(width/2,height/2);
    rotate(map(tmp.x,0,width,0,TWO_PI));
    float d = map(tmp.y,0,height,0,r);
    line(0,0,0,d/z);
    rect(0,d/z,5,5);
    popMatrix();
  }
}

  if(print.size()>len)
    print.remove(0);


}
