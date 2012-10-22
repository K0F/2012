/*
 * Vassarely's Zebras
 *  kof,12
 *
 */

PShape zebra, stripes[];

float speed1 = 80.0;
float speed2 = 30.0;

float tras = 200.0;

PGraphics buffer;

void setup() {

  size(1024, 768, P2D);


  buffer = createGraphics(800,600, JAVA2D);
 // buffer.smooth();

  zebra=loadShape("zebry.svg");

  stripes = new PShape[zebra.getChildCount()];

  for (int i = 0 ; i < zebra.getChildCount();i++) {
    stripes[i] = zebra.getChild(i);
    stripes[i].disableStyle();
  }

  noStroke();
  smooth();

  colorMode(HSB);
  smooth();
  background(22);
}


void draw() {

background(0);

  buffer.beginDraw();
  buffer.fill(0, 80);
  buffer.rect(0, 0, width, height);//background(22);
  buffer.pushMatrix();
  buffer.translate(100, -30);


  for (int i =0 ; i < stripes.length;i++) {

    buffer.strokeWeight(noise(frameCount/20.0)*50);
    buffer.stroke(0, 7);

    stripes[i].resetMatrix();
    stripes[i].translate((noise(frameCount/30.0+i/5.0, 0)-0.5)*tras, (noise(0, frameCount/30.0+i/5.0)-0.5)*tras);

    buffer.fill(255, noise(frameCount/30.0+i/20.0)*200);


    stripes[i].draw(buffer);
  }

  buffer.popMatrix();
  buffer.endDraw();

  image(buffer, 100, 100);
}

