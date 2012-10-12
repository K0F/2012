

float tras = 10.0;

Kuloid k;

void setup(){

  size(1024,768,P2D);

  k = new Kuloid(1833);

}


void draw(){

  background(0);


  k.draw();

}


class P{

  PVector pos;
  PVector acc;
  PVector vel;

  ArrayList trail;

  int trailLen = 50;

  P(){
    pos = new PVector(random(-width/2,width/2),random(-width/2,width/2),random(-width/2,width/2));
    acc = new PVector(random(-1,1),random(-1,1),0);
    vel = new PVector(0,0,0);

    trail = new ArrayList();
  }


  void draw(){
    fill(255);
    noStroke();

    pushMatrix();
    translate(pos.x,pos.y);
    ellipse(0,0,10,10);
    popMatrix();

    trail.add(new PVector(pos.x,pos.y));

    if(trail.size()>trailLen){
      trail.remove(0);
    }

    
    stroke(255,50);
    for(int i = 1 ; i < trail.size();i++){

      PVector a = (PVector)trail.get(i-1);
        PVector b = (PVector)trail.get(i);

        if(abs(a.x-b.x)+abs(a.y-b.y)<100){
        
          stroke(255,map(i,0,trailLen,0,50));
          line(a.x,a.y,b.x,b.y);

        }

    }
  }

  void border(){
    if(pos.x>width)pos.x = -width;
    if(pos.x<-width)pos.x = width;

    if(pos.y>width)pos.y = -width;
    if(pos.y<-width)pos.y = width;

   if(pos.z>width)pos.z = -width;
    if(pos.z<-width)pos.z = width;

 }



}



class Kuloid{

  ArrayList ps;
  int num;
  float maxSpeed = 5;

  Kuloid(int _num){

    num = _num;
    ps = new ArrayList();


    for(int i = 0 ; i < num;i++)
      ps.add(new P());

  }

  void draw(){
  translate(width/2+(noise(0,frameCount)-0.5)*tras,height/2+(noise(frameCount,0)-0.5)*tras);
    
    for(int i = 0 ; i < num;i++)
    {
      P tmp = (P)ps.get(i);
      
      P tmp2 = (P)ps.get((int)random(num));
      P tmp3 = (P)ps.get((int)random(num));

/*
      if(random(800)<3){
      tmp.pos.x += (tmp2.pos.x-tmp.pos.x)/(noise((frameCount+i)/100.0,0)*30.0);
      tmp.pos.y += (tmp2.pos.y-tmp.pos.y)/(noise((frameCount+i)/100.0,0)*30.0);

      tmp.pos.x -= (tmp3.pos.x-tmp.pos.x)/(noise(0,(frameCount+i)/120.0)*3000.0);
      tmp.pos.y -= (tmp3.pos.y-tmp.pos.y)/(noise(0,(frameCount+i)/120.0)*3000.0);
      }
*/
      tmp.acc.x += (tmp2.acc.x-tmp.acc.x)/(noise((frameCount+i)/100.0,0)*30.0);
      tmp.acc.y += (tmp2.acc.y-tmp.acc.y)/(noise((frameCount+i)/100.0,0)*30.0);

      tmp.acc.x -= (tmp3.acc.x-tmp.acc.x)/(noise(0,(frameCount+i)/100.0)*30.0);
      tmp.acc.y -= (tmp3.acc.y-tmp.acc.y)/(noise(0,(frameCount+i)/100.0)*30.0);

     // tmp.acc.add(new PVector(-tmp2.pos.x,-tmp2.pos.y));


      tmp.vel.add(tmp.acc);
      tmp.vel.limit(maxSpeed);
      tmp.pos.add(tmp.vel);
      //tmp.pos.add(tmp2.acc);
      //tmp.pos.sub(tmp3.acc);

      tmp.border();

      tmp.draw();
    }
  }

}
