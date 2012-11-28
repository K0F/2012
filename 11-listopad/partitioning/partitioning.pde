ArrayList cloud;
ArrayList seekers;

PImage input;
float THRES = 20;
int MINW = 1;
int cnt = 0;

int LIFETIME = 50;

int dens = 100;

float ALPH = 255;
int NUM = 400;

void setup(){
  input = loadImage("out.png");

  size(input.width,input.height,P2D);

  colorMode(HSB);
  input.loadPixels();
  loadPixels();


  // analyze(0,0,width-1,height-1);
  noSmooth();

  background(0);


  noStroke();

  cloud = new ArrayList();
  analyze(0,0,width,height,1);


  seekers = new ArrayList();
  //for(int i = 0 ; i < cloud.size();i++){
  //  seekers.add(new Seeker());
  //}
}


void draw(){

  /*
   for(int i = 0 ; i < seekers.size();i++){
     Seeker s = (Seeker)seekers.get(i);
     s.draw();
     }
*/


  background(0);
  for(int i =0 ; i < cloud.size();i++){
    Pnt tmp = (Pnt)cloud.get(i);
    stroke(255,tmp.w*10);
    point(tmp.pos.x,tmp.pos.y);

  }


}

class Pnt{
  PVector pos;
  float w;
  color c;

  Pnt(PVector _pos,float _w,color _c){
    pos = new PVector(_pos.x,_pos.y);
    w=_w;
    c=_c;

  }
}

class Seeker{
  PVector pos,dir;

  float radius;
  int life;

  Seeker(){
    restart();
  }

  void restart(){
    pos = new PVector(random(width),random(height));
    dir = new PVector(0,0);
    life = LIFETIME;
    radius = random(200,222);
  }


  void draw(){

    if(life<0)
      restart();
    life--;

    dir.mult(0.5);


    float D = 0;
    int cnt = 0;

    color _c = color(255);

    for(int i =0  ; i < cloud.size() ;i+=2){

      int idx = i;//(int)random(cloud.size());
      Pnt tmp = (Pnt)cloud.get(idx);

      float d = dist(tmp.pos.x,tmp.pos.y,pos.x,pos.y);

      if(d<radius){
        dir.add(new PVector((tmp.pos.x-pos.x)/d*(float)tmp.w ,(tmp.pos.y-pos.y)/d*(float)tmp.w));
        _c = lerpColor(tmp.c,_c,0.1);
        D+=d;
        cnt++;
      }

     // stroke(tmp.c,20);
    }

    D/=(float)cnt;

    dir.limit(D/5.0);
//    strokeWeight(D);

    _c = lerpColor(_c,input.pixels[(int)pos.y*input.width+(int)pos.x],0.5);
    stroke(_c,15);
    line(pos.x,pos.y,pos.x+dir.x,pos.y+dir.y);


    dir.normalize();
    pos.add(dir);

  }


}

void analyze(int x,int y,int w, int h, int level){

  if(x<0||y<0||x+w>width||y+h>height)
    return;

  float avgh = 0;
  float avgs = 0;
  float avgb = 0;

  for(int Y = y ; Y < y+h ; Y++){
    for(int X = x ; X < x+w ; X++){
      int idx = (Y)*(input.width)+(X);
      avgh += (hue(input.pixels[idx]));
      avgs += (saturation(input.pixels[idx]));
      avgb += (brightness(input.pixels[idx]));
    }
  }

  avgh /= (float)w*h;
  avgs /= (float)w*h;
  avgb /= (float)w*h;


  float diffh = 0;
  float diffs = 0;
  float diffb = 0;

  for(int Y = y ; Y < y+h ; Y++){
    for(int X = x ; X < x+w ; X++){
      int idx = (Y)*(input.width)+(X);
      diffh += abs(avgh-hue(input.pixels[idx]));
      diffs += abs(avgs-saturation(input.pixels[idx]));
      diffb += abs(avgb-brightness(input.pixels[idx]));
    }
  }

  diffh /= (float)w*h;
  diffs /= (float)w*h;
  diffb /= (float)w*h;

//  fill(avgh,avgs,avgb,ALPH);
  //  fill(diffh,diffs,diffb,ALPH);
  //rect(x-1,y-1,w+1,h+1);

  //stroke(avgh,avgs,avgb,ALPH);
  //point(x+w/2,y+w/2);

  if(diffh<10)
  cloud.add(new Pnt(new PVector(x,y),level,color(avgh,avgs,avgb)));

  if((diffh > THRES || diffs > THRES || diffb > THRES) && w > MINW){
    analyze(x,y,w/2,h/2,level+1);
    analyze(x+w/2,y,w/2,h/2,level+1);
    analyze(x,y+h/2,w/2,h/2,level+1);
    analyze(x+w/2,y+h/2,w/2,h/2,level+1);

  }






}
