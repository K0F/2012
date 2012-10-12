float SCALE = 100.0;
BodyPart test;

void setup() {
size(320,320,P3D);
  test = new BodyPart(0,"sphere.raw");

}


void draw() {
  background(0);
  
  lights();
  
  pushMatrix();
  translate(width/2,height/2);
  rotateY(frameCount/100.0);
  rotateX(frameCount/1000.0);
  
  fill(255,127);
  stroke(255,127);
  test.draw();
  
  popMatrix();
}

class BodyPart {
  ArrayList pos;
  BodyPart parent;

  ArrayList p;
  ArrayList v;
  String filename;
  int id;

  String[] raw;

  BodyPart(int _id, String _filename) {
    id = _id;
    filename = _filename;
    raw = loadStrings(filename);

    parseVertexes();
  }

  void parseVertexes() {
    v = new ArrayList();
    float [] ccs = new float[0];

    for (int i = 0 ; i < raw.length;i++) {
      String coords[] = splitTokens(raw[i], " ");
      ccs = new float[coords.length];
      for (int c = 0 ; c < coords.length;c++) {
        ccs[c] = parseFloat(coords[c]);
      }

    Pnt one = new Pnt(0, new PVector(ccs[0], ccs[1], ccs[2]));
    Pnt two = new Pnt(0, new PVector(ccs[3], ccs[4], ccs[5]));
    Pnt three = new Pnt(0, new PVector(ccs[6], ccs[7], ccs[8]));
   // Pnt four = new Pnt(0, new PVector(ccs[9], ccs[10], ccs[11]));

    v.add(new Vrt(one, two, three));

    }

  }
  
  void draw(){
   
   for(int i = 0 ; i < v.size();i++){
    Vrt tmp = (Vrt)v.get(i);
    
    tmp.draw();
    
   } 
    
  }
}
/////////////////////////////
class Vrt {
  Pnt one, two, three, four;

  Vrt(Pnt _one, Pnt _two, Pnt _three, Pnt _four) {
    one = _one;
    two = _two;
    three = _three;
    four = _four;
  }
  
  Vrt(Pnt _one, Pnt _two, Pnt _three) {
    one = _one;
    two = _two;
    three = _three;
   }
  
  void draw(){
    beginShape();
    vertex(one.loc.x,one.loc.y,one.loc.z);
    vertex(two.loc.x,two.loc.y,two.loc.z);
    vertex(three.loc.x,three.loc.y,three.loc.z);
    //vertex(four.loc.x,four.loc.y,four.loc.z);
    endShape(CLOSE);
  }
}
/////////////////////////////

class Pnt {
  int id;
  PVector loc;

  Pnt(int _id, PVector _loc) {
    loc = new PVector(_loc.x*SCALE, _loc.y*SCALE, _loc.z*SCALE);
    id = _id;
  }
  
  void draw(){
   point(loc.x,loc.y,loc.z); 
  }
}

