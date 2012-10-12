
class Attractor {
   
  public int x;
  public int y;
  public int dx;
  public int dy;
  public float r,g,b;
  color c;
   
  public Attractor() {
    this.x=die.nextInt(200);
    this.y=die.nextInt(200);
    this.dx=-2+die.nextInt(4);
    this.dy=-2+die.nextInt(4);
    this.r=(float)die.nextInt(255);
    this.g=(float)die.nextInt(255);
    this.b=(float)die.nextInt(255);
  }
   
  public void move() {
    // move with wrap-around
    this.x+=this.dx;
    if (this.x<0) this.x+=200;
    if (this.x>width) this.x-=200;
    this.y+=this.dy;
    if (this.y<0) this.y+=200;
    if (this.y>height) this.y-=200;
    
    c = bck.get(x,y);
  }
   
  public float distanceTo(int xx,int yy) {
    // Euclidian Distance
    return (float)Math.sqrt(Math.pow(xx-this.x,2)+Math.pow(yy-this.y,2));
  }
}
 
 
