
int num = 300;
Hexagon hex[];

void setup(){
  size(1280,720,P2D);

  background(0);


  hex = new Hexagon[num];


  for(int i = 0 ; i < num;i++){
    hex[i] = new Hexagon(random(width),random(height),i);
  }
}


void draw(){

  //background(0);


  fill(0,15);
  rect(0,0,width,height);

  for(int i = 0 ; i < num;i++){
    hex[i].draw();
  }

}

class Hexagon{

  PVector pos,spos;
  float rot;

  float speed = 0.1;

  float r = 90;
  float repulse;

  float smooth = 30.0;

  int id;

  Hexagon(float _x,float _y,int _id){

    id = _id;
    pos = new PVector(_x,_y);
    spos = new PVector(_x,_y);
    rot = 0;
    speed = random(-100,100)/1000.0;

    r = random(25,120);

    repulse = 10000000.0 / r;
  }


  void draw(){


    rot+=speed;

    spos.x += (pos.x-spos.x)/smooth;
    spos.y += (pos.y-spos.y)/smooth;

    pushMatrix();
    translate(spos.x,spos.y);
    rotate(rot);
    hexagon();
    popMatrix();


    pulse();

    attract();
    repulse();
    border();
  }

  void pulse(){
    r = sin((frameCount+id)/30.0)*100.0;

  }

  void repulse(){
    for(int i = 0 ; i < hex.length;i++){
      if(hex[i]!=this && random(1000)<80 ){
        float d = dist(pos.x,pos.y,hex[i].pos.x,hex[i].pos.y)*abs(rot-hex[i].rot); 

        d = constrain(d,1.1,width);
        pos.x -= (hex[i].pos.x-pos.x)/(d*r);
        pos.y -= (hex[i].pos.y-pos.y)/(d*r);

      }

    }

  }

  void attract(){
    for(int i = 0 ; i < hex.length;i++){
      if(hex[i]!=this && random(10000)<3 ){
        float d = dist(pos.x,pos.y,hex[i].pos.x,hex[i].pos.y)*abs(rot-hex[i].rot)/100000.0; 


        d = constrain(d,1.1,width);
        pos.x += (hex[i].pos.x-pos.x)/(d*r);
        pos.y += (hex[i].pos.y-pos.y)/(d*r);

        // stroke(255,255,0,45);
        // line(spos.x,spos.y,hex[i].spos.x,hex[i].spos.y);

      }

    }

  }
  void border(){

    if(pos.x>width)pos.x=width;
    if(pos.x<0)pos.x=0;

    if(pos.y>height)pos.y=height;
    if(pos.y<0)pos.y=0;
  }

  void hexagon(){

    noFill();
    stroke(255,35);


    beginShape();
    for(int i = 0 ;i < 360;i += 60){

      float x = cos(radians(i))*r;
      float y = sin(radians(i))*r;

      vertex(x,y);

    }
    endShape(CLOSE);


  }


}
