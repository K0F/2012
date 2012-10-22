void sixGUI() {
  int y = ctlskip*2;

  cp5.addSlider("strokeW")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;


  cp5.addSlider("trasSix")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;


  cp5.addSlider("pulseSpeed")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;

  cp5.addSlider("bright")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip*2;

  ///////////////////


  cp5.addSlider("amt")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;

  cp5.addSlider("sixSpeed")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;


  cp5.addSlider("krize")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;


  cp5.addSlider("effect")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;


  cp5.addSlider("sixAlpha")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;


  cp5.addSlider("flicking")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip*2;

  ///////////////

  cp5.addSlider("redAmt")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;


  cp5.addSlider("greenAmt")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;

  cp5.addSlider("bodyAlph")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;


  cp5.addSlider("al1")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;


  cp5.addSlider("al2")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;


  cp5.addSlider("elipsaFill")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;


  cp5.addSlider("elipsaAl")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;


  cp5.addSlider("sixAlpha2")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;


  cp5.addSlider("sixAlpha3")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;

  cp5.addSlider("sides")
    .setRange(1, 128)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(six)
            ;
  y+=ctlskip;
}

void preset() {


  ctl[1][33] = 0;
  ctl[1][34] = 14;
  ctl[1][35] = 2;
  ctl[1][46] = 6;


  ///////////////////////

  ctl[2][33] = 0;
  ctl[2][34] = 1;
  ctl[2][35] = 127; 

  ctl[2][46]=116;

  ctl[2][39] = 0;
  ctl[2][27] = 70;


  ////////////////////////

  ctl[3][33] = 127;
  ctl[3][34] = 127;
  ctl[3][35] = 127;

  //////////////////////

  ctl[4][33] = 0;
  ctl[4][34] = 0;
  ctl[4][35] = 0;
  ctl[4][46] = 2;


  ctl[4][27] = 127;

  ctl[4][7] = 40;

  //alpha react lines
  ctl[4][22] = 0;
}

void setupSix() {


  ///////////////////
  //podklad = loadImage("people.jpg");

  p = new ArrayList();

  loadPoints();



  //////////////

  tiny = loadFont("65Amagasaki-8.vlw");
  figurative = loadFont("CharisSIL-BoldItalic-48.vlw");
  textMode(SCREEN);

  cx = width/2;
  cy = height/2;

  minim = new Minim(this);

  //  jingle = minim.loadFile("siteUnseen.mp3", 2048);
  vals = new float[1025];
  //jingle.play();

  in = minim.getLineIn(Minim.STEREO, 1024);


  //get an instance of MidiIO

  preset();


  /////////////////////////// three /////////////////

  fft = new FFT(in.bufferSize(), in.sampleRate());

  rots = new float[in.bufferSize()];


  rotsX = new float[in.bufferSize()];
  rotsY = new float[in.bufferSize()];
  rotsZ = new float[in.bufferSize()];


  /////////// four /////////////////////////////////

  shaper = new Shaper(40);

  background(0);
}



/////////////////////////////// CTLS



float amt = 12;
int krize = 30;
int sixSpeed = 128;
float sixAlpha = 0;
float pulseSpeed = 14;
float bright = 0;
float effect = 0;
float sixpha = 0;
float flicking = 127;
float redAmt = 90;
float greenAmt = 90;
float bodyAlpha = 0;
float al1 = 127;
float al2 = 127;
float elipsaFill = 0;
float elipsaAl = 0;

float sixAlpha2 = 0;
float sixAlpha3 = 0;






///////////////////////////////

int ctl[][] = new int[10][64];


ArrayList p;
String filenames[] = {
  "souhvezdi.txt", "people.txt", "brain.txt", "lines.txt", "city.txt"
};
int cycleSix = 0;

boolean pulsating = true;

PImage podklad;

float snapDist = 5.0;
float trasSix = 9;

PFont figurative, tiny;

float strokeW = 20;

int phase = 1;

int shift;

///////////////////////



boolean boosh = false;


AudioInput in;



//PGraphicsOpenGL pgl; //need to use this to stop screen tearing
//GL gl;

//import codeanticode.gsvideo.*;
//GSMovieMaker mm;
int fps = 60;
//GSPipeline pipeline;

float vals[];
float cx, cy;


int mcntr = 0, minut=0;
boolean once = true;


/////////// three ////////////



float rots[];


float rotsX[]; 
float rotsY[];
float rotsZ[];

float avg = 0;





////////// four ///////////////


Shaper shaper;

int chill = 100;


float time1, time2;
float mezi = 250;

/////////////////////////////////


void six() {


  switch(phase) {
  case 1:
    jedna();
    break;
  case 2:
    dva();
    break;

  case 3:
    tri();
    break;

  case 4:
    ctyri();
    break;


  default:
    background(0);
  }
}



void keyPressed() {

  if (keyCode==ENTER) {
    time1 = time2;
    time2 = millis();

    mezi += ((time2-time1)-mezi)/1.2;

    chill = 50;
  }
  else if (keyCode==DELETE) {
    erasePoints();
  }
  else if (keyCode==RIGHT) {
    phase++;
  }
  else if (keyCode==LEFT) {
    phase--;
  }
  else {
    if (key=='s') {
      savePoints();
    }
    else if (key=='l') {
      loadPoints();
    }
    else if ((int)key-48 >= 1 && (int)key-48 <= 9) {
      cycleSix = (int)key-49;
      println(cycleSix);
      loadPoints();
    }
    else if (key==' ') {
      boosh=!boosh;
    }
  }
}

void jedna() {


  background(0);
  pushStyle();

  //strokeW = ctl[phase][35];
  //tras = ctl[phase][46];

  strokeWeight(strokeW);

  if (pulsating) {
    translate(noise(frameCount/2.0, 0)*trasSix, noise(0, frameCount/2.0)*trasSix);

    translate(width/2, height/2);
    scale(1+noise(frameCount/300.0)*0.1);
    translate(-width/2, -height/2);
  }

  pushMatrix();

  scale(0.8);
  translate(0, 100);
  for (int i = 0 ; i < p.size();i++) {
    Linka tmp = (Linka)p.get(i);
    tmp.draw();
  }

  popMatrix();

  popStyle();



  textFont(figurative);
  fill(255, noise(frameCount)*120+120);
  text("fig. "+(cycleSix+1), width/4*3.4+noise(frameCount/2.0, 0)*trasSix/10.0, height-50+noise(0, frameCount/2.0)*trasSix/10.0);
}






void mousePressed() {
  if (mouseButton==LEFT) {
    p.add(new Linka(p.size()-1, new PVector(mouseX, mouseY)));
    snapStart();
  }
}

void mouseReleased() {
  if (mouseButton==LEFT) {
    Linka tmp = (Linka)p.get(p.size()-1);
    tmp.end = new PVector(mouseX, mouseY);
  }
}

void mouseDragged() {

  if (mouseButton==LEFT) {
    snap();
  }
}


void snapStart() {
  Linka now = (Linka)p.get(p.size()-1);
  for (int i = 0 ; i < p.size()-1;i++) {
    Linka tmp = (Linka)p.get(i);
    if (dist(tmp.start.x, tmp.start.y, mouseX, mouseY)<snapDist) {
      now.start.x = tmp.start.x;
      now.start.y = tmp.start.y;
    }

    if (dist(tmp.end.x, tmp.end.y, mouseX, mouseY)<snapDist) {
      now.start.x = tmp.end.x;
      now.start.y = tmp.end.y;
    }
  }
}

void snap() {
  for (int i = 0 ; i < p.size()-1;i++) {
    Linka tmp = (Linka)p.get(i);
    if (dist(tmp.start.x, tmp.start.y, mouseX, mouseY)<snapDist) {
      mouseX = (int)tmp.start.x;
      mouseY = (int)tmp.start.y;
    }

    if (dist(tmp.end.x, tmp.end.y, mouseX, mouseY)<snapDist) {
      mouseX = (int)tmp.end.x;
      mouseY = (int)tmp.end.y;
    }
  }
}



class Linka {
  PVector start;
  PVector end;
  int id;

  Linka(int _id, PVector _start) {
    id = _id;
    start=_start;
  }

  Linka(int _id, PVector _start, PVector _end) {
    id = _id;
    start=_start;
    end=_end;
  }

  void draw() {

    if (pulsating)
      stroke(255, (sin((frameCount+id*80.0)/(pulseSpeed+1.0))+0.5)/2.0*(bright*2.0) );

    if (end!=null) {
      dline(start.x, start.y, end.x, end.y, 6);
      line(start.x-5, start.y, start.x+5, start.y);
      line(start.x, start.y-5, start.x, start.y+5);

      line(end.x-5, end.y, end.x+5, end.y);
      line(end.x, end.y-5, end.x, end.y+5);
    }
    else {
      dline(start.x, start.y, mouseX, mouseY, 5);
    }
  }
}


void savePoints() {
  String list[];
  list = new String[p.size()];
  for (int i = 0 ; i < p.size();i++) {
    Linka tmp = (Linka)p.get(i);
    list[i] =
      tmp.start.x+","+tmp.start.y+","+
      tmp.end.x+","+tmp.end.y;
  }

  saveStrings(filenames[cycleSix], list);
}


void loadPoints() {

  try {
    loadPointsRaw();
  }
  catch(Exception e) {
    savePoints();
  }
}

void loadPointsRaw() {
  String raw[] = loadStrings(filenames[cycleSix]);

  erasePoints();
  for (int i = 0 ; i < raw.length;i++) {
    String ln = raw[i]+"";
    String ps[] = splitTokens(ln, ",");
    PVector _start = new PVector(parseFloat(ps[0]), parseFloat(ps[1]));
    PVector _end = new PVector(parseFloat(ps[2]), parseFloat(ps[3]));

    p.add(new Linka(p.size()-1, _start, _end));
  }
}

void erasePoints() {
  p = new ArrayList();
}





void dline(float _x1, float _y1, float _x2, float _y2, float _res) {
  float res = _res;

  float d = dist(_x1, _y1, _x2, _y2);
  int cnt = 0;
  for (float l = (frameCount)%(res*2);l < d ; l += res) {

    if (cnt%2==0) {
      float pos1 = map(l, 0, d, 0, 1);
      float pos2 = map(l+res, 0, d, 0, 1);
      line(lerp(_x1, _x2, pos1), lerp(_y1, _y2, pos1), lerp(_x1, _x2, pos2), lerp(_y1, _y2, pos2));
    }
    cnt++;
  }
}




void dva() {

  //fastblur(g,1);
  if (effect>10)
    blend(g, 0, 0, width, height, 0, 0, width, height, (int)(effect/8.0));

  noStroke();
  if (frameCount%((129-krize)*20)==0)
    for (int i =0 ; i<width;i+=30) {
      stroke(255, sixAlpha);
      //rect(i,height-30,8,8);
      line(i-5, height-10, i+6, height-10);
      line(i, height-15, i, height-5);
    }

  ///////////////////////////////////


  if (frameCount%(129-sixSpeed)==0)
    shift=1;
  else
    shift =0 ;

  image(g, 0, -shift);
  fill(0, 13);

  pushStyle();
  rectMode(CORNER);
  noFill();
  stroke(0);
  strokeWeight(10);
  rect(0, 0, width, height);
  popStyle();



  fft.forward(in.mix);
  for (float q = 0;q<width;q+=width/4) {

    pushMatrix();
    translate(q+width/8, height);
    //translate(q+cx*10.0, height-10.0-cy*10.0);
    rotate(cos(q+frameCount/1500.0)*4.0);

    float t = 0;
    beginShape();  

    for (int i = 5; i < fft.specSize()/4.0; i++)
    {
      stroke(lerpColor(#473B0B, #ffffff, constrain(norm(vals[i], 0, 1024), 0, 1)), vals[i]/8.0*map(al2, 0, 127, 0, 8));
      vals[i] += (fft.getBand(i)*i*(amt/32.0) - vals[i])/(129-amt+1.0);
      t = (radians(map(i+frameCount/50.0+q, 0, fft.specSize()/4.0, 0, 360)));
      vertex(sin(t)*vals[i], cos(t)*vals[i]);
      cx+=(sin(t)*vals[i]-cx)/1000.0;
      cy+=(cos(t)*vals[i]-cy)/1000.0;
    }

    endShape(CLOSE);

    stroke(255, bodyAlpha);
    point(0, 150);
    point(0, -150);
    point(150, 0);
    point(-150, 0);



    popMatrix();
  }


  if (boosh)
    if (frameCount%(flicking+1)==0)
      filter(INVERT);

  if (millis()%1000<200 && once) {
    textAlign(RIGHT);
    textFont(tiny);
    fill(255);

    mcntr++;

    if (mcntr%60==0)
    {
      minut++;
      mcntr=0;
    }
    if (minut==0)
      text(round(millis()/1000)+"s", width-10, height-7);
    else
      text(minut+"m "+(round(millis()/1000)%60)+"s", width-10, height-7);


    stroke(#ff0000, 127);
    line(0, height-8, width, height-8);
    once = false;
  }

  if (frameCount%100==0)
    once = true;
}

void tri() {

  //background(0);
  //stroke(255);

  int pos = frameCount%height;

  //al = ctl[phase][33]*2.0;


  for (int i = 0; i < in.bufferSize() - 1; i++)
  {

    stroke((in.left.get(i)*redAmt*2), (in.right.get(i)*greenAmt*2), 0, al1);
    line(0, i, width, i);


    avg += ((in.left.get(i)+in.right.get(i))*2000.0-avg)/30000.0;
  }

  pushMatrix();
  translate(width/2, height/2);
  rectMode(CENTER);
  for (int i = 0; i < in.bufferSize() - 1; i+=5)
  {
    noFill();
    stroke(255, al2);
    rots[i] += (lerp(0, in.right.get(i), amt/2.0)-rots[i])/10.0;
    rotate(radians(rots[i])*10);
    rect(0, 0, i, i);
  }
  rectMode(CORNER);
  popMatrix();



  fill(elipsaFill*2, elipsaAl*2);
  noStroke();
  ellipse(width/2, height/2, 400+avg, 400+avg);
}




void ctyri() {

  pushStyle();

  for (int i = 0; i < height; i++)
  {

    stroke(((in.left.get(i)+in.right.get(i))*sixAlpha2*4));
    line(0, i, width, i);


    avg += ((in.left.get(i)+in.right.get(i))*2000.0-avg)/30000.0;
  }

  //////////////////////////////////////////


  translate((noise(frameCount, 0)-0.5)*tras, 
  (noise(0, frameCount)-0.5)*tras);

  chill --;


  if (millis()%(int)mezi<50 && chill<0) {

    fill(random(255), random(255), random(255), sixAlpha3*2);
    noStroke();




    pushMatrix();
    translate(width/2, height/2);
    //ellipse(width/2,height/2,400,400);
    shaper.draw();

    shaper.gen();
    popMatrix();
  }
  else {
    shaper.gen();
  } 
  popStyle();
}

class Shaper {
  int sides;

  ArrayList vec;

  Shaper(int _sides) {
    sides=_sides;
    gen();
  }


  void gen() {

    //sides = ctl[pha;

    vec = new ArrayList();

    for (int i = 0 ; i < sides;i++) {
      vec.add(new PVector(
      (noise(i+(millis()/1000.0), 0)-0.5)*width, 
      (noise(0, i+(millis()/1000.0))-0.5)*height)
        );
    }
  }


  void draw() {



    beginShape();
    for (int i =1 ; i < vec.size();i++) {
      PVector tmp = (PVector)vec.get(i);

      vertex(tmp.x, tmp.y);
    }




    endShape(CLOSE);

    stroke(255, sixAlpha*2);
    strokeWeight(strokeW);

    for (int i =1 ; i < vec.size();i++) {
      PVector tmp2 = (PVector)vec.get(i-1);

      PVector tmp = (PVector)vec.get(i);

      dline(tmp.x, tmp.y, tmp2.x, tmp2.y, 10.0);
    }
  }
}

