/**
 * SqueezePast
 * A Voronoi Map created dynamically by a set of moving points
 * by Steven Kay
 *
 */
 
 
Random die=new Random();
ArrayList points=new ArrayList();

PImage bck;

int num = 90;
 
float y = 100;


void setup()
{
  size(400, 400, P2D);  // Size should be the first statement
  noStroke();     // Set line drawing color to white
  frameRate(30);
  for (int i=0;i<num;i++) {
    points.add(new Attractor());   
  }
  
  
  bck = loadImage("lenna.jpg");
  
  bck.loadPixels();
  
  background(0);   // Set the background to black
}

void draw()
{
  
  fill(255);
  
   
  for (int x=0;x<width;x+=2) {
    for (int y=0;y<height;y+=2) {
      int nearest=0;
      float closest=1000.0;
      for (int p=0;p<points.size();p++) {
        Attractor a=(Attractor)points.get(p);
        float dist=a.distanceTo(x,y);
        if (dist<closest) {
          nearest=p;
          closest=dist;
          
          
        }
      }
      Attractor a=(Attractor)points.get(nearest);
      fill(a.c); // fill by color
      
      
      
      rect(x,y,2,2);
    }
  }
   
  for (int i=0;i<points.size();i++) {
    Attractor a=(Attractor)points.get(i);
    a.move();
  }
}

