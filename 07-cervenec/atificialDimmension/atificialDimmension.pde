

float speed = 30.0;
float spread = 30.0;
int num = 5000;

float x[],y[];

void setup(){
  size(640,640,P3D);


  x= new float[num];
  y= new float[num];


  noiseSeed(7);


  rectMode(CENTER);
  ellipseMode(CENTER);
  background(0);
}



void draw(){


  fill(0,15);
  rect(width/2,height/2,width,height);
  //background(0);
  //stroke(255,30);

  //scale(0.15);


  pushMatrix();
  translate(width/2,height/2);

  for(int i = 0 ; i < num;i++){
    float X = (noise(frameCount/speed+i/spread,0,0)-0.5)*width/2;
    float Y = (noise(0,frameCount/speed+i/spread,0)-0.5)*width/2; 
    float Z = (noise(0,0,frameCount/speed+i/spread)-0.5)*width/2; 


    translate(X,Y,Z);
    x[i] = screenX(0,0,0)/30.0+(-0.5+noise(i/300.0))*500.0;
    y[i] = screenY(0,0,0)/30.0+(-0.5+noise(i/200.0))*503.0;

  }


  popMatrix();


  pushMatrix();
  translate(width/2,height/2);

  //translate(0,0,-8000);
  for(int i = 1 ; i < num ; i ++){
    noStroke();
    fill(255,127,0,5);
    rect(x[i],y[i],5,5);
  }
  popMatrix();

  fill(0);
  ellipse(width/2,height/2,180,180);
}
