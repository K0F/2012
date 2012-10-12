Processor processor;


void setup() {
  size(800, 100, P2D);
  processor = new Processor(140);  
  textFont(createFont("Semplice Regular", 8, false));
  textMode(SCREEN);
}

void draw() {
  background(0);
  processor.step();
  processor.plot();
}

