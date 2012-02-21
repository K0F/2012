////////////////////////////////////////
//  Hard quest of Zyrkos              //
//  kof, 2012                         //
////////////////////////////////////////

ArrayList heroes;
Hero you;
Ram ram;

int num = 5;
PGraphics ground;
PImage back;
PGraphics lens;
String filenames[] = {
  "heroDown.gif",
  "heroUp.gif",
  "heroLeft.gif",
  "heroRight.gif",
  "suicideLeftHand.gif"
};

PImage spriteUp,spriteDown,
       spriteRight,spriteLeft,
       spriteSuicide;

PGraphics[] animUp,animDown,
  animRight,animLeft,
  animSuicide;

PGraphics shadow;

String spriteUpFilename,spriteDownFilename,
       spriteRightFilename,spriteLeftFilename,
       spriteSuicideFilename;

void setup(){
  size(400,400);

  noSmooth();
  colorMode(HSB,255);

  back = loadImage("background.gif");
  ground = createGraphics(width,height,P2D);

  you = new Hero(filenames,width/2,height/2,0,color(255,255,255));

  ram = new Ram();
  heroes = new ArrayList();
  for(int i = 0 ; i < num ; i++){
    addNew();
  } 
  createLens();
}

void addNew(){
  if(heroes.size()%2==0)
    heroes.add(new Hero(filenames,(int)random(width),0,heroes.size()-1,color(200)));
  else
    heroes.add(new Hero(filenames,width,(int)random(height),heroes.size()-1,color(200)));
}

void createLens(){

  lens = createGraphics(width,height,P2D);
  lens.loadPixels();

  for(int y = 0; y<lens.width;y++)
    for(int x = 0;x<lens.width;x++){
      int sel = y*lens.width+x;
      float d = dist(x,y,lens.width/2,lens.height/2);
      lens.pixels[sel] = color(0,map(d,0,width*0.43,0,160));

    }

}

/////////////////////////////////////////////////

void draw(){
  background(back);

  /*
  // awful
  if(frameCount>5000)
  if(frameCount%25==0){
  int who = (int)random(heroes.size());
  Hero theOne = (Hero)heroes.get(who);
  theOne.dir = 4;
  }
   */

  if(frameCount%100==0)
    addNew();

  Collections.sort(heroes,new Comparator(){
      public int compare(Object o1,Object o2){

      Hero h1 = (Hero)o1;
      Hero h2 = (Hero)o2;
      if(h1.y > h2.y) return 1;
      if(h1.y < h2.y) return -1;
      return 0;
      }
      });


  image(ground,0,0);

  ground.beginDraw();
  ground.colorMode(RGB,255);


  you.display();

  boolean ramz = false;

  for(int i =0 ; i < heroes.size();i++){
    Hero hero = (Hero)heroes.get(i);

    if(hero.y>=ram.y && !ramz){
      ram.draw();
      ramz = true;
    }

    hero.display();

    if(frameCount%100==0){
      ground.strokeWeight(1);
      ground.stroke(random(255),5);
      ground.point(hero.x-random(-1,1),-3+hero.y+random(2));
      ground.point(hero.x+random(-1,1),-3+hero.y+random(2));
    }
  }
  ground.endDraw();

  if(!ramz)
    ram.draw();
  //noTint();

  if(ram.z<5){
    g.loadPixels();
    fastblur(g,5-(int)ram.z);
    g.updatePixels();
  }
  image(lens,0,0);

}


/////////////////////////////////////

//debug
void keyPressed(){
  if(key == ' ')
    for(int i =0 ; i < heroes.size();i++){
      Hero hero = (Hero)heroes.get(i);
      hero.reload();
    }

}

/////////////////////////////////////////

class Figure{
  //masking
  int cclr = -65321;
  int bclr =  -16777216;
  int id;
  color c;
  int w[] = new int[filenames.length];
  int h[] = new int[filenames.length];
  int wCnt = 0;
  int faze = 0;
  int x,y,px,py;
  int sc = 1;
  int speed = 5;
  boolean pause = false;
  int wait = 0;
  int dir = 0;
  boolean dead = false;
  boolean splatted = false;
  int sanim = 0;

  PGraphics makeShadow(){
    PGraphics tmp;

    tmp = createGraphics(20,20,JAVA2D);
    tmp.loadPixels();

    for(int y = 0 ; y < tmp.height;y++){
      for(int x = 0 ; x < tmp.width;x++){
        tmp.pixels[y*tmp.width+x] = color(0,10*(tmp.width*.5-dist(x,y+2,tmp.width/2,tmp.height/2)));
      }
    }

    return tmp;
  }


  ////////////////////////////////////////////////
  void check(){
    for(int i = 0;i<heroes.size();i++){

      Hero other = (Hero)heroes.get(i);
      if(other!=this){
        if(dist(x,y,other.x,other.y)<12.0){

          if(!other.dead){

            x -= (int)((other.x-x)/6.0);
            //other.x -= (int)((x-other.x)/6.0);
            y -= (int)((other.y-y)/6.0);
            //other.y -= (int)((y-other.y)/20.0);
            dir = (int)random(0,4);
          } 
          //other.dir = (dir+3)%4;
          //if(other.y==y){
          //  x += (int)random(-3,3);
          //  other.x += (int)random(-3,3);
          //}
          //other.faze++;
        }
      }
    }

  }

  ////////////////////////////////////////////////
  void reload(){

    spriteUp = loadImage(spriteUpFilename);
    spriteDown = loadImage(spriteDownFilename);
    spriteLeft = loadImage(spriteLeftFilename);
    spriteRight = loadImage(spriteRightFilename);
    spriteSuicide = loadImage(spriteSuicideFilename);

    animUp = getPhases(spriteUp);
    animDown = getPhases(spriteDown);
    animLeft = getPhases(spriteLeft);
    animRight = getPhases(spriteRight);
    animSuicide = getPhases(spriteSuicide);

  }
  void kill(){
    splat(random(5,12));
    heroes.remove(this);
  }

  ////////////////////////////////////////////////
  void splat(float s){

    splatted =true;

    ground.beginDraw();

    ground.colorMode(HSB,255);
    ground.noStroke(); 
    for(int i =0 ;i<random(5,20);i++){
      ground.stroke(c);
      ground.strokeWeight(random(1,3));
      ground.point(x+random(-s,s),y+random(-s/2,s/2));
    }

    for(int i = 0 ;i < 150;i++){
      ground.strokeWeight(1);
      ground.stroke(255,255,random(255),200);
      ground.point(x+random(-s*2,s*2),y+random(-s,s));
    }

    //ground.translate(x+w[dir]/2,y+h[dir]);
    //ground.rotate(random(-PI,PI));
    //ground.image(animSuicide[animSuicide.length-1],0-w[dir]/2,0,sc*w[dir],sc*h[dir]);


    ground.endDraw();


  }

  ////////////////////////////////////////////////
  void update(){

    if(pause){
      wait++;
      if(wait>10){
        pause = false;
        wait = 0;
      }
    }

    walkTrought();

    move();

      check();
    if(faze>=animUp.length)
      faze = 0;

  }

  ////////////////////////////////////////////////
  void move(){
  if(frameCount%speed==0)
    { 
      if(!pause){

        switch(dir){

          case 0:
            y -= sc;
            break;
          case 1:
            y += sc;
            break;
          case 2:
            x -= sc;
            break;
          case 3:
            x += sc;
            break;
          case -1:
            break;
        }
        faze++;
      }
    }



  }

  ////////////////////////////////////////////////
  void walkTrought(){

    if(y>height+h[dir]){
      y = 0 ;
    }

    if(y<-h[dir]){
      y = height+h[dir];
    }
    if(x>width+w[dir]/2){
      x = -w[dir]/2 ;
    }

    if(x<-w[dir]/2){
      x = width+w[dir]/2;
    }



  }

  ////////////////////////////////////////////////
  PGraphics [] getPhases(PImage _img){
    PGraphics tmp[];

    _img.loadPixels();


    ArrayList corners = new ArrayList();

    for(int i = 0 ; i < _img.width;i++){
      if(_img.pixels[i]==-65321){
        corners.add(i);
      }
    }

    int off = (int)(_img.width / (corners.size()+0.0)) ;
    //println("creating hero got "+corners.size()+" sprite phases w:"+off);

    w[wCnt] = off;
    h[wCnt] = _img.height;

    wCnt++;


    tmp = new PGraphics[corners.size()];

    for(int i = 0  ; i < corners.size();i++){
      PGraphics phase = createGraphics(off,_img.height,JAVA2D);
      phase.loadPixels();

      int shift = (Integer)corners.get(i);
      for(int y = 0 ;y<_img.height;y++){
        for(int x = 0 ;x<off;x++){
          int sel0 = y*phase.width+x;
          int sel1 = y*_img.width+x+shift;
          if(_img.pixels[sel1]!=bclr&&_img.pixels[sel1]!=cclr)
            phase.pixels[sel0] = _img.pixels[sel1];
        }
      }
      tmp[i] = phase;
    }

    return tmp;

  }
}

////////////////////////////////////////////////
class Hero extends Figure{

  Hero(String _names[],int _x,int _y,int _id,color _c){
    spriteDownFilename = _names[0];
    spriteUpFilename = _names[1];
    spriteLeftFilename = _names[2];
    spriteRightFilename = _names[3];
    spriteSuicideFilename = _names[4];

    dir = (int)random(0,4);
    id = _id;
    reload();

    c = _c;//random(0,255),random(145),random(85,200));

    x = _x;
    y = _y;

    speed = (int)random(4,12);
    faze = (int)random(animUp.length);

    shadow = makeShadow();
  }

  ////////////////////////////////////////////////
  void display(){
    if(!dead)
      update();    

    image(shadow,x-(sc*shadow.width/2),y-(sc*shadow.height/2),sc*shadow.width,sc*shadow.height);

    tint(c,255);   
    switch(dir){
      case 0:
        image(animUp[faze],x-(sc*w[dir]/2),y-(sc*h[dir]),sc*w[dir],sc*h[dir]);
        break;
      case 1:
        image(animDown[faze],x-(sc*w[dir]/2),y-(sc*h[dir]),sc*w[dir],sc*h[dir]);
        break;
      case 2:
        image(animLeft[faze],x-(sc*w[dir]/2),y-(sc*h[dir]),sc*w[dir],sc*h[dir]);
        break;
      case 3:
        image(animRight[faze],x-(sc*w[dir]/2),y-(sc*h[dir]),sc*w[dir],sc*h[dir]);
        break;
      case 4:

        dead = true;
        image(animSuicide[sanim],x-(sc*w[dir]/2),y-(sc*h[dir]),sc*w[dir],sc*h[dir]);

        if(sanim<animSuicide.length-1){
          if(frameCount%10==0)
            sanim++;

          if(!splatted && sanim==12)
            splat(10);

        }else{
          heroes.remove(this);
        }
        break;

    }

    noTint();
  }

}

////////////////////////////////////////////////
class Ram{
  PImage map;
  float tx,ty,x,y,sx,sy;
  float z = 10;
  float cycle = 235;

  boolean falling =  false;
  boolean moving = false;

  PGraphics shadow;
  int baseX[] = {-20,0,20,0};
  int baseY[] = {0,-10,0,10};


  ////////////////////////////////////////////////
  Ram(){
    tx = x = width/2;
    ty = y = -100;

    sx = 8;
    sy = 12;

    map = loadImage("ram.gif");
    shadow = makeShadow();
  }

  ////////////////////////////////////////////////
  void draw(){

    stroke(0);
    fill(255,255,0);

    if(frameCount>1500 && !falling)
      moving = falling = true;

    if(falling){
      cycle-=2;

      if(cycle<=46){
        //   falling = false;
        cycle = 235;
      }
    }

    if(dist(x,y,tx,ty)<30 && moving){
      tx = random(width);
      ty = random(height);
    }


    z = (sin(cycle/7.5)+1)*100;

    x += (tx-x)/(300.0-z);
    y += (ty-y)/(300.0-z);



    pushMatrix();
    translate(x+sx,y+sy-z);
    pushStyle();
    tint(255,55);
    image(shadow,-shadow.width/2,-shadow.height/2+z+20,shadow.width,shadow.height/2);
    noTint(); 

    image(map,-map.width/2,-map.height);

    //quad(baseX[0],baseY[0],baseX[0],-height,baseX[1],-height,baseX[1],baseY[3]);
    //quad(baseX[2],baseY[2],baseX[2],-height,baseX[1],-height,baseX[1],baseY[3]);

    popMatrix();
    check();

    popStyle();
  }

  ////////////////////////////////////////////////
  void check(){
    for(int i = 0 ; i < heroes.size();i++){
      Hero h = (Hero)heroes.get(i);
      if(dist(x+sx,y,h.x,h.y)<14 && z < 5){
        h.kill();
      }
    }
  }

  ////////////////////////////////////////////////
  PGraphics makeShadow(){
    PGraphics tmp;
    tmp = createGraphics(100,100,JAVA2D);
    tmp.loadPixels();
    for(int y = 0 ; y < tmp.height;y++){
      for(int x = 0 ; x < tmp.width;x++){
        tmp.pixels[y*tmp.width+x] = color(0,10*(tmp.width*.5-dist(x,y+2,tmp.width/2,tmp.height/2)));
      }
    }
    return tmp;
  }

  void bum(){
    falling = true;
  }
}

////////////////////////////////////////////////
void mousePressed(){
  ram.bum();
}
