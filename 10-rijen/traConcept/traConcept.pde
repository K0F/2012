
ArrayList t;
int num = 50;

void setup() {



  size(512, 512, P2D);
  t = new ArrayList();

  for (int i  =0 ; i < num;i++) {
    t.add(new Trans());
  }
}


void draw() {
  background(255);

  for (int i  =0 ; i < num;i++) {
    Trans tmp = (Trans)t.get(i);
    tmp.draw();
  }
}

class Trans {
  PVector start, end, pos;
  float r = 20;
  ArrayList trail;

  Trans() {
    reset();
  }

  void reset() {

    start = new PVector(random(width), random(height));
    end = new PVector(random(width), random(height));
    pos = new PVector(start.x, start.y);

    trail = new ArrayList();
    
    
  }

  void draw() {

    move();

    ellipse(pos.x, pos.y, r, r);

    for (int i = 0 ; i < trail.size();i++) {
      PVector bod = (PVector)trail.get(i);
      point(bod.x, bod.y);
    }

    trail.add(new PVector(pos.x, pos.y));
    
    if(trail.size()>100)
    trail.remove(0);
  }

  void move() {

    PVector toEnd = new PVector(end.x-pos.x, end.y-pos.y);
    toEnd.normalize();
    pos.add(toEnd);

    avoid();
  }

  void avoid() {

    for (int i = 0 ; i< t.size();i++) {

      Trans tmp = (Trans)t.get(i);

      if (tmp!=this) {
        float d = dist(tmp.pos.x, tmp.pos.y, pos.x, pos.y);
        
        if(d<r/2.0+tmp.r/2.0){
        pos.x -= (tmp.pos.x-pos.x)/(d/2.0);
        pos.y -= (tmp.pos.y-pos.y)/(d/2.0);
        }
      }
    }
  }
}

