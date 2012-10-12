void setup() {

  size(400, 400, P2D);
}


void draw() {
  background(0);
  
  stroke(255,12);


  pushMatrix();
  translate(width/2, height/2);
  rotate(frameCount/200.0);
  for (int i  =0 ; i < 40000;i++){
    rotate(degrees(i));
    float x = sin(frameCount/(.001+i))*200.0;
    stroke(255,map(x,0,200,10,20));
    line(-10,x,10,x);
  }

  popMatrix();
}

