
float x1, y1, x2, y2; 
float speed = 600.0;
float t = 0;
int num = 400;

void setup() {
  size(1280, 720,P2D);
  smooth();
  background(255);
}

void draw() {
   background(255);
  
  for(int z = 0;z<num;z++){
  x1 = noise(frameCount/(speed+z),0)*(width/2);
  y1 = noise(0,frameCount/(speed+z))*(height);

  x2 = noise(frameCount/(speed+z)+30000.0,0)*(width/2)+width/2;
  y2 = noise(0,frameCount/(speed+z)+30000.0)*(height);
  t = 0.0;



  beginShape();
 // vertex(x1,y1);
  for (float t = 0 ; t < 1.0 ; t+=0.1) { 

    float X = curvePoint(0, x1, x2, width, t);
    float Y = curvePoint(0, y1, y2, height, t);

    curveVertex(X, Y);

    noFill();
    stroke(0, 15);
  }
 // vertex(x2,y2);
  endShape();
  }
  //curvePoint();
}
//curvePoint();

