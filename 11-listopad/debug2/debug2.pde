


int pocet = 100;
Otacejici_se_box prvni[];

void setup() {
  size(320, 320, P3D);

  prvni = new Otacejici_se_box[pocet];
  
  for(int i = 0 ; i < prvni.length;i++){
   prvni[i] =  new Otacejici_se_box(random(0,width),random(0,height),random(0,width));
  }
}

void draw() {
  background(0);
  
 // prvni[2].pozice.x = frameCount%width;
 
  for(int i = 0 ; i < prvni.length;i++){
    prvni[i].kresli();
  
  }
}

class Otacejici_se_box {

  Bod pozice;
  color c = color(random(255),random(255),random(255));
  float rychlost;
  float velikost;
  float pruhlednost;
  
  Otacejici_se_box(float _x, float _y, float _z){
    pozice = new Bod(_x,_y,_z);
    
    rychlost = random(10,20);
    velikost = random(10,20);
    
    pruhlednost = 100;
  }

  void kresli() {
    stroke(c); 
    noFill();
    
    pushMatrix();
    translate(pozice.x, pozice.y, pozice.z);

    rotateX(frameCount/rychlost);
    rotateY(frameCount/rychlost);

    popMatrix();
    
  }
}


class Bod {
  float x;
  float y;
  float z;

  Bod(float _x, float _y, float _z) {
    x = _x;
    y = _y;
    z = _z;
  }
}

