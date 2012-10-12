ArrayList objs;
Obj active;

void setup() {
  size(1600, 900, P2D); 
  objs = new ArrayList();

  textFont(loadFont("65Amagasaki-8.vlw"));
  textMode(SCREEN);
}

void draw() {
  background(0);

  for (int i = 0 ;i  < objs.size();i++) {
    Obj tmp = (Obj)objs.get(i);
    tmp.draw();
  }
}

void mousePressed() {
  objs.add(new Obj(mouseX, mouseY));
}


void keyPressed() {
  if (active!=null) {
    if (allowed(key)) {
      active.name += key;
    }
    else if (keyCode==BACKSPACE) {
      if (active.name.length()>0)
        active.name = active.name.substring(0, active.name.length()-1);
    }
  }
}


////////////////////////////// keys allowed as input
boolean allowed(char _key) {
  boolean answer = false;

  if (_key>='a'&&_key<='z')
    answer = true;

  if (_key>='('&&_key<='9')
    answer = true;

  if (_key>=' ')
    answer = true;


  return answer;
}


int h = 10;

class Obj {
  int x, y;
  String name;
  ArrayList ins;
  ArrayList outs;

  Obj(int _x, int _y) {
    x=_x;
    y=_y;
    name = "";
    active = this;
  }

  void draw() {
    fill(120);
    if (active==this)
      stroke(255, 127, 0);
    else
      stroke(255);

    rect(x, y-h, textWidth(name)+3, h);
    fill(0);
    text(name, x+2, y-1);
  }
}

