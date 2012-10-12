
/*
*  
*
*
*/


color c1,c2,c3;

ArrayList vec, org;

float s = 10;
float shift = 2*s+sin(radians(60))*s; 


float shiftX = cos(radians(14))*s; 
float  shiftY = sin(radians(14))*s; 


int numX = 20;
int numY = 20;

float cnt;

void setup() {
  size(512, 512);

  reset();

  colorMode(HSB);
}

void reset() {

  vec = new ArrayList();
  org = new ArrayList();

  for (int y = 0 ; y*(s+shiftY) < height + s * 2;y++) {

    for (int x = 1 ; x*(s+shiftX)+shiftX < width-s;x++) {
      if (y%2==0) {

        org.add(new PVector(x*(s+shiftX), y*(s+shiftY)));
        vec.add(new PVector(x*(s+shiftX), y*(s+shiftY)));
      }
      else {

        org.add(new PVector(x*(s+shiftX)+shiftX, y*(s+shiftY)));
        vec.add(new PVector(x*(s+shiftX)+shiftX, y*(s+shiftY)));
      }
    }
  }
}


void draw() {
  background(0);

  float cnt = 0.0;



  for (int y = 0 ; y*(s+shiftY) < height + s * 2;y++) {

    for (int x = 1 ; x*(s+shiftX)+shiftX < width-s;x++) {



      if (y%2==0)
        hexagon(x*(s+shiftX), y*(s+shiftY), s, 0, 0, 0, cnt);
      else
        hexagon(x*(s+shiftX)+shiftX, y*(s+shiftY), s, 0, 0, 0, cnt);

      cnt += 1.0;
    }
  }
}

void hexagon(float x, float y, float s, color jedna, color dva, color tri, float i) {


  PVector v = (PVector)vec.get((int)i);
  PVector o = (PVector)org.get((int)i);

  float a = mouseX-v.x;
  float b = mouseY-v.y;

  float d = InvSqrt(a*a+b*b);

  float fx = v.x - (a / d) * 1000.0 / d;
  float fy = v.y - (b / d) * 1000.0 / d;

  float mx = (o.x - v.x) / 20.0;
  float my = (o.y - v.y) / 20.0;

  v.x += (mx+fx-v.x)/10.;
  v.y += (my+sin(d/200.0+frameCount/60.0)*s+fy-v.y)/10.;

  s = dist(v.x, v.y, x, y)/8.0+InvSqrt(shiftX*shiftX+shiftY*shiftY);


  float cx = mouseX;//noise(0, frameCount/60.0)*width;
  float cy = mouseY;//noise(frameCount/60.0, 0)*height;





  jedna = lerpColor( #000000, #07889D, map(dist(cx, cy, x, y), 0, width*1.5, 0, 1 ));
  dva = lerpColor( #cacaca, #234495, map(dist(cx, cy, x, y), 0, width*1.5, 0, 1 ));
  tri = lerpColor( #fafafa, #283E87, map(dist(cx, cy, x, y), 0, width*1.5, 0, 1 ));

  pushMatrix();
  translate(v.x, v.y);
  noStroke();
  
  rotate(atan2(my,mx));
  
  float alph = 255;//255-abs(mx+my)*12.0;
  noFill();
  //stroke(jedna,95);
  fill(jedna,alph);

  quad(
  0, 0, 
  cos(radians(-30))*s, sin(radians(-30))*s, 
  cos(radians(30))*s, sin(radians(30))*s, 
  cos(radians(90))*s, sin(radians(90))*s
    );


//stroke(dva,95);
  fill(dva,alph);

  quad(
  0, 0, 
  cos(radians(90))*s, sin(radians(90))*s, 
  cos(radians(150))*s, sin(radians(150))*s, 
  cos(radians(210))*s, sin(radians(210))*s
    );
    
    stroke(tri,95);
  fill(tri,alph);
  quad(
  0, 0, 
  cos(radians(210))*s, sin(radians(210))*s, 
  cos(radians(270))*s, sin(radians(270))*s, 
  cos(radians(-30))*s, sin(radians(-30))*s
    );
  popMatrix();
}

