void oneGUI() {
  int y = ctlskip*2;

  cp5.addSlider("barevnost")
    .setRange(0, 255)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(one)
            ;
  y+=ctlskip;


  cp5.addSlider("aspeed")
    .setRange(1.1, 1200.0)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(one)
            ;
  y+=ctlskip;

  cp5.addSlider("bspeed")
    .setRange(1.1, 1200.0)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(one)
            ;
  y+=ctlskip;

  cp5.addSlider("cspeed")
    .setRange(1.1, 1200.0)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(one)
            ;
  y+=ctlskip;



  cp5.addSlider("aratio")
    .setRange(1.1, 1200.0)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(one)
            ;
  y+=ctlskip;

  cp5.addSlider("bratio")
    .setRange(1.1, 1200.0)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(one)
            ;
  y+=ctlskip;

  cp5.addSlider("cratio")
    .setRange(1.1, 1200.0)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(one)
            ;
  y+=ctlskip;

  cp5.addSlider("invcycle")
    .setRange(1, 100)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(one)
            ;
  y+=ctlskip;


  cp5.addSlider("tras")
    .setRange(0, 300)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(one)
            ;
  y+=ctlskip;

  cp5.addSlider("tras2")
    .setRange(0, 300)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(one)
            ;
  y+=ctlskip;


  cp5.addSlider("objectalpha")
    .setRange(0, 255)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(one)
            ;
  y+=ctlskip;

  cp5.addSlider("rotatespeed")
    .setRange(1000, 0.01)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(one)
            ;
  y+=ctlskip;

  cp5.addSlider("alphas[0]")
    .setRange(10000, 1)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(one)
            ;
  y+=ctlskip;
}


//////////////////// ONE //////////////

int ctlskip = 15;

float lineSpeed = 50;
float barevnost = 0;
float aspeed = 120.0;
float bspeed = 101.0;
float cspeed = 100.0;

float aratio = 1.0;
float bratio = 1.0;
float cratio = 1.0;

int invcycle = 120;

float tras = 10.0;
float tras2 = 0;

float objectalpha = 0;
float rotatespeed = 10000.0;




/////////////////////////////////

void one() {


  background(0);




  if (frameCount%invcycle==0)
    inv=!inv;

  pushMatrix();
  translate((noise(millis()/100.0, 0)-.5)*tras, (noise(0, millis()/100.0)-.5)*tras);
  if (inv) {
    scale(1, -1);
    translate(0, -height);
  }


  noStroke();
  fill(255);


  for (int i = 0 ; i < height;i++) {
    float a = (sin(millis()/(i/aratio*aspeed))+1.0)*127.0;
    float b = (sin(millis()/(i/bratio*bspeed))+1.0)*barevnost;
    float c = (sin(millis()/(i/cratio*cspeed))+1.0)*127.0;

    if (inv) {
      stroke(a, b, c);
    }
    else {
      stroke(a, b, c );
    }

    //if (i%( 152-(((int)(frameCount/lineSpeed))%150+1) )==0)
    line(0, i, width, i);
  }

  popMatrix();

  pushMatrix();
  noStroke();
  fill(0, objectalpha);
  translate(width/2, height/2);
  translate((noise(millis()/70.0, 0)-.5)*tras2, (noise(0, millis()/70.0)-.5)*tras2);

  rotate(millis()/rotatespeed);
  rect(0, 0, 300, 300);
  popMatrix();
}

