ArrayList heroes;
int num = 200;
PGraphics ground;

void setup(){
  size(320,640);

noSmooth();
colorMode(HSB,255);

  ground = createGraphics(width,height,P2D);

  heroes = new ArrayList();
  for(int i = 0 ; i < num ; i++)
    heroes.add(new Hero("hero.gif",(int)random(width),(int)random(height),i,random(-127,127)>0?1:-1));
}

/////////////////////////////////////////////////

void draw(){
  background(35);


  Collections.sort(heroes,new Comparator(){
      public int compare(Object o1,Object o2){
      Hero h1 = (Hero)o1;
      Hero h2 = (Hero)o2;
      if(h1.y > h2.y) return 1;
      if(h1.y < h2.y) return -1;
      return 0;
      }
      });


  //tint(255,15);
  image(ground,0,0);
  //noTint();

  ground.beginDraw();
  ground.stroke(random(255),1);
  for(int i =0 ; i < heroes.size();i++){
    Hero hero = (Hero)heroes.get(i);
    hero.display();
  
 
    if(hero.y%4==0&&frameCount%hero.speed==0&&frameCount%5==0){
    ground.point(hero.x-random(-1,1),-3+hero.y+random(2));
    ground.point(hero.x+random(-1,1),-3+hero.y+random(2));
    }
  }
  ground.endDraw();

}


/////////////////////////////////////

//debug
void keyPressed(){


  if(key == ' ')
    for(int i =0 ; i < heroes.size();i++){
      Hero hero = (Hero)heroes.get(i);
      hero.reload("hero.gif");
    }
}




/////////////////////////////////////////

class Hero{
  PImage sprite;
  PGraphics[] anim;
  PGraphics shadow;
  String spriteFilename;

  //masking
  int cclr = -65321;
  int bclr =  -16777216;

  int id;

  int w,h;

  int faze = 0;

  int x,y;

  int sc = 1;

  int speed = 5;

  color c;

  boolean pause = false;

  int wait = 0;

  int dir = 0;

  Hero(String _name,int _x,int _y,int _id,int _dir){

    dir = _dir;

    id = _id;

    if(dir==1)
        reload("hero.gif");
    else
      reload("heroUp.gif");

    c = color(random(0,255),random(15,45),random(150,180));

    x = _x;
    y = _y;

    speed = (int)random(4,12);
    faze = (int)random(anim.length);

    shadow = makeShadow();

  }

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

  Hero(String _spriteFilename){

    reload(_spriteFilename);



    x = width/2;
    y = height/2;



  }

  void check(){
    for(int i = 0;i<heroes.size();i++){
      Hero other = (Hero)heroes.get(i);
      if(dist(x,y,other.x,other.y)<10){
        x -= (int)((other.x-x)/5.0);
        other.x -= (int)((x-other.x)/20.0);
        y -= (int)((other.y-y)/5.0);
        other.y -= (int)((y-other.y)/20.0);

        x += (int)random(-2,2);

          other.faze++;
      }
    }

  }

  void reload(String _name){

    spriteFilename = _name+"";
    sprite = loadImage(spriteFilename);
    sprite.loadPixels();

    anim = getPhases();


  }

  void display(){
    update();    
    tint(c);   

    image(shadow,x-(sc*shadow.width/2),y-(sc*shadow.height/2),sc*shadow.width,sc*shadow.height);
    image(anim[faze],x-(sc*w/2),y-(sc*h),sc*w,sc*h);


  }

  void update(){


    if(pause){
      wait++;
      if(wait>10){
        pause = false;
        wait = 0;
      }
    }

    if(y>height+h){
      y = 0 ;
    }

    if(y<-h){
      y = height+h;
    }

    if(frameCount%speed==0)
    { 
      if(!pause){
        y+= sc*dir;
        faze++;
      }
      check();
    }

    if(faze>=anim.length)
      faze = 0;

  }

  PGraphics [] getPhases(){
    PGraphics tmp[];

    sprite.loadPixels();


    ArrayList corners = new ArrayList();

    for(int i = 0 ; i < sprite.width;i++){
      if(sprite.pixels[i]==-65321){
        corners.add(i);
      }
    }

    int off = (int)(sprite.width / (corners.size()+0.0)) ;
    //println("creating hero got "+corners.size()+" sprite phases w:"+off);

    w = off;
    h = sprite.height;


    tmp = new PGraphics[corners.size()];

    for(int i = 0  ; i < corners.size();i++){
      PGraphics phase = createGraphics(off,sprite.height,JAVA2D);
      phase.loadPixels();


      int shift = (Integer)corners.get(i);
      for(int y = 0 ;y<sprite.height;y++){
        for(int x = 0 ;x<off;x++){
          int sel0 = y*phase.width+x;
          int sel1 = y*sprite.width+x+shift;
          if(sprite.pixels[sel1]!=bclr&&sprite.pixels[sel1]!=cclr)
            phase.pixels[sel0] = sprite.pixels[sel1];
        }
      }
      tmp[i] = phase;
    }

    return tmp;

  }

}


