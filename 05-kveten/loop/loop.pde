
int num = 20000;

float blend = 0.5;

void setup(){
  size(300,300,P2D);
  noCursor();
  colorMode(HSB);
  background(0);
}

void draw(){
  noStroke();
  fill(255,50);
  loadPixels();
  for(int i = 0 ; i < num;i++){
    float x = sin(frameCount/(3.123212131*i))*(width/2.0-20.0)+width/2;
    float y =sin(frameCount*0.00001*i)*(height/2-20.0)+height/2; 
    pixels[(int)y*width+(int)x] = lerpColor(color(pixels[(int)y*width+(int)x]),color(map(sin(frameCount*13.0*i),-1,1,0,255),127,noise(i)*255),blend);
  }
}
