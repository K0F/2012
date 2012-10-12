//////////////////////////////////////////////////
//  string generator
//  kof, 2012
//
//////////////////////////////////////////////////

String prepare[];

void setup(){

  size(700,900,P2D);
  frame.setLocation(0,-1);
  prepare = new String[(int)(height/10.0)];

  textFont(createFont("Semplice Regular",8,false));
  textMode(SCREEN);
  for(int i = 0 ; i < prepare.length;i++){
    prepare[i] = "";

    for(int ii= 0;ii<50;ii++)
      prepare[i] += (char)random(41,90);

  }
}

//////////////////////////////////////////////////

void init(){
  frame.setAlwaysOnTop(true);
  frame.removeNotify();
  frame.setUndecorated(true);
  super.init();
}

///////////////////////////////////////////////////


void draw(){

  background(0);
  fill(255);

  if(frameCount%100==0)
    for(int i = 0 ; i < prepare.length;i++){
      prepare[i] = "";

      for(int ii= 0;ii<50;ii++)
        prepare[i] += (char)random(66,90);
    }

  int cnt = 0;
  for(int i = 0 ; i < height; i+=10){
    text(prepare[cnt],10,i);
    cnt++;
  }
}
