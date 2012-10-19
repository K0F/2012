
void threeGUI() {
  int y = ctlskip*2;

  cp5.addSlider("tresouci")
    .setRange(1, 300)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(three)
            ;
  y+=ctlskip;

  cp5.addSlider("speed1")
    .setRange(0.01, 20.0)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(three)
            ;
  y+=ctlskip;


  cp5.addSlider("speed2")
    .setRange(0.01, 10.0)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(three)
            ;
  y+=ctlskip;
}

PShape zebra, stripes[];

float speed1 = 80.0;
float speed2 = 30.0;
float tresouci = 300;


PGraphics buffer;


void setupThree() {


  buffer = createGraphics(800, 600, JAVA2D);
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

void three() {




  buffer.beginDraw();
  buffer.fill(0, 80);
  buffer.rect(0, 0, width, height);//background(22);
  buffer.pushMatrix();
  buffer.translate(100, -30);


  for (int i =0 ; i < stripes.length;i++) {

    buffer.strokeWeight(noise(frameCount/20.0)*50);
    buffer.stroke(0, 7);

    stripes[i].resetMatrix();
    stripes[i].translate((noise(frameCount/30.0+i/5.0, 0)-0.5)*tresouci, (noise(0, frameCount/30.0+i/5.0)-0.5)*tresouci);

    buffer.fill(255, noise(frameCount/speed1+i/speed2)*200);


    stripes[i].draw(buffer);
  }

  buffer.popMatrix();
  buffer.endDraw();

  image(buffer, 100, 100);
}

