

float theta[];
PImage prazdny,plny;
int [] moznosti = {0,90,180,270};
float [] rot = {1,2,4};


void setup(){
  size(720,720,P2D);
  imageMode(CENTER);

  prazdny = loadImage("prazdny.png");
  plny = loadImage("plny.png");






  theta = new float[3000];
  for (int i = 0 ; i < theta.length ; i ++){
    theta[i] = moznosti[(int)random(4)];
  }

}

void draw(){

  background(0);





  float  r = plny.width;


    int idx = 0;
  for(int y = 0;y <= height/plny.height;y++){
    for(int x = 0;x <= width/plny.width;x++){

      pushMatrix();
        translate(x*r+plny.width/2,y*r+plny.height/2);
      rotate(radians(theta[idx]));
        theta[idx] += 0.4*degrees(frameCount/20.0*atan2(mouseY-y*r,mouseX-x*r));//#rot[(idx+x+y)%rot.size];
        idx += 1;

        image (plny,0,0);
      //image idx%((frameCount/2)%1000+1)==0?@@plny:@@prazdny,0,0
      popMatrix();

    }

  }

}


