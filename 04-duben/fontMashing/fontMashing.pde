String txt = "";

void setup() {
  size(600, 400, P2D);
  textAlign(CENTER);
  textFont(createFont("Tektonica", 21, true));
  textMode(SCREEN);
  noSmooth();
}


void draw() {

  background(0);

  txt += (char)random((int)'A', (int)'Z');
  //txt += "TEKTONICA";// (char)random((int)'0',(int)'9');
  //txt += (char)random((int)'a',(int)'z');


  if (frameCount%5==0)
    txt+=" ";

  if (txt.length()>2000) {
    txt = txt.substring(txt.indexOf(" "), txt.length());
  }

  text(txt, 10, 20, width-20, height*2);
}

