/*
 *    Yet antoher flocking sketch
 *    documented live
 *    kof 2012
 */



//////////////////////////////////////////

ArrayList entities;
PVector follow;

TTYParser parser;
Terminal terminal;

//////////////////////////////////////////
float fspeed = 1000.0;
int NUM = 40;
int TRAIL_LENGTH = 70;
float SLOW_DOWN_ACC = 0.8;
float LIMIT_VEL = 3.0;
float ATT_FORCE = 10000.0;
float SHAKE = 2;

int BEGIN_TIME;
float SPEED = 10;
//////////////////////////////////////////

void setup() {
  size(600, 320, P3D);

  entities = new ArrayList();

  for (int i = 0 ; i < NUM ; i++) {
    entities.add(new Entity());
  }

  smooth();

  follow = new PVector(0, 0, 0);

  textFont(loadFont("Monaco-10.vlw"));
  textMode(SCREEN);

  parser = new TTYParser("program.tty");
  terminal = new Terminal(80, 24);
}

//////////////////////////////////////////
void follow(Entity test) {
  follow.x += (test.pos.x-follow.x)/fspeed;
  follow.y += (test.pos.y-follow.y)/fspeed;
  follow.z += (test.pos.z-follow.z)/fspeed;
}


//////////////////////////////////////////
void shake() {
  float x = noise(frameCount/3.0, 0, 0)*SHAKE;
  float y = noise(0, frameCount/3.0, 0)*SHAKE;
  float z = noise(0, 0, frameCount/3.0)*SHAKE;

  translate(x, y, z);
}


//////////////////////////////////////////
void draw() {
  background(255);
  
  fill(0);
  for (int i = 0; i < parser.frames.size();i++) {
    DataFrame fr = (DataFrame)parser.frames.get(i);
    fr.update();
  }

  text(terminal.to_String(), 10, 20);
  //terminal.to_screen(10,20);

  pushMatrix();

  translate(width/2, height/2, 0);
  rotateY(frameCount/160.0);
  rotateX(frameCount/321.3);

  shake();

  for (int i = 0 ; i < entities.size();i++) {
    Entity e = (Entity)entities.get(i);
    pushMatrix();  
    follow(e);
    translate(-follow.x, -follow.y, -follow.z);
    e.draw();
    popMatrix();
  }

  popMatrix();
}


//////////////////////////////////////////
class Entity {
  PVector pos, vel, acc;
  ArrayList trail;

  Entity() {
    pos = new PVector(0, 0, 0);
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);

    trail = new ArrayList();
  }

  void move() {

    trail.add(new PVector(pos.x, pos.y, pos.z));

    if (trail.size() > TRAIL_LENGTH) {
      trail.remove(0);
    }


    pos.add(vel);
    vel.add(acc);
    acc.add(new PVector(random(-.1, .1), random(-.1, .1), random(-.1, .1)));

    vel.limit(LIMIT_VEL);
    acc.mult(SLOW_DOWN_ACC);
  }

  void attract() {

    int ranSel = (int)random(entities.size());

    Entity ran = (Entity)entities.get(ranSel);

    acc.x += (ran.pos.x - pos.x) / ATT_FORCE;
    acc.y += (ran.pos.y - pos.y) / ATT_FORCE;
    acc.z += (ran.pos.z - pos.z) / ATT_FORCE;
  }

  void draw() {
    move();
    attract();

    fill(0);
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    PVector lpos = (PVector)trail.get(trail.size()-1);

    // ! damn rotations ))
    rotateX(atan2(pos.y-lpos.y, pos.x-lpos.x));
    rotateY(atan2(pos.x-lpos.x, pos.z-lpos.z));
    rotateZ(atan2(pos.y-lpos.y, pos.z-lpos.z));


    box(5);
    popMatrix();

    noFill();
    beginShape();
    for (int i = 0 ; i < trail.size();i++) {
      PVector tmp = (PVector)trail.get(i);
      stroke(0, map(i, 0, trail.size(), 40, 255));
      strokeWeight(map(i, 0, trail.size(), 1, 5));
      vertex(tmp.x, tmp.y, tmp.z);
    }
    endShape();
  }
}

