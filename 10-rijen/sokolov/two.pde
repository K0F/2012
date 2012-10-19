void twoGUI() {
  int y = ctlskip*2;

  cp5.addSlider("w")
    .setRange(7, 300)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(two)
            ;
  y+=ctlskip;

  cp5.addSlider("h")
    .setRange(7, 300)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(two)
            ;
  y+=ctlskip;


  cp5.addSlider("speed")
    .setRange(2, 200)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(two)
            ;
  y+=ctlskip;

  cp5.addSlider("ammp")
    .setRange(5, 3000)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(two)
            ;
  y+=ctlskip;

  cp5.addSlider("cycle")
    .setRange(1, 3000)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(two)
            ;
  y+=ctlskip;
}
/////////////////////////
float w = 12.86;
float h = 31.9;

float speed = 200;
float cycle = 60.0;
float ammp= 5.0;


boolean inverse = true;
/////////////////////////

void two() {
  background(inverse?0:255);
  noStroke();

  int cnt = 0;
  for (float x = w ;x<width ;x+=w) {
    for (float y = (int)(-ammp) ;y<height + ammp;y+=h*2) {

      float shift = sin(x/cycle +frameCount / speed)*ammp;
      fill(inverse?255:0);
      rect(x, y+shift, w-1, h);
    }
    //stroke(0);
    // line(x, 0, x, height);
  }
}

