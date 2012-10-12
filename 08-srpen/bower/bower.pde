Hero hero;
ArrayList arrows;
ArrayList targets;
PVector gravity;

float friction = 0.996;



PVector begin,end;

boolean aim = false;

void setup(){
  size(1024,700,P2D);

  gravity = new PVector(0,0.25);


  hero = new Hero(width/2,height-30);
  begin = new PVector(hero.pos.x,hero.pos.y);
  end = new PVector(hero.pos.x,hero.pos.y);
  arrows = new ArrayList();
  targets = new ArrayList();
}

void draw(){
  background(0);

  if(frameCount%100==0){
    targets.add(new Target());
  }


  for(int i = 0 ; i < targets.size();i++){
    Target tmp = (Target)targets.get(i);
    tmp.draw();

  }

  for(int i = 0 ; i < arrows.size();i++){
    Arrow tmp = (Arrow)arrows.get(i);
    if(tmp.ready)
      tmp.draw();
  }

  if(aim){
    strokeWeight(3);
    stroke(255,40);
    line(begin.x,begin.y,mouseX,mouseY);
  }

  hero.draw();

}

void mousePressed(){

  begin = new PVector(mouseX,mouseY);

  aim = true;

  arrows.add(new Arrow());
}

void mouseReleased(){

  end = new PVector(mouseX,mouseY);
  aim = false;

  Arrow current = (Arrow)arrows.get(arrows.size()-1);

  current.shoot(new PVector(hero.pos.x,hero.pos.y),new PVector(begin.x-end.x,begin.y-end.y));
}



class Hero{
  PVector pos;
  PImage map;
  PGraphics head,torso,bow;

  float theta = 0;
  Hero(float x,float y){
    pos = new PVector(x,y);
    makeTextures();
  }

  void makeTextures(){

    map = loadImage("hero.gif");

    map.loadPixels();

    head = createGraphics(7,8,P2D);
    head.loadPixels();

    int trans = -16777216;

    int sx = 1;
    int sy = 3;
    for(int y = 0;y<head.height;y++){
      for(int x = 0;x<head.width;x++){
        int midx = (y+sy)*map.width+(sx+x);
        if(map.pixels[midx]!=trans)
          head.pixels[y*head.width+x] = map.pixels[midx];
      }
    }

    torso = createGraphics(8,10,P2D);
    torso.loadPixels();

    sx = 10;
    sy = 2;
    for(int y = 0;y<torso.height;y++){
      for(int x = 0;x<torso.width;x++){
        int midx = (y+sy)*map.width+(sx+x);
        if(map.pixels[midx]!=trans)
          torso.pixels[y*torso.width+x] = map.pixels[midx];
      }
    }

    bow = createGraphics(7,14,P2D);
    bow.loadPixels();


    sx = 16;
    sy = 1;
    for(int y = 0;y<bow.height;y++){
      for(int x = 0;x<bow.width;x++){
        int midx = (y+sy)*map.width+(sx+x);
        if(map.pixels[midx]!=trans)
          bow.pixels[y*bow.width+x] = map.pixels[midx];
      }
    }



    println(map.pixels[0]);


  }


  void draw(){

    imageMode(CENTER);

    //translate(0,-7);
    //image(torso,pos.x+1,pos.y+7);

    pushMatrix();
    translate(pos.x+2,pos.y-2);
    //    rotate(theta);
    image(head,0,-5);
    popMatrix();

    pushMatrix();
    translate(pos.x,pos.y);
    if(aim){
      theta = atan2(mouseY-begin.y,mouseX-begin.x);
    }
    rotate(theta);
    image(bow,-15,0);
    popMatrix();
  }
}

class Arrow{
  PVector pos;
  PVector lpos;
  PVector acc;
  PVector vel;

  boolean ready;
  boolean leti = false;
  boolean leti2 = false;

  float brdr = 30.0;

  Arrow(){
    acc = new PVector(0,0);
    vel = new PVector(0,0);

    ready = false;
  }


  void shoot(PVector _pos,PVector _dir){

    pos = new PVector(_pos.x,_pos.y);
    lpos = new PVector(_pos.x,_pos.y);

    acc = new PVector(_dir.x/10.0,_dir.y/10.0);
    ready = true;
    leti2 = leti = true;

  }

  void border(){
    if(pos.y>height-brdr){
      leti = false;
      lpos.y += height-brdr-pos.y;
      pos.y = height-brdr;
    }

  }

  void draw(){

    border();

    if(leti2 && !leti){
      vel = new PVector(0,0);
      acc = new PVector(0,0);
      //gravity = new PVector(0,0);

    }else if(leti){
      lpos = new PVector(pos.x,pos.y);


      vel.add(acc);
      acc.mult(0.1);
      vel.mult(friction);
      acc.add(gravity);
    }
    pos.add(vel);
    if(leti){

      strokeWeight(1);
      stroke(255,40);
      line(pos.x,pos.y,lpos.x,lpos.y);
      stroke(255,140);
      strokeWeight(1);
      line(pos.x,pos.y,lerp(pos.x,lpos.x,0.5),lerp(pos.y,lpos.y,0.5));
    }
    stroke(255);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(atan2(pos.y-lpos.y,pos.x-lpos.x));
    line(-5,0,5,0);
    popMatrix();



    leti2 = leti;

    if(dist(hero.pos.x,hero.pos.y,pos.x,pos.y)>20000)
      arrows.remove(this);
    strokeWeight(1);
    //stroke(255,25);
    //line(hero.pos.x,hero.pos.y,pos.x,pos.y);
  }


}


class Target{
  PVector pos,vel,acc;

  float radius;
  float speed;
  boolean falling = false;


  Target(){
    radius = random(20,120);
    pos = new PVector(-radius,random(0,height/2));
    vel = new PVector(random(10,80)/radius,0);
    acc = new PVector(0,0);
  }

  void draw(){
    move();


    noStroke();
    fill(255);

    ellipse(pos.x,pos.y,radius,radius);

    if(pos.x > width+radius*2)
      targets.remove(this);
  }

  void move(){

    pos.add(vel);
    vel.add(acc);

    vel.mult(friction);
    hitDetect();



    if(falling){
      vel.add(gravity);
    }
    acc.mult(0.2);




  }

  void hitDetect(){

    for(int i = 0 ; i< arrows.size();i++){
      Arrow tmp = (Arrow)arrows.get(i);
      if(tmp.leti){

        if(dist(tmp.pos.x,tmp.pos.y,pos.x,pos.y)<radius/2){
          PVector hit = new PVector(tmp.vel.x,tmp.vel.y);
          hit.mult(20.0 / (radius));
          acc.add(hit);

          falling = true;
        }
      }
    }

  }


}
