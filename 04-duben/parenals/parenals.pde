
int num = 1000;
ArrayList drivers;
String pattern = "";

int timer = 0;


void setup() {
  size(1600, 900, P2D);

  textFont(loadFont("53Seed-8.vlw"));
  textMode(SCREEN);

  drivers = new ArrayList();
  for (int i =0 ; i < num;i++)
    drivers.add(new Driver(i));

  background(255);
}


void keyPressed() {
  switch(keyCode) {
  case LEFT: 
    pattern+="h"; 
    break;
  case DOWN: 
    pattern+="j"; 
    break;
  case UP: 
    pattern+="k"; 
    break;
  case RIGHT: 
    pattern+="l"; 
    break;
  }

  if (key==' ') {
    pattern = "";
    background(255);
  }
}

void draw() {
  
  noStroke();
  fill(255);
  rect(0, 0, textWidth(pattern)+20, 10);

  fill(0);
  text(pattern, 10, 10);

  stroke(0, 15);

  for (int i =0 ; i < drivers.size();i++) {
    Driver d = (Driver)drivers.get(i);
    d.draw();
    
  }
}


class Driver {
  PVector pos;
  PVector dir;
  PVector acc; 
  int sel;
  int id;
String myPattern;

  Driver(int _id) {
    id = _id;
    sel= 0;
    pos =new PVector(random(width), random(height));
    dir = new PVector(0, 0);
    acc = new PVector(0, 0);
    
  myPattern = "";

  }

  void draw() {
    if (pattern.length() > 0) {



      if(frameCount%(id+1)==0)
      acc.add( patternToVector());


      sel++;
      sel=sel%pattern.length();
    }

    //dir.normalize();

    pos.add(dir);
    dir.add(acc);
    dir.limit(1.0);
    acc.mult(0.1);
    
    for(int i =0  ; i < drivers.size();i++){
      Driver d = (Driver)drivers.get(i);
     pos.sub(d.dir); 
    }
    
    bordr();

    point(pos.x, pos.y);
  }

  PVector patternToVector() {

    PVector tmp = new PVector(0, 0);

    switch(pattern.charAt(sel)) {
    case 'h': 
      tmp = new PVector(-1, 0); 
      break;
    case 'j': 
      tmp = new PVector(0, 1); 
      break;
    case 'k': 
      tmp = new PVector(0, -1); 
      break;
    case 'l': 
      tmp = new PVector(1, 0); 
      break;
    }

    return tmp;
  }

  void bordr() {
    if (pos.x > width)pos.x=pos.x-width;
    if (pos.x < 0)pos.x=width-pos.x;
    if (pos.y > height)pos.y=pos.y-height;
    if (pos.y < 0)pos.y=height-pos.y;
  }
}

