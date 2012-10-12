Machine machine[];
int num = 10;

void setup(){

  size(640,480,P2D);


  machine = new Machine[num];

  for(int i = 0 ; i < num;i++)
machine[i] = new Machine(i);

  imageMode(CENTER);

}

void draw(){
  background(255);

  for(int i = 0 ; i < num;i++)
  machine[i].draw();

  //smooth();
}

class Machine{
  PImage body;
  PVector pos;
  PVector acc;
  int id;

  Machine(int _id){
    id = _id;
    pos = new PVector(width/2,height/2);
    acc = new PVector(0,0);
    body = loadImage("body.png");
  }

  void draw(){

    float d = 3/(dist(pos.x,pos.y,mouseX,mouseY)+11);
    acc.add(new PVector(mouseX-pos.x,mouseY-pos.y));
    acc.mult(d/id);
    pos.add(acc);

    pushMatrix();
    translate(pos.x,pos.y);

    rotate(atan2(acc.y,acc.x)+HALF_PI+d*100.0);

    image(body,0,0,body.width/4,body.height/4);
    popMatrix();
  }
}
