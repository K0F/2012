boolean render = true;
String title = "Cyclic Study\nkof 12";

ArrayList obj;


float fade = 0;
float tras = 10.0;
PFont font;


void setup(){
  size(1280,720,P2D);

  frameRate(25);
  rectMode(CENTER);
  noSmooth();

  font =loadFont("Aller-Light-24.vlw"); 
  textFont(font,24);

  textMode(SCREEN);
  textAlign(CENTER,CENTER);

  obj = new ArrayList();



}



void draw(){

  background(0);

  if(frameCount<255){
    

    fill(255,fade);
    
    textFont(font,24);
    text(title,width/2,height/2);
    fade++;

  }else if(frameCount<510){

  fill(255,fade);
    
    textFont(font,24);
    text(title,width/2,height/2);
fade--;   
  }else{

  noStroke();
  fill(frameCount%777==0?#ff0000:255);

  // shake();

  if(frameCount%200==0)
    obj.add(new Obj());


  for(int i = 0 ; i < obj.size();i++){
    Obj tmp = (Obj)obj.get(i);
    tmp.draw();
  }
  }
  if(render)
    saveFrame("/home/kof/render/structural/fr#####.tga");

}

void shake(){

  translate((noise(frameCount/3.0,0)-0.5)*tras, (noise(0,frameCount/3.0)-0.5)*tras);



}

class Obj{
  int cyc;
  int len;
  float speed;
  int w,h;
  int interval;
  int id;
  int shift;
  float al;

  Obj(){


    cyc = 0;
    len = (int)random(300,3000);
    speed = random(2,200);

    w = (int)random(80,1000);
    h = (int)random(80,1000);

    while(w*h>20000){
      w = (int)random(20,1000);
      h = (int)random(20,1000);
    }

    shift = (int)random(90,900);

    interval = (int)random(6,25);

  }



  void draw(){


    if(frameCount%interval==0){

      rect(
          noise(cyc+frameCount/speed,0)*width,
          noise(0,cyc+frameCount/speed)*height,
          w,
          h);



      al = 255;
      cyc+=shift;

      if(cyc>len)
        cyc = 0 ;
    }




  }
}
