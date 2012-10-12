import megamu.mesh.*;

import processing.opengl.*;

import codeanticode.gsvideo.*;

GSPipeline source;


float tresh = 30.1;
int allcount = 0;

float X, Y;

boolean rec = false;
int cc = 0;

float [][] points;

int palette = 10000;

ArrayList vectors;

void setup() {





  size(1280, 720, P2D);
  textureMode(IMAGE);


  source = new GSPipeline(this, "v4l2src ! queue ! ffmpegcolorspace ! video/x-raw-rgb, width=424, height = 240"); 
  println(source.getPipeline()); 
  source.play(); 

  X=width/4;
  Y=height/2;

  colorMode(HSB);

  source.loadPixels();
}


void draw() {



  // tresh = mouseX;


  if (source.available()) {

    pushStyle();
    strokeWeight(10);
    stroke(0);
    fill(255, 255);
    rect(0, 0, width, height);
    popStyle();

    source.read();

    // tint(255,200);
    // image(source, 0, 0);

    allcount = 0;

    vectors = new ArrayList();

    analyze2(40, 0, 0, source.width-1, source.height-1);

    points = new float[(int)(vectors.size())][2];
    int vc = 0;

    for (int i = 0 ;i<vectors.size();i+=1) {
       PVector a = (PVector)vectors.get(i);
      points[i][0] = a.x;
      points[i][1] = a.y;
    }
    
    


    for (int i = 1 ;i<vectors.size();i+=3) {

      PVector a = (PVector)vectors.get(i);


      for (int q = 0 ;q<vectors.size();q+=3) {


        PVector b = (PVector)vectors.get(q);
        float d = dist(a.x, a.y, b.x, b.y);


        if (d<70 && a != b) {
          //strokeWeight(a.z/3.);
          stroke(0, 255.0/d);
          line(a.x, a.y, b.x, b.y);

          // a.x += (b.x-a.x)/20.0;
          // a.y += (b.y-a.y)/20.0;
        }
      }
    }

    if (abs(allcount-palette) > 1000 ) {
      if (allcount < palette) {
        tresh-=1;
      }
      else {
        tresh+=1;
      }
    }



    //blend(g,0,0,width,height,0,0,width,height,ADD);
    //fastblur(g,(int)(noise(frameCount/50.0)*5.0+.0));

    // blend(g,0,0,width,height,0,0,width,height,OVERLAY);

    // blend(g,0,0,width,height,0,0,width,height,ADD);
    //blend(g,0,0,width,height,0,0,width,height,HARD_LIGHT);

    //println(allcount);

    if (rec) {
      save("render/xift"+nf(cc, 5)+".tga");
      cc++;
    }



      //println(points[0][0]);
      //println(points[0][1]);
      
      Delaunay myDelaunay = new Delaunay( points );
      
      float[][] myEdges = myDelaunay.getEdges();

      for (int i=1; i<myEdges.length; i++)
      {
        float startX = myEdges[i][0];
        float startY = myEdges[i][1];
        float endX = myEdges[i][2];
        float endY = myEdges[i][3];
        float d = dist(startX,startY,endX,endY);
        
        stroke(#46391E,70);
        line( startX, startY, endX, endY );
        
      }
  }
}

void analyze2(int _depth, int _x, int _y, int _w, int _h) {
  int depth = _depth-1;


  allcount ++;

  float HUES = 0;
  float SATS = 0;
  float VALS = 0;

  float HUESd = 0;
  float SATSd = 0;
  float VALSd = 0;

  float cntr = 0;

  for (int y = _y ;y <= _y+_h;y++) {
    for (int x = _x ;x <= _x+_w;x++) {

      int idx = (y)*(source.width)+(x);
      HUES += hue(source.pixels[idx]);
      SATS += saturation(source.pixels[idx]);
      VALS += brightness(source.pixels[idx]);
      cntr+=1.0;
    }
  }
  HUES /= cntr;
  SATS /= cntr;
  VALS /= cntr;

  for (int y = _y ;y <= _y+_h;y++) {
    for (int x = _x ;x <= _x+_w;x++) {

      int idx = (y)*(source.width)+(x);
      HUESd += abs(HUES-hue(source.pixels[idx]));
      SATSd += abs(SATS-saturation(source.pixels[idx]));
      VALSd += abs(VALS-brightness(source.pixels[idx]));
    }
  }

  HUESd /= cntr;
  SATSd /= cntr;
  VALSd /= cntr;


  if (depth > 0 && abs(VALSd) > tresh) {

    if (depth<35) {

      //X+=(_x-X)/(palette);
      //Y+=(_y-Y)/(palette);



      // fill(HUES,SATS,VALS);
      //fill(0);
      //stroke(0,55);
      //noStroke();
      //noFill();

      /*
      beginShape();
       texture(new PImage(source.getImage()));
       vertex(_x+width/2,_y,_x,_y);
       vertex(_x+_w+width/2,_y,_x+_w,_y);
       vertex(_x+_w+width/2,_y+_h,_x+_w,_y+_h);
       vertex(_x+width/2,_y+_h,_x,_y+_h);
       
       
       
       endShape(CLOSE);
       */
      vectors.add(new PVector(map(_x, 0, source.width, 0, width), map(_y, 0, source.height, 0, height), 80-depth));



      // fill(HUES,SATS,VALS);
      //rect(map(_x, 0, source.width, 0, width),map(_y, 0, source.height, 0, height),map(_w, 0, source.width, 0, width),map(_h, 0, source.height, 0, height));
    }
    else {

      //fill(VALS,15);
      //noFill();
      // rect(map(_x, 0, source.width, 0, width), map(_y, 0, source.height, 0, height),30.0,30.0);
      //noStroke();
      //noStroke();
      // fill(VALS, 150);
      // ellipse(_x, _y, _w, _w);
    }


    analyze2(depth, _x, _y, _w/2, _h/2);
    analyze2(depth, _x+_w/2, _y, _w/2, _h/2);
    analyze2(depth, _x, _y+_h/2, _w/2, _h/2);
    analyze2(depth, _x+_w/2, _y+_h/2, _w/2, _h/2);
  }
}

