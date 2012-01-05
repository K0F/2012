Parser parser;
PFont font;

Brain brain;

void setup() {
  size(512, 512, P3D);
  parser = new Parser("skeleton.bvh");
  
  brain = new Brain(128,1);

  font = loadFont("SempliceRegular-8.vlw");
  textFont(font);
  textMode(SCREEN);
  
  noiseSeed(19);

  noSmooth();
}

void draw() {

  background(255);
  
  brain.draw(64,64);
  
  fill(255);
  strokeWeight(25);
  directionalLight(255, 255, 200, 0, 0, -300);

  pushMatrix();

  noStroke();
  parser.drawHieratical(); 

  stroke(0);
  parser.draw();
  
  popMatrix();
  
  
  
}

