/**
 *  Hardcoded pixels bus-stop LONDONE remake by Krystof Pesek alias Kof, licensed under Creative Commons Attribution-Share Alike 3.0 license.
 *  License: http://creativecommons.org/licenses/by-sa/3.0/
 *
 * visit more @ http://vimeo.com/kof
 * if you leave this header, bend, share, spread the code, it is a freedom!
 *
 *   ,dPYb,                  ,dPYb,
 *   IP'`Yb                  IP'`Yb
 *   I8  8I                  I8  8I
 *   I8  8bgg,               I8  8'
 *   I8 dP" "8    ,ggggg,    I8 dP
 *   I8d8bggP"   dP"  "Y8ggg I8dP
 *   I8P' "Yb,  i8'    ,8I   I8P
 *  ,d8    `Yb,,d8,   ,d8'  ,d8b,_
 *  88P      Y8P"Y8888P"    PI8"8888
 *                           I8 `8,
 *                           I8  `8,
 *                           I8   8I
 *                           I8   8I
 *                           I8, ,8'
 *                            "Y8P'
 *
 */

// enter proper bus-stop name here ///

String stop_name = "Piccadilly Circus";

//////////////////////////////////////
/*
* [0][1][2]
 * [3][x][4]
 * [5][6][7]
 */


int[][] px;
int matrix[][][];
int mm[] = {
  3, 5, 3, 3, 3, 3, 6, 7
};
int mod[];
boolean maska[];

int siz = 92;

int runNum[];

PFont font;
PGraphics txt;

void setup() {
  size(512, 160);
  px = new int[width][height];
  matrix = new int[width][height][mm.length];
  runNum = new int[width*height];
  mod = new int[width*height];
  frameRate(8);


  font = loadFont("53Seed-93.vlw");
  textFont(font, siz);
  while (textWidth (stop_name)>width-5) {
    textFont(font, siz);
    siz--;
  }

  txt = createGraphics(width, height, JAVA2D);
  txt.beginDraw();
  txt.textFont(font, siz);
  txt.textAlign(CENTER);
  txt.text(stop_name, width/2, height/2+40);
  txt.endDraw();

  txt.loadPixels();

  maska = new boolean[txt.pixels.length];
  for (int i =0 ;i<maska.length;i++)
    if (brightness(color(txt.pixels[i]))>120)
      maska[i] = true;
    else
      maska[i] = false;


  loadPixels();

  for (int x = 0;x<width;x++) {
    for (int y = 0;y<height;y++) {
      runNum[y*width+x] = 0;
      mod[y*width+x] = 0;
      px[x][y] = color(0);

      for (int i = 2;i<mm.length-1;i+=3) {
        matrix[x][y][i] = mm[i];
        matrix[x][y][i-1] = mm[i-1];
        matrix[x][y][i-2] = (int)random(8);
      }

      matrix[x][y] = (int[])expand(matrix[x][y], matrix[x][y].length+1);
      matrix[x][y][matrix[x][y].length-1] = (int)random(8);

      pixels[y*width+x] = px[x][y];
    }
  }
}

void draw() {

  for (int x = 0;x<width;x++) {
    for (int y = 0;y<height;y++) {
      int index = y*width+x;

      if (runNum[index]>=matrix[x][y].length-1) {
        runNum[index] = 0;
      }

      if (index%2==0)
        mod[index]++;

      int shx = 0, shy = 0;

      int modded = (matrix[x][y][runNum[index]]+mod[index])%7;
      switch(modded) {
      case 0:
        shx = -1;
        shy = -1;
        break;

      case 1:
        shx = 0;
        shy = -1;
        break;

      case 2:
        shx = 1;
        shy = -1;
        break;

      case 3:
        shx = -1;
        shy = 0;
        break;

      case 4:
        shx = 1;
        shy = 0;
        break;

      case 5:
        shx = -1;
        shy = 1;
        break;

      case 6:
        shx = 0;
        shy = 1;
        break;

      case 7:
        shx = 1;
        shy = 1;
        break;
      }

      px[x][y] = pixels[((y+height+shy+mod[index])%height)*width+((x+width-shx+mod[index])%width)];

      runNum[index]++;
    }
  }

  float r = ((sin(frameCount/2.0)+1)+1.0)/2.0;
  int r2 = (int)((cos(frameCount/33.3333)+1)*20);



  for (int x = 0;x<width;x++) {
    for (int y = 0;y<height;y++) {
      int index = y*width+x;

      if (maska[(index+frameCount*width+(int)random(1, 4))%maska.length]) {

        pixels[index] = lerpColor(0xffff0000, 0xff000000, r);
      }
      else {
        pixels[index] = px[x][y];
      }
    }
  }
  updatePixels();
}

