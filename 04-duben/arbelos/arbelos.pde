void setup(){
  size(400,400,P2D);
}


void draw(){


  background(0);
  noFill();
  stroke(255,10);

  ellipse(width/2,height/2,width,height);

  for(int i= 0;i<300;i++){

    arbelos(i*10.0);
  }
 //float c4 = cos(frameCount/30.0)*width/PI+width/2; 
 //float r1 = dist(c1,c4,c2,height/2.0)/2.0;
 //ellipse(c1,c4,r1,r1);
}

void arbelos(float R){

  float c1 = sin(frameCount/30.0)*R/2.0+R/2.0;
  float c2 = c1/2.0;
  float c3 = R-c2;

//  line(c1,0,c1,height);

  ellipse(c2,height/2.0,c1,c1);
  ellipse(R-c3+R/2.0,height/2.0,R-c1,R-c1);
  


}
