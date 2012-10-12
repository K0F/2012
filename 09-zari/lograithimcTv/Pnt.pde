
/////////////////////// CLASS DEFINITION

class Pnt {
  PVector bpos, pos, vel, acc, forward, back;
  float d;
  color c;

  Pnt(PVector _pos) {
    c= 0;
    bpos = new PVector(_pos.x, _pos.y);
    pos = new PVector(_pos.x, _pos.y);

    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void draw() {

    stroke(c,200-d);//lerpColor(color(c), #ffcc00, norm(atan2(vel.y-acc.y, vel.x-vel.x), -PI, PI)), 200-d);
    if (d<200 && vel.mag()<30.0) {
      //strokeWeight(constrain(vel.mag()/20.0,1.1,2));
      point(pos.x, pos.y);
    }
  }

  /////////////////////// DYNAMICS MOVEMENT DESCRIPTION
  void update() {
    d = dist(bpos.x, bpos.y, X, Y);
    forward = new PVector(X-bpos.x, Y-bpos.y);
    acc.add(forward);

    float sp = dist(X, Y, pX, pY);
    acc.mult(30.123/(d+sp));

    back = new PVector(bpos.x-pos.x, bpos.y-pos.y);
    acc.add(back);
    acc.mult(1/(d+0.00001));
    vel.add(acc);
    pos.add(vel);

    vel.mult(0.99-1/(d+1.001));
    acc.limit(100.0);
    vel.limit(100.0);
  }
}


/////////////////////// MODIFY AS YOU NEED!

