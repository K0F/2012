void jedna() {


  background(0);
  pushStyle();

strokeW = ctl[phase][35];
tras = ctl[phase][46];

  strokeWeight(strokeW);

  if (pulsating) {
    translate(noise(frameCount/2.0, 0)*tras, noise(0, frameCount/2.0)*tras);

    translate(width/2, height/2);
    scale(1+noise(frameCount/300.0)*0.1);
    translate(-width/2, -height/2);
  }

  for (int i = 0 ; i < p.size();i++) {
    Linka tmp = (Linka)p.get(i);
    tmp.draw();
  }

  popStyle();

  textFont(figurative);
  fill(255, noise(frameCount)*120+120);
  text("fig. "+(cycle+1), width/4*3.2+noise(frameCount/2.0, 0)*tras/10.0, height-50+noise(0, frameCount/2.0)*tras/10.0);
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
      stroke(255, (sin((frameCount+id*80.0)/(ctl[phase][34]+1.0))+0.5)/2.0*(ctl[phase][33]*2.0) );

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

  saveStrings(filenames[cycle], list);
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
  String raw[] = loadStrings(filenames[cycle]);

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

