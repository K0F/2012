/* Route planning by kof 12
*/


ArrayList travellers;
int num = 10;
float res = 3.0;
float SPEED = 0.75;
float TIGHT = 2.001;


void setup() {
  size(512, 512, P2D); 

  textFont(loadFont("65Amagasaki-8.vlw"));
  textMode(SCREEN);
  
  travellers = new ArrayList();

  for (int i = 0 ; i < num ; i ++) {
    travellers.add(new Traveller(random(width), random(height), i));
  }
}

void draw() {
  background(0);


  for (int i = 0 ; i < travellers.size();i++) {
    Traveller tmp = (Traveller)travellers.get(i);
    tmp.draw();
  }
}

void mousePressed() {
  for (int i = 0 ; i < travellers.size();i++) {
    Traveller tmp = (Traveller)travellers.get(i);
    tmp.randomDest();
  }
}

