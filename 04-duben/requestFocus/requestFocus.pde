void init() {
  if (online)
    requestFocus(); 
  super.init();
}

String txt = "";

float fade = 0;
boolean ok = false;

void setup(){
  createFont("Semplice Regular",8);

  background(0); 
}

void draw(){
  background(fade);

  if(ok)
    fade++;


  text(txt,10,10);
}

void keyPressed(){
  txt += (char)key;
}

void mouseMoved(){
  ok=true; 
}

