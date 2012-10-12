Creature c;

void setup(){
  size(512,360,P2D);

  c = new Creature(10);

}


void draw(){
  background(0);
  c.draw();


}


class Creature{
  ArrayList bank;
  PVector pos;
  float r[];
  color c[];
  int pocet;

  Creature(int _pocet){
    pocet = _pocet;
    bank = new ArrayList();



    imageMode(CENTER);

    for(int i = 0 ; i < pocet;i++)
      bank.add(loadImage((int)random(1,5)+".png"));

    r = new float[bank.size()];
    c = new color[bank.size()];

    for(int i = 0; i < r.length;i++){
      r[i] = 0;
      c[i] = color(random(127,255),random(127,255),random(127,255));
    }
    pos = new PVector(width/2,height/2);
  }

  void draw(){
    for(int i =0 ; i < bank.size();i++){
      r[i] = noise(frameCount/300.0+i)*20.0;
      //c[i] = color(255,noise(frameCount/300.0+i)*255);
      PImage tmp = (PImage)bank.get(i);
      pushMatrix();
      translate(pos.x,pos.y);
      rotate(r[i]);
      tint(c[i],tan(noise(frameCount/30.0+i))*127.0);
      scale(0.25/(noise(frameCount/3000.0+i)*4.0));
      image(tmp,0,0);
      popMatrix();
    }
  }
}
