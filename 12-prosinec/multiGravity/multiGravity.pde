float ATT_FORCE = 15.0;
ArrayList p;
int TAIL_LENGTH = 133;
float FRICTION =  0.006;
float FOLLOW_SPEED = 30.0;

int C_TRAIL_LENGTH = 3000;
float sx, sy;


PVector center, scenter;
ArrayList centrail;
float zoom = 1.0;
float ratio = 1.0;
float l, r, t, b;

Field field;

PImage bck;

void setup() {
  size(600, 600, P2D);

  bck = loadImage("bck.png");

  center = new PVector(0, 0);
  scenter = new PVector(0, 0);
  centrail = new ArrayList();
  p = new ArrayList();

  field = new Field();

  for (int i = 0 ; i < 3;i++)
    p.add(new Particle(random(width), random(height)));
}


void draw() {
  background(bck);

  //optional force field (undone)
  // field.draw();



  scenter.x += (center.x-scenter.x) / FOLLOW_SPEED;
  scenter.y += (center.y-scenter.y) / FOLLOW_SPEED;

  pushMatrix();

  translate(-scenter.x+width/2, -scenter.y+height/2);




  noFill();
  stroke(#ff1100);



  for (int i = 1 ; i < centrail.size();i++) {
    PVector tmp1 = (PVector)centrail.get(i-1);
    PVector tmp2 = (PVector)centrail.get(i);

    //strokeWeight(map(i, 0, centrail.size(), 1, 5));
    stroke(#ff1100, map(i, 0, centrail.size(), 5, 90));
    line(tmp1.x, tmp1.y, tmp2.x, tmp2.y);
  }

  // strokeWeight(1);
  fill(#ff1100);
  //ellipse((l+sx/2.0), (t+sy/2.0), 10, 10);
  ellipse(center.x, center.y, 5, 5);

  noFill();


  l = t = 10000.0;
  r = b = -10000.0;

  /*
  if (p.size()>2) {
   
   //zoom += ((1.0/ratio)-zoom)/ 100.0;
   zoom = ratio;
   scale(1.0/ratio+1.0);
   }
   */

  for (int i = 0 ; i < p.size();i++) {
    Particle tmp = (Particle)p.get(i);
    tmp.move();
  }

  for (int i = 0 ; i < p.size();i++) {
    Particle tmp = (Particle)p.get(i);
    tmp.drawTail();
  }

  for (int i = 0 ; i < p.size();i++) {
    Particle tmp = (Particle)p.get(i);
    tmp.draw();
  }

  sx = (r-l);
  sy = (b-t);

  if (sx > width || sy > height) {
    ratio = ((width/sx+1.0) / (height/sy+1.0))/2.0;//(1.0+norm(sx,0,width))/(width+0.0);
  }

  noFill();
  //stroke(#ffcc00);
  //rect(l, t, sx, sy);





  centrail.add(new PVector((center.x), (center.y)));

  if (centrail.size()>C_TRAIL_LENGTH)
    centrail.remove(0); 



  popMatrix();
}

void mousePressed() {
  if (mouseButton==LEFT) {
    p.add(new Particle());
  }
  else {
    if (p.size()>=1)
      p.remove(p.size()-1);
  }
}

class Particle {
  ArrayList tail;
  PVector rpos, pos, acc, vel;
  float R = 10;

  Particle() {
    pos = new PVector(mouseX+scenter.x-width/2, mouseY+scenter.y-height/2); 
    initialize();
  }

  Particle(float _x, float _y) {
    pos = new PVector(_x, _y);
    initialize();
  }

  void initialize() {
    acc = new PVector(0, 0);
    rpos = new PVector(0, 0); 
    vel = new PVector(mouseX-pmouseX, mouseY-pmouseY);
    tail = new ArrayList();
  }

  void move() {
    pos.add(vel);
    vel.add(acc);
    vel.mult(1.0/(FRICTION+1.0));

    acc = new PVector();

    for (int i = 0 ; i < p.size();i++) {
      if (i!=p.indexOf(this)) {
        Particle other = (Particle)p.get(i);
        float d = 1.0+dist(pos.x, pos.y, other.pos.x, other.pos.y);
        PVector dir = new PVector(other.pos.x-pos.x, other.pos.y-pos.y);
        dir.normalize();
        dir.mult(ATT_FORCE / pow(d, 0.95));


        acc.add(dir);
      }
    }


    center.x += (pos.x-center.x)/(p.size()+0.0);
    center.y += (pos.y-center.y)/(p.size()+0.0);

    tail.add(new PVector(pos.x, pos.y));

    if (tail.size()>TAIL_LENGTH)
      tail.remove(0);


    getDimm();
  }

  void deflect() {
    PVector dd = new PVector(sx, sy);
    dd.mult(0.0001);
    acc.sub(dd);
  }

  void getDimm() {
    l = min(pos.x, l);
    r = max(pos.x, r);
    t = min(pos.y, t);
    b = max(pos.y, b);
  }  


  void draw() {


    fill(0);
    noStroke();

    ellipse(pos.x, pos.y, R, R);
    rpos = new PVector(screenX(pos.x, pos.y), screenY(pos.x, pos.y));
  }

  void drawTail() {
    noFill();
    beginShape();
    for (int i = 0 ; i < tail.size();i++) {
      PVector tmp = (PVector)tail.get(i);
      // strokeWeight(map(i, 0, tail.size(), 1, r/2.0));
      stroke(0, map(i, 0, tail.size(), 0, 255));
      vertex(tmp.x, tmp.y);
    }
    endShape();
  }
}

