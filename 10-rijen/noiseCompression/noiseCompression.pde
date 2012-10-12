

PImage gen;
float sc = 100.0;

int ln = 256;
int area = 256;

float dataR[][], dataG[][], dataB[][];

PGraphics sum;
float level = 1;

float approxR = 0;//dataR[0][0];
float approxG = 0;//dataG[0][0];
float approxB = 0;

void setup() {
  gen = loadImage("lenna1.png");
  size(gen.width, gen.height, P2D);



  dataR = new float[area][area];
  dataG = new float[area][area];
  dataB = new float[area][area];

  sum = createGraphics(gen.width, gen.height, P2D);
  sum.beginDraw();
  sum.background(0);
  sum.endDraw();

  gen.loadPixels();
}

int X, Y;



void draw() {
  background(0);
  //image(gen, 0, 0);
  line(0, ln, gen.width, ln);


  level = noise(frameCount/4.0)*80.0;//dist(mouseX,mouseY,pmouseX,pmouseY)*3.0+1;

  X = mouseX;
  Y = mouseY;

  X = constrain(X, area/2, gen.width-area/2);
  Y = constrain(Y, area/2, gen.height-area/2);

  int cx = 0, cy = 0;
  for (int y = Y-area/2 ;y < Y+area/2;y++) {
    cx = 0;
    for (int x = X-area/2 ;x < X+area/2;x++) {

      dataR[cx][cy] = red(gen.pixels[y*gen.width+x]);
      dataG[cx][cy] = blue(gen.pixels[y*gen.width+x]);
      dataB[cx][cy] = green(gen.pixels[y*gen.width+x]);
      cx++;
    }
    cy++;
  }

  /*

   for (int i = 0 ;i < dataR.length;i++)
   {
   
   stroke(dataR[i]);
   point(i, gen.height-dataR[i]);
   
   stroke(dataG[i]);
   point(i, gen.height-dataG[i]);
   
   stroke(dataB[i]);
   point(i, gen.height-dataB[i]);
   }
   */


  sum.loadPixels();


  cy = 0;
  for (int y = Y-area/2 ;y < Y+area/2;y++) {

    int cnt = 0;

    cx = 0;

    for (int x = X-area/2 ;x < X+area/2;x++) {
      approxR += (dataR[cx][cy]-approxR)/(level+0.0);
      approxG += (dataG[cx][cy]-approxG)/(level+0.0);
      approxB += (dataB[cx][cy]-approxB)/(level+0.0);
      cx++;

      float rat = map(dist(x, y, X, Y), 0, area/2, 0.2, 0);

      if (rat>0.001)
        sum.pixels[y*sum.width+x] = lerpColor(sum.pixels[y*sum.width+x], color(approxR, approxG, approxB), rat);
        
    }

    cy++;
  }





tint(255);
  image(sum,  random(-2, 2), random(-2, 2));

  sum.filter(GRAY);

sum.beginDraw();
  sum.blend(gen, 0, 0, width, height, 0, 0, width, height, MULTIPLY);
  fastblur(sum,(int)random(3));//.filter(BLUR, 0.6);
  //if(frameCount%2==0)
  sum.blend(sum, 0, 0, width, height, 0, 0, width, height, ADD);
  sum.endDraw();
}

