// intersection processor
ArrayList ps;

float speed = 0.6;
int num = 6;

PGraphics canvas;

void setup(){
  size(320,320);


  canvas = createGraphics(width,height,P2D);
  canvas.beginDraw();
  canvas.smooth();
  canvas.background(255);
  canvas.endDraw();


  ps = new ArrayList();

  for(int i =0 ; i < num; i++){
    ps.add(new Segment(i));

  }

}


class Segment{
  PVector a,b;
  PVector vel_a,vel_b;
  int id;
  boolean out = false;

  Segment(int _id){

    id = _id;

    a = new PVector(random(width),random(height));
    b = new PVector(random(width),random(height));

    vel_a = new PVector(random(-speed,speed),random(-speed,speed));
    vel_b = new PVector(random(-speed,speed),random(-speed,speed));


  }

  void move(){

    a.add(vel_a);
    b.add(vel_b);

    border();

    /*
       a.x += (random(width)-a.x)/speed;
       a.y += (random(height)-a.y)/speed;
       b.x += (random(width)-b.x)/speed;
       b.y += (random(height)-b.y)/speed;
     */
  }


  void border(){

    if(a.x<0||a.x>width)vel_a.x *= -1;
    if(b.x<0||b.x>width)vel_b.x *= -1;

    if(a.y<0||a.y>height)vel_a.y *= -1;
    if(b.y<0||b.y>height)vel_b.y *= -1;



  }
}


void draw(){

  background(canvas);

  for(int i = 0 ; i < ps.size();i++){
    Segment one = (Segment)ps.get(i);

    one.move();
    one.out = false;
  }


  for(int i = 0 ; i < ps.size();i++){

    Segment one = (Segment)ps.get(i);


    //    if(!one.out){

    for(int q = 0 ; q < ps.size();q++){
      Segment two = (Segment)ps.get(q);

      if(q!=i && !two.out){


        if(intersect(one.a.x,one.a.y,one.b.x,one.b.y,two.a.x,two.a.y,two.b.x,two.b.y)){
          one.out = true;
          two.out = true;
        }
      }
    }
    //  }
  }


  for(int i = 0 ; i < ps.size();i++){
    Segment one = (Segment)ps.get(i);

    if(!one.out)
    {

      canvas.beginDraw();
      canvas.stroke(0,15);
      canvas.line(one.a.x,one.a.y,one.b.x,one.b.y);
      canvas.endDraw();
    }else{


      stroke(0,35);
      line(one.a.x,one.a.y,one.b.x,one.b.y);
    }
  }




  //stroke(intersect(a1.x,a1.y,a2.x,a2.y,b1.x,b1.y,b2.x,b2.y)?#ff0000:0);

  //line(a1.x,a1.y,a2.x,a2.y);
  //line(b1.x,b1.y,b2.x,b2.y);


}


boolean IsOnSegment(float xi, float yi, float xj, float yj,
    float xk, float yk) {
  return (xi <= xk || xj <= xk) && (xk <= xi || xk <= xj) &&
    (yi <= yk || yj <= yk) && (yk <= yi || yk <= yj);
}

int ComputeDirection(float xi, float yi, float xj, float yj,
    float xk, float yk) {
  float a = (xk - xi) * (yj - yi);
  float b = (xj - xi) * (yk - yi);
  return a < b ? -1 : a > b ? 1 : 0;
}

/** Do line segments (x1, y1)--(x2, y2) and (x3, y3)--(x4, y4) intersect? */
boolean intersect(float x1, float y1, float x2, float y2,
    float x3, float y3, float x4, float y4) {
  int d1 = ComputeDirection(x3, y3, x4, y4, x1, y1);
  int d2 = ComputeDirection(x3, y3, x4, y4, x2, y2);
  int d3 = ComputeDirection(x1, y1, x2, y2, x3, y3);
  int d4 = ComputeDirection(x1, y1, x2, y2, x4, y4);
  return (((d1 > 0 && d2 < 0) || (d1 < 0 && d2 > 0)) &&
      ((d3 > 0 && d4 < 0) || (d3 < 0 && d4 > 0))) ||
    (d1 == 0 && IsOnSegment(x3, y3, x4, y4, x1, y1)) ||
    (d2 == 0 && IsOnSegment(x3, y3, x4, y4, x2, y2)) ||
    (d3 == 0 && IsOnSegment(x1, y1, x2, y2, x3, y3)) ||
    (d4 == 0 && IsOnSegment(x1, y1, x2, y2, x4, y4));
}
