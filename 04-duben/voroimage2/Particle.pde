
class Particle
{
  float x, y;
  color c;
  PVector vel;
    
  Particle()    // constructor
  {
    x = random(width);
    y = random(height);
    c = color(random(64,228), random(128,192), random(128,255));
    vel = new PVector(random(-maxSpeed, maxSpeed), random(-maxSpeed, maxSpeed));
  }
    
  void move()   // move and bounce
  {
    c = img.pixels[constrain((int)y*img.width+(int)x,0,img.pixels.length-1)];
    x += vel.x;
    y += vel.y;
    if ((x<1) || (x>width-1))  vel.x *= -1;
    if ((y<1) || (y>height-1)) vel.y *= -1;
  }
}
//-----------------------------------------------------------

//-----------------------------------------------------------
void drawDots()
{
  for(int i=0; i<animDots; i++)
  {
    Particle s = dots[i];
    fill(s.c, 128);
    stroke(66);
    ellipse(s.x, s.y, dotSize, dotSize);
  }
}
//-----------------------------------------------------------
void moveDots()
{
  for(int i=0; i<animDots; i++)
    dots[i].move();
}
//-----------------------------------------------------------
void colorizeDots(int transparency)
{
  for(int i=0; i<maxDots; i++)
    dots[i].c = color(random(64,228), random(128,192), random(128,255), transparency);
}
 
 
