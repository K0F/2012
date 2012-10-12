/**
 * shows how to set a specific easing (character of movment)
 * list of all easing styles below:
 *
 * Ani.LINEAR
 * Ani.QUAD_IN
 * Ani.QUAD_OUT
 * Ani.QUAD_IN_OUT
 * Ani.CUBIC_IN
 * Ani.CUBIC_IN_OUT
 * Ani.CUBIC_OUT
 * Ani.QUART_IN
 * Ani.QUART_OUT
 * Ani.QUART_IN_OUT
 * Ani.QUINT_IN
 * Ani.QUINT_OUT
 * Ani.QUINT_IN_OUT
 * Ani.SINE_IN
 * Ani.SINE_OUT
 * Ani.SINE_IN_OUT
 * Ani.CIRC_IN
 * Ani.CIRC_OUT
 * Ani.CIRC_IN_OUT
 * Ani.EXPO_IN
 * Ani.EXPO_OUT
 * Ani.EXPO_IN_OUT
 * Ani.BACK_IN
 * Ani.BACK_OUT
 * Ani.BACK_IN_OUT
 * Ani.BOUNCE_IN
 * Ani.BOUNCE_OUT
 * Ani.BOUNCE_IN_OUT
 * Ani.ELASTIC_IN
 * Ani.ELASTIC_OUT
 * Ani.ELASTIC_IN_OUT
 *
 * MOUSE
 * click           : set end position of the animations and trigger new one
 */
 
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
 
ArrayList entities = new ArrayList(0);
ArrayList solvers;
 
void setup() {
  size(1280,720,P2D);
  smooth();
  noStroke();
  
  solvers = new ArrayList();
  
  solvers.add(Ani.LINEAR);
  solvers.add(Ani.QUAD_IN);
  solvers.add(Ani.QUAD_OUT);
  solvers.add(Ani.QUAD_IN_OUT);
  solvers.add(Ani.CUBIC_IN);
  solvers.add(Ani.CUBIC_IN_OUT);
  solvers.add(Ani.CUBIC_OUT);
  solvers.add(Ani.QUART_IN);
  solvers.add(Ani.QUART_OUT);
  solvers.add(Ani.QUART_IN_OUT);
  solvers.add(Ani.QUINT_IN);
  solvers.add(Ani.QUINT_OUT);
  solvers.add(Ani.QUINT_IN_OUT);
  solvers.add(Ani.SINE_IN);
  solvers.add(Ani.SINE_OUT);
  solvers.add(Ani.SINE_IN_OUT);
  solvers.add(Ani.CIRC_IN);
  solvers.add(Ani.CIRC_OUT);
  solvers.add(Ani.CIRC_IN_OUT);
  solvers.add(Ani.EXPO_IN);
  solvers.add(Ani.EXPO_OUT);
  solvers.add(Ani.EXPO_IN_OUT);
  solvers.add(Ani.BACK_IN);
  solvers.add(Ani.BACK_OUT);
  solvers.add(Ani.BACK_IN_OUT);
  solvers.add(Ani.BOUNCE_IN);
  solvers.add(Ani.BOUNCE_OUT);
  solvers.add(Ani.BOUNCE_IN_OUT);
  solvers.add(Ani.ELASTIC_IN);
  solvers.add(Ani.ELASTIC_OUT);
  solvers.add(Ani.ELASTIC_IN_OUT);

 
for(int i =0;i<10;i++)
  entities.add(new Entit());
 
 
  strokeWeight(2);
 
  // you have to call always Ani.init() first!
  Ani.init(this);
  background(0);
 
 
  textFont(loadFont("SempliceRegular-8.vlw"));
  textMode(SCREEN);
}
 
void draw() {
 
 
  if(frameCount%2==0) {
    tint(12,128,255,5);
 
 
    image(g,noise(frameCount%5)*10-1.5,noise(frameCount%4)*4-.5);
  }
  else {
 
    tint(255,128,12,13);
    image(g,-noise(frameCount%6)*10+1.5,noise(frameCount%4)*4-.5);
  }
 
  for(int i = 0;i<entities.size();i++) {
    Entit tmp = (Entit)entities.get(i);
    tmp.update();
  }
   
 
 
/*
  pushStyle();
  strokeWeight(1);
  for(int i =0;i<10000;i++) {
    stroke(random(25),random(3,10));
    point(random(width),random(height));
  }
  popStyle();
*/
  pushStyle();
  strokeWeight(noise(frameCount%5)*10+3);
  noFill();
  stroke(0);
 
 
  rect(3,3,width-6,height-8);
 
  popStyle();
 
  pushStyle();
  fill(255);
  textAlign(RIGHT);
  text(round(millis()/1000.0),width-9,height-2);
  popStyle();
 
}
 
 
 
void mouseReleased() {
  entities.add(new Entit());
}

class Entit {
  float x = 256;
  float y = 256;
  float tx,ty;
  int diameter = 3;
  float lx,ly;
  float prum;
  int tahy = 2;
  color c;
  float speed = 1.0;
  int counter = 0;
   
  Easing A,B;
 
  int roz = 1;
 
 
  Entit() {
 
    A = (Easing)solvers.get((int)random(solvers.size()));
    B = (Easing)solvers.get((int)random(solvers.size()));
     
    ly=x=width/2;
    lx=y=height-10;
     
    tx=width/2;
    ty=height/2;
     
    
 
    prum = 1.1;
     
    speed = 2.0;//random(10,100)/500.0;
     
    c = color(random(255),random(255),random(255));
  }
 
  void update() {
    float len = dist(x,y,lx,ly);
 
    for(float f =0;f<len;f+=roz) {
      float tempx = lerp(lx,x,f/len);
      float tempy = lerp(ly,y,f/len);
 
 
 
      pushMatrix();
      translate(tempx,tempy);
      rotate(atan2(ly-y,lx-x));
      prum+=(dist(lx,ly,x,y)/2.0-prum)/30.0;
 
      stroke(255,200);
      line(0,-prum/8.0*speed,0,-prum/2*speed);
 
      stroke(c,200);
      line(0,prum/8.0*speed,0,prum/2*speed);
 
 
      popMatrix();
    }
 
    lx=x;
    ly=y;
     
     
    /*filter(BLUR,1.1);
      
     for(int y=0;y<width;y++) {
     for(int x=0;x<height;x++) {
     stroke(random(20),random(25));
     point(x,y);
     }
     }
      
     saveFrame("vid/blbost####.png");
     */
 
    if(dist(x,y,tx,ty)<10.0||counter==0) {
      tx=mouseX;//random(width);
      ty=mouseY;//random(height);
     // speed = 0.2;//random(10,100)/500.0;
      reach();
      counter++;
    }
  }
 
 
  void reach() {
    Ani.to(this, speed, "x", tx, A);
    Ani.to(this, speed, "y", ty, B);
  }
}


