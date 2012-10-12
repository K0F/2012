
int GX = 0;
int GY = 0;

float vtras =0;
float htras =0;

float vtras_speed = 10.0;
float htras_speed = 10.0;

float [] hpos = {
   0, 24
};
float [] vpos = {
  0, 24
};


Tile tiles[];

int w = 24;

void setup() {
  size(1280, 600);
  smooth();
  noStroke();

  reset();
  
}

void reset() {
  tiles = new Tile[(width*height)/w];

  for (int i =0 ; i < tiles.length;i++)
    tiles[i] = new Tile(i); 

  GX = 0;
  GY = 0;
  
  
}

void mousePressed() {
  reset();
}


void draw() {
  
  reset();
  background(#000000);

  hint(DISABLE_DEPTH_TEST);

  fill(#ffffff);


  for (int i = 0 ; i < tiles.length ; i++) {
    tiles[i].draw();
  }
  
  saveFrame("/home/kof/render/patternGen/fr#####.png");
}

class Tile {

  PVector hori[];
  PVector vert[];
  PVector base;

  int id;

  Tile(int _id) {


    id = _id;

    base = new PVector(GX, GY);

    GX+=w;

    if (GX>width) {

      GX=0;
      GY+=w;
    }

    hori = new PVector[4];
    vert = new PVector[4];


    ////

    int hsel1 = (int)random(hpos.length);
    int hsel2 = (int)random(hpos.length);
    int hsel3 = (int)random(hpos.length);
    int hsel4 = (int)random(hpos.length);

    /*
    hsel1 = (int)random(hpos.length-2);
     hsel4 = hsel1+2;
     
     hsel3 = (int)random(hpos.length-2);
     hsel2 = hsel3+2;
     */
    if (id==0) {
      hori[0] = new PVector(0, hpos[hsel1]);
      hori[3] = new PVector(0, hpos[hsel4]);
    }
    else {
      hori[0] = new PVector(0, tiles[id-1].hori[1].y);
      hori[3] = new PVector(0, tiles[id-1].hori[2].y);
    }

    hori[1] = new PVector(w, hpos[hsel3]);
    hori[2] = new PVector(w, hpos[hsel2]);

    ////

    int vsel1 = (int)random(vpos.length);
    int vsel2 = (int)random(vpos.length);
    int vsel3 = (int)random(vpos.length);
    int vsel4 = (int)random(vpos.length);

    /*
    vsel1 = (int)random(vpos.length-2);
     vsel4 = vsel1+2;
     
     vsel3 = (int)random(vpos.length-2);
     vsel2 = vsel3+2;
     */
    if (id<width/w+1) {
      vert[0] = new PVector(vpos[vsel1], 0);
      vert[3] = new PVector(vpos[vsel4], 0);
    }
    else {
      vert[0] = new PVector(tiles[id-width/w-1].vert[1].x, 0);
      vert[3] = new PVector(tiles[id-width/w-1].vert[2].x, 0);
    }

    vert[1] = new PVector(vpos[vsel3], w);
    vert[2] = new PVector(vpos[vsel2], w);

    ////
  }

  void draw() {

    //stroke(255);

    noStroke();

    pushMatrix();
    translate(base.x, base.y);


    //fill(#96C5F8);

    beginShape();

    for (int i =0  ; i < 4;i++) {

      vertex(hori[i].x, hori[i].y);
      hori[i].add(new PVector(0, (noise(0, (id+frameCount)/htras_speed)-0.5)*htras));
    }

    endShape(CLOSE);

    // fill(#C9B9AE);


    beginShape();

    for (int i =0  ; i < 4;i++) {
      vertex(vert[i].x, vert[i].y);
      vert[i].add(new PVector((noise((id+frameCount)/vtras_speed, 0)-0.5)*vtras, 0));
    }
    endShape(CLOSE);



    if (id<width/w+1) {
      //  vert[0] = new PVector(vpos[vsel1], 0);
      //vert[3] = new PVector(vpos[vsel4], 0);
    }
    else {
      vert[0] = new PVector(tiles[id-width/w-1].vert[1].x, 0);
      vert[3] = new PVector(tiles[id-width/w-1].vert[2].x, 0);
    }



    popMatrix();
  }
}

