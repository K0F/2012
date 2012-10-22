

void eightGUI(){
  
  int y = ctlskip*2;

  cp5.addSlider("alphaEight")
    .setRange(0, 255)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(eight)
            ;
  y+=ctlskip;


}

int velikost = 300;
int sc = 1;
 
 
 
int shiftx = 2;
int shifty = 0;
 
boolean matix[][];
 
color c1 = color(255,128,0);
color c2 = color(0);


float alphaEight = 0;

void setupEight(){
   matix = new boolean[1024][768];
 
 
  for(int y = 0;y<matix[0].length;y++) { 
    for(int x = 0;x<matix[0].length;x++) {
      matix[x][y] = (random(20)>10) ? true : false;
    }
  }
  noStroke();
  noSmooth();

  
  
}


void eight(){
  noSmooth();
  
  c1 = color(255);
  shiftx = (int)((noise(-frameCount/33.12)-0.5)*width);
  shifty = (int)((noise(frameCount/300.0)-0.5)*height);
  for(int y = 0;y<matix[0].length;y++) {
 
    for(int x = 0;x<matix.length/2;x++) {
      stroke((matix[x][y])?c1:c2,alphaEight);
      point(x*sc,y*sc);
    }
 
    for(int x = matix.length/2;x<matix.length;x++) {
      stroke((matix[matix.length-x][y])?c1:c2,alphaEight);
      point(x*sc,y*sc);
    }
  }
 
 
  randomize((int)(noise(frameCount/230.2)*20));
  
//  saveFrame("video/nf####.png");
   
}



int cnt = 0;
void randomize(int kolik) {
  for(int y = 0;y<matix[0].length;y++) {
    for(int x = 0;x<matix[0].length;x++) {
 
 
      if((random(1000))<kolik) {
        matix[x][y] = !matix[x][y];
      }
      else if(matix[(x+width-shiftx)%(width/sc-1)][y]) {
        matix[x][y] = matix[(x+width+2)%(width/sc-1)][y];
      }
      else {
        matix[x][y] = matix[x][(y+height-shifty)%(height/sc-1)];
      }
    }
  }
}

