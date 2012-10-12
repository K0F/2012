/** HIGHLY EXPERIMENTAL, ULTRA-SOPHISITCATED MACHINE LEARNING SIMPLE SHAPES by KOF 2012
 *   AI capability tester
 */


int[] TAXONOMY = {
  4, 16,2,2,8,16,8,4,2, 1
};

int cnt= 0;
int dim;
int siz = 3;
float RATE, FLEXI, SM, STOCHAISM;

boolean grid[][], start[][], target[][];
float vals[][];

PImage one;

Solver solver;


ArrayList INS, OUTS;

///////////////


void setup() {
  getGrids();
  size(288,288, P2D);
  
  //println(width+" "+height);


  STOCHAISM = 0.217;///(frameCount/100.0+1.0);
  RATE = 10;
  FLEXI = 2.1;
  SM = 30.0;

  INS = new ArrayList();
  OUTS = new ArrayList();
  
  textFont(loadFont("65Amagasaki-8.vlw"));
  textMode(SCREEN);
  textAlign(CENTER);




  solver = new Solver(TAXONOMY);
  
  background(0);
}

void getGrids() {
  one = loadImage("one.gif");



  dim = one.width;


  grid = new boolean[one.width][one.height];
  start = new boolean[one.width][one.height];
  
  vals = new float[one.width][one.height];

  one.loadPixels();





  for (int y = 0 ; y< dim;y++) {
    for (int x = 0 ; x< dim;x++) {


      int index = y*one.width+x;
      if (brightness(one.pixels[index])==255) {
        start[x][y] = true;

        grid[x][y] = true;
      }

    }
  }
}

void draw() {
  fill(0, 120);
  rect(0, 0, width, height);

  RATE = 1 + noise(frameCount/100.0)*(dim+frameCount*0.1);

  for (int y = 0 ; y< dim;y++) {
    for (int x = 0 ; x< dim;x++) {

      if (grid[x][y])
        fill(255);
      else
        fill(0);

      float X = x*siz;
      float Y = y*siz;

      rect(X, Y, siz, siz);
    }
  }

  solver.plot();
  
  noStroke();
  fill(0);
  rect(0,height-10,width,10);
  fill(255);
  text("Learning cycles: "+frameCount+", rate: "+RATE,width/2,height-2);
}

