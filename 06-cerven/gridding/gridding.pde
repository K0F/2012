Hero hero;

void setup(){
  size(720,350,P2D);
  hero = new Hero(width/2,height/2);
}



void draw(){

  background(hero.inverse?0:255);
  hero.draw();


}

class Hero{

  ArrayList <PVector> trail;
  int trail_size = 500;

  float r;
  PVector acc;
  PVector pos;
  PVector vel;

  float bounce = 0.867;
  float friction = 0.996;
  float gravity = 0.0;
  float control = 0.15;

  boolean inverse = true;
  boolean bang = false;
  int fadeout = 0 ;
  boolean left,right,down,up;

  Hero(float _x,float _y){
    pos = new PVector(_x,_y);
    acc = new PVector(0,0);
    vel = new PVector(0,0);
    r = 20.0;

    trail = new ArrayList<PVector>();
    trail.add(new PVector(pos.x,pos.y));
  }

  void draw(){
    gravity();
    move();
    trail();


    fill(inverse?255:0);

    noStroke();
    ellipse(pos.x,pos.y,r-abs(vel.y)/3.0,r-abs(vel.x)/3.0);


  }

  void trail(){
    trail.add(new PVector(pos.x,pos.y));
    noFill();

    for(int i = 1 ; i < trail.size();i++){
    PVector t1 = (PVector)trail.get(i);
    PVector t2 = (PVector)trail.get(i-1);
    
    stroke(inverse?255:0,map(i,0,trail.size(),0,20));
    strokeWeight(map(i,0,trail.size(),0,r/2.0));    
    line(t1.x,t1.y,t2.x,t2.y);
    }

    if(trail.size() > trail_size)
      trail.remove(0);

  }

  void invert(){
    //inverse = !inverse;
  }

  void gravity(){
    pos.add(vel);
    vel.add(acc);
    acc.add(new PVector(0,gravity));
    //acc.limit(1.0);
    //vel.limit(15.0);
    acc.mult(0.8);

    vel.mult(friction);

    border();
  }

  void border(){

    if(pos.x+r/2.0 > width || pos.x - r/2.0 < 0){
      vel.x *= -1 * bounce;
      acc.x *= -1 * bounce;

      invert();
    }

    if(pos.y+r/2.0 > height || pos.y - r/2.0<0){
      vel.y *= -1 * bounce;
      acc.y *= -1 * bounce;

      invert();
    }

    if(pos.x-r/2.0 < 0)
      pos.x = r/2.0;

    if(pos.x+r/2.0 > width)
      pos.x = width-r/2.0;

    if(pos.y-r/2.0 < 0)
      pos.y = r/2.0;

    if(pos.y+r/2.0 > height)
      pos.y = height-r/2.0;

  }

  void move(){


    if(left)
      acc.add(new PVector(-control/(vel.mag()/4.0+1.0),0));

    if(right)
      acc.add(new PVector(control/(vel.mag()/4.0+1.0),0));

    if(down)
      acc.add(new PVector(0,control/(vel.mag()/4.0+1.0)));

    if(up)
      acc.add(new PVector(0,-control/(vel.mag()/4.0+1.0)));

  acc.limit(2);

}



}

void keyPressed(){
  switch(keyCode){
    case LEFT:
      hero.left = true;
      break;
    case RIGHT:
      hero.right = true;
      break;
    case DOWN:
      hero.down = true;
      break;
    case UP:
      hero.up = true;

  }
}

void keyReleased(){
  switch(keyCode){
    case LEFT:
      hero.left = false;
      break;
    case RIGHT:
      hero.right = false;
      break;
    case DOWN:
      hero.down = false;
      break;
    case UP:
      hero.up = false;

  }
}
