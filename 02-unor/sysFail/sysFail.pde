import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

////////////////////////////////////////
//  Stop the madness!                 //
//  kof, 2012                         //
////////////////////////////////////////

Minim minim;
AudioSnippet splatter[], bum[], background, announce, introduction, failsong;
AudioInput input;
int splatCnt = 0;

ArrayList heroes;
Hero you;
Ram ram;
Rain rain;

int raining_intensity = 800;

PFont font;

int kills = 0;
int saved = 0;
int hardLimit = 30;
boolean fail = false;

boolean intro = true;
boolean incoming = false;

int num = 1;
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

PImage spriteUp, spriteDown, 
spriteRight, spriteLeft, 
spriteSuicide;

PGraphics[] animUp, animDown, 
animRight, animLeft, 
animSuicide;

PGraphics shadow;

String spriteUpFilename, spriteDownFilename, 
spriteRightFilename, spriteLeftFilename, 
spriteSuicideFilename;

void setup() {
  size(400, 400);

  frameRate(40);

  minim = new Minim(this);

  splatter = new AudioSnippet[3];
  splatter[0] = minim.loadSnippet("splatter.mp3");
  splatter[1] = minim.loadSnippet("splatter.mp3");
  splatter[2] = minim.loadSnippet("splatter.mp3");

  bum = new AudioSnippet[3];
  bum[0] = minim.loadSnippet("bum.mp3");
  bum[1] = minim.loadSnippet("bum.mp3");
  bum[2] = minim.loadSnippet("bum.mp3");

  background = minim.loadSnippet("background.mp3");
  introduction = minim.loadSnippet("intro.mp3");

  announce = minim.loadSnippet("background2.mp3");

  failsong = minim.loadSnippet("fail.mp3");

  //input = minim.getLineIn();



  font = loadFont("font.vlw");
  textFont(font, 8);

  noCursor();

  noSmooth();
  colorMode(HSB, 255);

  back = loadImage("background.gif");
  ground = createGraphics(width, height, P2D);

  //  you = new Hero(filenames,width/2,height/2,0,color(255,255,255),true);

  ram = new Ram();
  heroes = new ArrayList();
  for (int i = 0 ; i < num ; i++) {
    addNew();
  } 
  createLens();

  rain = new Rain(raining_intensity);


  introduction.loop();
}

void stop() {
  splatter[0].close();
  splatter[1].close();
  splatter[2].close();

  bum[0].close();
  bum[1].close();
  bum[2].close();

  introduction.close();
  background.close();
  failsong.close();

  //input.close();

  minim.stop();
  super.stop();
}

void addNew() {
  if (heroes.size()%2==0)
    heroes.add(new Hero(filenames, (int)random(width), 0, heroes.size(), color(250), false));//color(random(255),random(55),random(55,150)),false));
  else
    heroes.add(new Hero(filenames, width, (int)random(height), heroes.size(), color(250), false));//color(random(255),random(55),random(55,150)),false));
}

void createLens() {
  lens = createGraphics(width, height, P2D);
  lens.loadPixels();

  for (int y = 0; y<lens.width;y++)
    for (int x = 0;x<lens.width;x++) {
      int sel = y*lens.width+x;
      float d = dist(x, y, lens.width/2, lens.height/2);
      lens.pixels[sel] = color(0, map(d, 0, width*0.43, 0, 160));
    }
}

void animCursor() {
  pushStyle();
  stroke(255, 35);
  noFill();

  for (int i = 1 ; i < 10; i++) {
    ellipse(mouseX, mouseY, sin(frameCount/30.0)*50/i, sin(frameCount/30.0)*25/i);
  }

  popStyle();
}

void restart() {

  kills = 0;

  fail = false;

  ground = createGraphics(width, height, P2D);

  frameCount = 0;

  ram = new Ram();

  announce.play(0);

  heroes = new ArrayList();
  for (int i = 0 ; i < num ; i++) {
    addNew();
  }
}

/////////////////////////////////////////////////

void draw() {
  background(back);

  if (intro) {
    loadPixels();
    fastblur(g, 5);
    updatePixels();   
    fill(0, 155);
    noStroke();
    rect(0, 0, width, height);
    fill(255, 255, 255);
    textAlign(CENTER);
    
    text("Our lives and lives of our children is in your hands.."+
    "The global corporates are helping our rotten government"+
    " to find and destroy it's opponents. They are getting more"+
    " and more powerful; so they are able to find more and more people."+
    "\nPlease, you have to stop this, we will follow you!\n\n"+
    "(click to continue)",
    20, height/2-125,
    width-40,height); 
    
    textAlign(LEFT);

    image(animDown[0], 160, 160, 
    animDown[0].width*20, 
    animDown[0].height*20);
  }
  else {



    /*
  // awful
     if(frameCount>5000)
     if(frameCount%25==0){
     int who = (int)random(heroes.size());
     Hero theOne = (Hero)heroes.get(who);
     theOne.dir = 4;
     }
     */

    if (frameCount%50==0 && !fail)
      addNew();

    Collections.sort(heroes, new Comparator() {
      public int compare(Object o1, Object o2) {

        Hero h1 = (Hero)o1;
        Hero h2 = (Hero)o2;
        if (h1.y > h2.y) return 1;
        if (h1.y < h2.y) return -1;
        return 0;
      }
    }
    );


    image(ground, 0, 0);
    ground.beginDraw();
    ground.colorMode(RGB, 255);

    //you.display();

    boolean ramz = false;

    for (int i =0 ; i < heroes.size();i++) {
      Hero hero = (Hero)heroes.get(i);

      if (hero.y>=ram.y && !ramz) {
        ram.draw();
        ramz = true;
      }

      hero.display();

      if (frameCount%100==0) {
        ground.strokeWeight(1);
        ground.stroke(random(255), 5);
        ground.point(hero.x-random(-1, 1), -3+hero.y+random(2));
        ground.point(hero.x+random(-1, 1), -3+hero.y+random(2));
      }
    }
    ground.endDraw();

    if (!ramz)
      ram.draw();
    //noTint();
    rain.display();
     animCursor();
    
    if (ram.z<5) {
      g.loadPixels();
      fastblur(g, 5-(int)ram.z);
      g.updatePixels();
    }

   

    
    image(lens, 0, 0);





    fill(255);
    text("population count: "+heroes.size(), 10, height-10);
    text("the casualties: "+kills, 10, height-20);



    if (kills>=hardLimit) {
      if (!fail){
        failsong.play();
        saved = heroes.size();
      }
      fail = true;



      loadPixels();
      fastblur(g, 5);
      updatePixels();   
      fill(0, 55);
      noStroke();
      rect(0, 0, width, height);
      fill(255, 255, 255);
      textAlign(CENTER);
      text("Ahh wait, this is getting way too messy, you had lost too many innocent people!\n anyway, you have managed to save "+saved+" lives, well done.. \n\n TRY TO SAVE MORE!", 
      width/2, height/2-75); 
      textAlign(LEFT);
    }
  }
}


/////////////////////////////////////

//debug
void keyPressed() {
  if (key == ' ')
    for (int i =0 ; i < heroes.size();i++) {
      Hero hero = (Hero)heroes.get(i);
      hero.reload();
    }


  if (keyCode==LEFT) {
    you.dir = 2;

    you.x --;
  }
  else if (keyCode==RIGHT) {
    you.dir = 3;

    you.x ++;
  }
  else if (keyCode==UP) {
    you.dir = 0;

    you.y --;
  }
  else if (keyCode==DOWN) {
    you.dir = 1;

    you.y ++;
  }
}

/////////////////////////////////////////

class Figure {
}

////////////////////////////////////////////////
class Hero extends Figure {


  color c;
  boolean I;
  int cclr = -65321;
  int bclr =  -16777216;
  int id;
  int w[] = new int[filenames.length];
  int h[] = new int[filenames.length];
  int wCnt = 0;
  int faze = 0;
  float x, y, px, py;
  int sc = 1;
  int speed = 5;
  boolean pause = false;
  int wait = 0;
  int dir = 0;
  boolean dead = false;
  boolean splatted = false;
  int sanim = 0;


  Hero(String _names[], int _x, int _y, int _id, color _c, boolean _I) {
    I=_I;
    spriteDownFilename = _names[0];
    spriteUpFilename = _names[1];
    spriteLeftFilename = _names[2];
    spriteRightFilename = _names[3];
    spriteSuicideFilename = _names[4];

    dir = (int)random(0, 4);
    id = _id;
    reload();

    c = _c;//random(0,255),random(145),random(85,200));

    x = _x;
    y = _y;

    if (I)
      speed = 5;
    else
      speed = (int)random(4, 8);

    faze = (int)random(animUp.length);

    shadow = makeShadow();
  }

  void kill() {
    splat(random(5, 12));

    if (!fail)
      kills ++;

    heroes.remove(this);
  }

  int getQuadrant() {

    float theta = atan2(mouseY-y, mouseX-x);

    int d = dir;
    //up
    if (degrees(theta) > -135 && degrees(theta) < -45)
      d = 0;



    //right
    if (degrees(theta) > -45 && degrees(theta) < 45)
      d = 3;



    //down
    if (degrees(theta) > 45 && degrees(theta) < 135)
      d = 1;

    //left
    if (degrees(theta) > 135 && degrees(theta) < 180)
      d = 2;

    //left
    if (degrees(theta) > -180 && degrees(theta) < -135)
      d = 2;




    return d;
  }

  ////////////////////////////////////////////////
  void move() {


    dir = getQuadrant();


    if (frameCount%speed==0)
    { 
      if (!pause) {

        switch(dir) {
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
      }
    }



    if (frameCount%speed==0)
      faze++;

    // x += (mouseX-x)/(100.0*speed);
    // y += (mouseY-y)/(100.0*speed);
  }

  ////////////////////////////////////////////////
  void update() {

    if (pause) {
      wait++;
      if (wait>10) {
        pause = false;
        wait = 0;
      }
    }

    walkTrought();


    if (!I) {
      check();

      move();
    }

    if (faze>=animUp.length)
      faze = 0;
  }


  ////////////////////////////////////////////////
  void walkTrought() {

    if (y>height+h[dir]) {
      y = 0 ;
    }

    if (y<-h[dir]) {
      y = height+h[dir];
    }
    if (x>width+w[dir]/2) {
      x = -w[dir]/2 ;
    }

    if (x<-w[dir]/2) {
      x = width+w[dir]/2;
    }
  }

  ////////////////////////////////////////////////
  PGraphics [] getPhases(PImage _img) {
    PGraphics tmp[];

    _img.loadPixels();

    ArrayList corners = new ArrayList();

    for (int i = 0 ; i < _img.width;i++) {
      if (_img.pixels[i]==-65321) {
        corners.add(i);
      }
    }

    int off = (int)(_img.width / (corners.size()+0.0)) ;
    //println("creating hero got "+corners.size()+" sprite phases w:"+off);

    w[wCnt] = off;
    h[wCnt] = _img.height;

    wCnt++;

    tmp = new PGraphics[corners.size()];

    for (int i = 0  ; i < corners.size();i++) {
      PGraphics phase = createGraphics(off, _img.height, JAVA2D);
      phase.loadPixels();

      int shift = (Integer)corners.get(i);
      for (int y = 0 ;y<_img.height;y++) {
        for (int x = 0 ;x<off;x++) {
          int sel0 = y*phase.width+x;
          int sel1 = y*_img.width+x+shift;
          if (_img.pixels[sel1]!=bclr&&_img.pixels[sel1]!=cclr)
            phase.pixels[sel0] = _img.pixels[sel1];
        }
      }
      tmp[i] = phase;
    }

    return tmp;
  }



  ////////////////////////////////////////////////
  void display() {
    if (!dead)
      update();    

    image(shadow, x-(sc*shadow.width/2), y-(sc*shadow.height/2), sc*shadow.width, sc*shadow.height);

    switch(dir) {
    case 0:

      image(animUp[faze], x-(sc*w[dir]/2), y-(sc*h[dir]), sc*w[dir], sc*h[dir]);
      break;
    case 1:
      image(animDown[faze], x-(sc*w[dir]/2), y-(sc*h[dir]), sc*w[dir], sc*h[dir]);
      break;
    case 2:
      image(animLeft[faze], x-(sc*w[dir]/2), y-(sc*h[dir]), sc*w[dir], sc*h[dir]);
      break;
    case 3:
      image(animRight[faze], x-(sc*w[dir]/2), y-(sc*h[dir]), sc*w[dir], sc*h[dir]);
      break;
    case 4:

      dead = true;
      image(animSuicide[sanim], x-(sc*w[dir]/2), y-(sc*h[dir]), sc*w[dir], sc*h[dir]);

      if (sanim<animSuicide.length-1) {
        if (frameCount%10==0)
          sanim++;

        if (!splatted && sanim==12)
          splat(10);
      }
      else {
        heroes.remove(this);
      }
      break;
    }


    fill(255);
  }

  ////////////////////////////////////////////////
  void splat(float s) {

    splatted =true;

    ground.beginDraw();

    ground.colorMode(HSB, 255);
    ground.noStroke(); 
    for (int i =0 ;i<random(5,20);i++) {
      ground.stroke(c);
      ground.strokeWeight(random(1, 3));
      ground.point(x+random(-s, s), y+random(-s/2, s/2));
    }

    for (int i = 0 ;i < 150;i++) {
      ground.strokeWeight(1);
      ground.stroke(255, 255, random(255), 200);
      ground.point(x+random(-s*2, s*2), y+random(-s, s));
    }

    //ground.translate(x+w[dir]/2,y+h[dir]);
    //ground.rotate(random(-PI,PI));
    //ground.image(animSuicide[animSuicide.length-1],0-w[dir]/2,0,sc*w[dir],sc*h[dir]);


    ground.endDraw();
  }
  //masking
  PGraphics makeShadow() {
    PGraphics tmp;

    tmp = createGraphics(20, 20, JAVA2D);
    tmp.loadPixels();

    for (int y = 0 ; y < tmp.height;y++) {
      for (int x = 0 ; x < tmp.width;x++) {
        tmp.pixels[y*tmp.width+x] = color(0, 10*(tmp.width*.5-dist(x, y+2, tmp.width/2, tmp.height/2)));
      }
    }

    return tmp;
  }

  ////////////////////////////////////////////////
  void check() {
    for (int i = 0;i<heroes.size();i++) {

      Hero other = (Hero)heroes.get(i);
      if (other!=this) {
        if (dist(x, y, other.x, other.y)<12.0) {

          if (!other.dead) {

            x -= (int)((other.x-x)/6.0);
            //other.x -= (int)((x-other.x)/6.0);
            y -= (int)((other.y-y)/6.0);
            //other.y -= (int)((y-other.y)/20.0);
            dir = (int)random(0, 4);
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
  void reload() {

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
}

////////////////////////////////////////////////
class Ram {
  PImage map;
  float tx, ty, x, y, sx, sy;
  float z = 10;
  float cycle = 235;
  int curr = 0;

  boolean falling =  false;
  boolean moving = false;

  PGraphics shadow;
  int baseX[] = {
    -20, 0, 20, 0
  };
  int baseY[] = {
    0, -10, 0, 10
  };


  ////////////////////////////////////////////////
  Ram() {
    tx = x = width/2;
    ty = y = -100;

    sx = 8;
    sy = 12;

    map = loadImage("ram.gif");
    shadow = makeShadow();
  }

  ////////////////////////////////////////////////
  void draw() {

    stroke(0);
    fill(255, 255, 0);

    //println(frameCount);

    if (frameCount>730 && !falling)
      moving = falling = true;

    if (falling) {
      cycle-=2;

      if (cycle<=46) {
        //   falling = false;


        cycle = 235;
      }
    }

    if (dist(x, y, tx, ty)<30 && moving) {
      tx = random(width);
      ty = random(height);
    }


    z = (sin(cycle/7.5)+1)*100;

    if (z<1)
      playSound();

    x += (tx-x)/(300.0-z);
    y += (ty-y)/(300.0-z);

    pushMatrix();
    translate(x+sx, y+sy-z);
    pushStyle();
    tint(255, 55);
    image(shadow, -shadow.width/2, -shadow.height/2+z+20, shadow.width, shadow.height/2);
    noTint(); 

    image(map, -map.width/2, -map.height);

    //quad(baseX[0],baseY[0],baseX[0],-height,baseX[1],-height,baseX[1],baseY[3]);
    //quad(baseX[2],baseY[2],baseX[2],-height,baseX[1],-height,baseX[1],baseY[3]);

    popMatrix();
    check();

    popStyle();
  }

  void playSplat() {
    splatter[splatCnt].play(0);
    splatCnt++;
    if (splatCnt>=splatter.length)
      splatCnt=0;
  }

  void playSound() {

    bum[curr].play(0);
    curr++;
    if (curr>=bum.length)
      curr=0;
  }

  ////////////////////////////////////////////////
  void check() {
    for (int i = 0 ; i < heroes.size();i++) {
      Hero h = (Hero)heroes.get(i);
      if (dist(x+sx, y, h.x, h.y)<14 && z < 5) {
        playSplat();
        h.kill();
      }
    }
  }

  ////////////////////////////////////////////////
  PGraphics makeShadow() {
    PGraphics tmp;
    tmp = createGraphics(100, 100, JAVA2D);
    tmp.loadPixels();
    for (int y = 0 ; y < tmp.height;y++) {
      for (int x = 0 ; x < tmp.width;x++) {
        tmp.pixels[y*tmp.width+x] = color(0, 10*(tmp.width*.5-dist(x, y+2, tmp.width/2, tmp.height/2)));
      }
    }
    return tmp;
  }

  void bum() {
    falling = true;
  }
}

////////////////////////////////////////////////
void mousePressed() {
  if (fail)
    restart();

  if (intro) {
    frameCount = 0;
    intro = false;
    background.loop();
    announce.play();
    introduction.close();
  }
}

class Rain {
  ArrayList drops; 

  Rain(int _num) {
    drops = new ArrayList();

    for (int i =0 ;  i < _num;i++)
      drops.add(new Drop());
  }

  void display() {
    for (int i =0 ;  i < drops.size();i++) {
      Drop d = (Drop)drops.get(i);
      d.display();
    }
  }
}

class Drop {
  PVector pos, ppos;
  float cyc;
  float wind = 0.45;
  Drop() {
    cyc = random(height)/4;
    float x = random(-width, width*2);
    float y = random(0,height);
    pos = new PVector(x, y); 
    ppos = new PVector(x, y);
    
    
  }

  void generate() {
    cyc = -random(height)/4;
    float x = random(-width, width*2);
    float y = -random(height);
    pos = new PVector(x, y); 
    ppos = new PVector(x, y);
  }

  void display() {
    pos.y += 6;
    pos.add(new PVector(1*(noise((cyc+pos.x)/30.0)-0.5), 0));
    pos.x += wind;
    stroke(255, 120);
    line(pos.x, pos.y, ppos.x, ppos.y);
    ppos.x = pos.x;
    ppos.y = pos.y;

    cyc++;

    if (cyc>height/4.0) {
      noFill();
      stroke(255,20);
      ellipse(pos.x,pos.y,3,1.5);
      cyc = 0;
      generate();
    }
  }
}

