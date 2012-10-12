
boolean render = true;

String name = "The Principle";
ArrayList c;

int num = 300;
float AL = 0;

boolean fadein = true;

int scene = 0;

void setup() {
  size(1280, 720, P2D);
  textFont(loadFont("Dialog.bold-12.vlw"));
  textAlign(CENTER, CENTER);
  textMode(SCREEN);

  frameRate(30);

  c = new ArrayList();
  

  smooth();
}

void addNew() {
  c.add(new Cycler());
}


void draw() {

  background(0);


  switch(scene) {
  case 0:
    fill(255,AL);
    text(name, width/2, height/2);
    
   // println(AL);
    
    if(AL>255){
     fadein = false; 
    }
    
    AL += fadein?3:-4;
    
    if(AL<0)
    scene = 1;
    
    break;
  case 1:
  addNew();
  scene = 2;
  break;
  case 2:
    for (int i = 0 ; i < c.size();i++) {
      Cycler tmp = (Cycler)c.get(i);
      tmp.draw();
    }

    break;
  }
  
  if(render)
  saveFrame("/home/kof/render/ThePrinciple/prin#####.tga");
}

class Cycler {

  float al;
  float cyc;
  float X, Y, R, A;
  float timer;

  boolean bang;

  Cycler() {
    timer = -cyc/2.0;
    R = random(15, 200);
    
    X = random(R,width-R);
    Y = random(R,height-R);
    A = random(360);
    al = 0;
    cyc = random(PI, 150.0);
  } 

  void draw() {

    al = (sin(timer/cyc)+1.0)*30;

    if (al<0.5) {

      if (bang) {
        bang = false;
        addNew();
      }

      // X = random(width);
      // Y = random(height);
   //   A = random(360);
    }
    else {
      bang = true;
    }

    A += (sin(frameCount/30.0)+1.0)*2.0;

    noFill();
    stroke(255, al);
    triangleR(X, Y, R);

    timer ++;
  }


  void triangleR(float x, float y, float r) {

    pushMatrix();
    beginShape();
    translate(x, y);
    rotate(radians(A));
    vertex(cos(radians(0))*r, sin(radians(0))*r);
    vertex(cos(radians(120))*r, sin(radians(120))*r);
    vertex(cos(radians(240))*r, sin(radians(240))*r);


    endShape(CLOSE);
    popMatrix();
  }
}

