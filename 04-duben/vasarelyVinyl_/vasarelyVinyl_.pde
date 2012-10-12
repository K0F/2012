color c1 = color(255,0,0);
color c2 = color(0,255,0);
color c3 = color(0,0,255);

float s = 40;
float shift = 2*s+sin(radians(60))*s; 


int numX = 20;
int numY = 20;

float cnt;

void setup(){
  size(700,700,P2D);

  colorMode(HSB);
}


void draw(){
background(255);
  
  cnt = 0;

  s = noise(frameCount/300.0)*50.0;
  shift = 2*s+sin(radians(120))*s; 
  
  for(int i = 0 ; i < numX;i++){
    stripHex(0+i*shift,0,s,numY,c1,c2,c3);
  }

}

void stripHex(float _x,float _y,float s,int num,color c1,color c2,color c3){
  float Y = 3.*sin(radians(60))*s;
  float X = 3.*cos(radians(60))*s;
  
  for(int i = 0;i<num;i++){
    triHex(_x-(i%2)*X,_y+Y*i,s,c1,c2,c3);
  }
}

void triHex(float _x,float _y,float s,color c1,color c2,color c3){
  hexagon(_x,_y,s,c1,c2,c3);
  hexagon(_x+s+cos(radians(300))*s,_y+sin(radians(300))*s,s,c1,c2,c3);
  hexagon(_x+s+cos(radians(60))*s,_y+sin(radians(60))*s,s,c1,c2,c3);
}

void hexagon(float x,float y,float s,color jedna,color dva,color tri){
  
  cnt+=1.0;

  float cx = noise(0,frameCount/60.0)*width;
  float cy = noise(frameCount/60.0,0)*height;



  float cx2 = noise(0,frameCount/60.0-3)*width;
  float cy2 = noise(frameCount/60.0-3,0)*height;



  jedna = lerpColor( #000000,#ecf3c0,map(dist(cx,cy,x,y),0,width*1.5,0,1 ));
  dva = lerpColor( #8C814C,#c0cef3,map(dist(cx,cy,x,y),0,width*1.5,0,1 ));
  tri = lerpColor( #2178D7,#F3C2C0,map(dist(cx,cy,x,y),0,width*1.5,0,1 ));

  pushMatrix();
  translate(x-cx2/4., y-cy2/4.);
  noStroke();
  fill(jedna);

  quad(
      0,0,
      cos(radians(0))*s,sin(radians(0))*s,
      cos(radians(60))*s,sin(radians(60))*s,
      cos(radians(120))*s,sin(radians(120))*s
      );

  fill(dva);

  quad(
      0,0,
      cos(radians(120))*s,sin(radians(120))*s,
      cos(radians(180))*s,sin(radians(180))*s,
      cos(radians(240))*s,sin(radians(240))*s
      );
  fill(tri);
  quad(
      0,0,
      cos(radians(240))*s,sin(radians(240))*s,
      cos(radians(300))*s,sin(radians(300))*s,
      cos(radians(0))*s,sin(radians(0))*s
      );
  popMatrix();
}
