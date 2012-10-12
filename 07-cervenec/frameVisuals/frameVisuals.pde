int script[] = {5,5,55};
Chronos partiture;
Scene scene;

float rot[] = new float[10];

void setup(){
  size(1920,1080,P2D);
  frameRate(100);
  partiture = new Chronos(script);
  scene = new Scene(partiture);

  for(int i = 0 ; i < rot.length;i++)
    rot[i] = 0;
}


void draw(){
  scene.draw();
  partiture.tick();
}


class Scene{
  Chronos p;

  Scene(Chronos _p){
    p = _p;
  }

  void draw(){
    switch(p.phase){
      case 0:
        zero();
        break;
      case 1:
        one();
        break;
      case 2:
        two();
        break;
      case 3:
        three();
        break;
      case 4:
        four();
        break;
      case 5:
        five();
        break;
      case 6:
        six();
        break;
      case 7:
        seven();
        break;
      case 8:
        eight();
        break;
      case 9:
        nine();
        break;
      default:
        none();
    }
  }

  void zero(){
    background(0);

    rectMode(CENTER);
    fill(255);
    noStroke();

    translate(width/2,height/2);
    rotate(radians(rot[0]));
    rect(0,0,200,200);
    rot[0]+=1.21377;

  }

  void one(){
    background(255);

    rectMode(CENTER);
    fill(0);
    noStroke();
    float m = random(-10,10);

    translate(width/2,height/2);
    rotate(radians(rot[1]));
    rect(0,0,200,200);

    rot[1]+=1;

  }

  void two(){
    background(#000fff);

    rectMode(CENTER);
    fill(#ff0000);
    noStroke();
    float m = random(-10,10);

    translate(width/2,height/2);
    rotate(radians(rot[2]));
    rect(0,0,200,200);
   
        rot[2]+=10;


  }

  void three(){

  }

  void four(){

  }

  void five(){

  }


  void six(){

  }

  void seven(){

  }

  void eight(){

  }

  void nine(){

  }

  void none(){

  }

}


class Chronos{
  int scheme[];
  int phase = 0;

  int counter = 0;

  Chronos(int [] _scheme){
    scheme = new int[_scheme.length];
    for(int i = 0; i<scheme.length;i++)
      scheme[i] = _scheme[i];
  }

  void tick(){
    if(counter%scheme[phase]==0){
      counter = 0;
      phase ++;

      if(phase>=scheme.length)
        phase = 0;
    }
    counter++;
  }
}
