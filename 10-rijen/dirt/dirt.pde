
int cycle = 30;
int num = 50000;

int shx[],shy[];// = new int[300];
int dirx[] = {-1,0,1,-1,1,-1,0,1,-2,-1,0,1,2,-2,-1,0,1,2,-2,-1,1,2,-2,-1,0,1,2,-2,-1,0,1,2};
int diry[] = {-1,-1,-1,0,0,1,1,1,-2,-2,-2,-2,-2,-1,-1,-1,-1,-1,0,0,0,0,1,1,1,1,1,2,2,2,2,2};


void setup(){
  size(800,400,P2D);

  loadPixels();

  colorMode(HSB);

  for(int i = 0 ; i < pixels.length;i++){
    pixels[i] = 0;//color(random(200,255),50,random(40,200));
  }

  reset();

  rectMode(CENTER);
}


void reset(){

  shx = new int[num];
  for(int i =0 ; i < shx.length;i++){
    shx[i] = dirx[(int)random(dirx.length)];
  }



  shy = new int[num];
  for(int i =0 ; i < shx.length;i++){
    shy[i] = diry[(int)random(diry.length)];
  }


}

void draw(){
  for(int y = 0 ; y < height;y++){
    for(int x = 0 ; x < width;x++){
      int idx = y*width+x;

      int idx2 = (pixels.length+(shy[(idx+idx+frameCount)%shy.length]+y)*width+(shx[(idx+idx+frameCount)%shx.length]+x))%(pixels.length) ;

      pixels[idx] = pixels[idx2];//(int)lerp(pixels[idx],pixels[idx2],0.01);
    }
  }

  if(frameCount%cycle==0)
    reset();

  //blend(g,0,0,width,height,0,0,width,height,MULTIPLY);


  //if(frameCount%(cycle)==0)
    //fastblur(g,5);


  fill((sin(frameCount/10.0)+1.0)*127);
  noStroke();
  translate(noise(frameCount/100.0,0)*width,noise(0,frameCount/100.0)*height);
  rotate(frameCount/30.0);

  rect(0,0,100,100);
}
