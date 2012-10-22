/* @pjs font="65Amagasaki.ttf"; 
 */

ArrayList stetiny;
int num;
PImage fajfka;

void setup() {
  size(1024, 768);


  int a, b;
  a = (int)random(230920);
  b = (int)random(230920);

  fajfka = loadImage("pipe.png");

  PFont font = createFont("65 Amagasaki");
  textFont(font, 8, false);
  textAlign(CENTER, CENTER);

  stetiny = new ArrayList();


  num = 7;
  for (int i = 0 ; i < num ; i ++) {
    stetiny.add(new Stetina(i));
  }
}

void draw() {
  background(255);
  
  pushMatrix();
  
  translate(0,150);
  translate((noise(frameCount/10.0,0)-0.5)*10,(noise(0,frameCount/10.0)-0.5)*10);

  image(fajfka, width/2-175, height/2+7);

  for (int i = 0 ; i < num ; i ++) {
    Stetina tmp = (Stetina)stetiny.get(i);
    tmp.draw();
  }

  fill(0);

  
  
  popMatrix();
  
  fill(0,120 );
  text("You have entered a special place.\ncontact: krystof.pesek@gmail.com", width/2, height-30);
}

////////////////////////////////

class Stetina {
  PVector pos;
  int segnum;
  float seglen;
  float angle;

  float sp;
  int id;

  Stetina(int _id) {
    id = _id;

    pos = new PVector(width/2+id*2-num, height/2+15);
    segnum = (int)random(40, 90);
    seglen = 1.0;


    sp = random(120, 1000);
  }

  void draw() {


    angle = noise(millis()/(sp*100.0+id))/2.0;

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(radians(180));
    for (int i = 0 ; i < segnum;i++) {
      strokeWeight(map(i, 0, segnum, 10, 1));
      stroke(0, map(i, 0, segnum, 255, 0));

      float unique = noise((millis()+id*100.0+i*100.0)/1200.0 )*20.0;
      // stroke(0);//,unique*3.0);
      line(0, 0, 0, seglen*unique);

      translate(0, seglen*unique);
      rotate(angle*(noise((millis()+i*500.0+id*1000.0)/(sp*30.0))-0.5)*4.0);
    }


    popMatrix();
  }
}

