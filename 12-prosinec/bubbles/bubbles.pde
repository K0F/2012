int NUM = 25;
int CONN_PER_BUBBLE = 5;

ArrayList bubbles;

float R = 30;
float LINE_W = 10;
float D_FORCE = 80.0;
float BORDER = R/2.0+LINE_W;

float REST_STRENGHT = 4.0;
float REST_LENGTH = 100;

float TO_CENTER_FORCE = 0.005;
float KEEP_LENGTH_FORCE = 0.4;
float REPULSE_FORCE = 0.02;

float VISCOSITY = 0.92;
float SPEED_LIMIT= 3.0;

void setup() {
  size(800, 600, P2D);

  bubbles = new ArrayList();

  for (int i = 0 ; i < NUM ; i++) {
    bubbles.add(new Bubble());
  }

  for (int i = 0 ; i < bubbles.size() ; i++) {
    Bubble tmp = (Bubble)bubbles.get(i);
    tmp.makeConnections();
  }
  background(255);

}


void draw() {
  fill(255,90);
  noStroke();
  rect(0,0,width,height);
  

  
  for (int i = 0 ; i < bubbles.size() ; i++) {
    Bubble tmp = (Bubble)bubbles.get(i);
    tmp.draw();
  }
  
  
  
  
 
}


class Bubble {
  PVector pos, acc, vel;
  ArrayList connections;

  Bubble() {
    pos = new PVector(random(width), random(height));
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);

    connections = new ArrayList();
  }

  void makeConnections() {
    for (int i = 0 ; i < CONN_PER_BUBBLE;i++) {
      int sel = (int)random(bubbles.size());
      if (sel != bubbles.indexOf(this)) {
        Bubble tmp = (Bubble)bubbles.get(sel);
        boolean connected = false;

        for (int q = 0 ; q < tmp.connections.size();q++) {
          Connection c = (Connection)tmp.connections.get(q);
          if (c.b==this) {
            connected=true;
            break;
          }
        }

        if (!connected)
          connections.add(new Connection(this, tmp));
      }
    }
  }

  void move() {
    detract();
    keepLength();
    toCenter();
    
    
    acc.normalize();
    
    vel.add(acc);
    pos.add(vel);

    vel.mult(VISCOSITY);
    vel.limit(SPEED_LIMIT);
    
    pos.x = constrain(pos.x, BORDER, width-BORDER);
    pos.y = constrain(pos.y, BORDER, height-BORDER);
  }

  void toCenter() {
    acc.add(new PVector(width/2-pos.x, height/2-pos.y));
    acc.mult(TO_CENTER_FORCE);
  }

  void keepLength() {


    for (int i = 0 ; i < connections.size();i++) {
      Connection c = (Connection)connections.get(i);
      Bubble tmp = (Bubble)c.b;
      float d = dist(pos.x, pos.y, tmp.pos.x, tmp.pos.y);

      if (d < c.len - 10) {
        acc.add(new PVector((pos.x-tmp.pos.x), (pos.y-tmp.pos.y)));

      }
      else if (d > c.len + 10) {
        acc.add(new PVector((tmp.pos.x-pos.x), (tmp.pos.y-pos.y)));

      }
    }
    
     acc.mult(KEEP_LENGTH_FORCE);
  }

  void detract() {
    for (int i = 0 ; i < bubbles.size();i++) {
      if (i!=bubbles.indexOf(this)) {
        Bubble tmp = (Bubble)bubbles.get(i);
        acc.add(new PVector((pos.x-tmp.pos.x), (pos.y-tmp.pos.y)));
      }
    }
    
    acc.mult(REPULSE_FORCE);

  }

  Bubble getRandom() {
    int sel = (int)random(bubbles.size());
    Bubble tmp = (Bubble)bubbles.get(sel);
    return tmp;
  }

  void draw() {
    move();

    fill(0, 90);
    stroke(0, 40);
    strokeWeight(LINE_W);
    ellipse(pos.x, pos.y, R, R);


    stroke(0, 40);
    for (int i = 0 ; i < connections.size();i++) {
      Connection c = (Connection)connections.get(i);
      Bubble tmp = c.b;
      line(pos.x, pos.y, tmp.pos.x, tmp.pos.y);
    }
  }
}

class Connection {
  Bubble a, b;
  float len;

  Connection(Bubble _a, Bubble _b) {
    a=_a;
    b=_b;
    len = random(REST_LENGTH/2.0,REST_LENGTH*2.0);
  }
}

