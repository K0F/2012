//------ POINT ------//
class Point{
  int n;
  float x,y,z,ox,oy,oz,oox,ooy,ooz,tx,ty,tz,otx,oty,otz;
  Point(float $x,float $y,float $z){
    n = global.npoints;
    global.points[global.npoints++] = this;
    x = ox = oox = tx = otx = $x;
    y = oy = ooy = ty = oty = $y;
    z = oz = ooz = tz = otz = $z;
  }
  void reset(){
    x = oox; y = ooy; z = ooz; ox = oox; oy = ooy; oz = ooz; tx = oox; ty = ooy; tz = ooz; otx = oox; oty = ooy; otz = ooz;
  }
  void match(Point $p){
    x = $p.x; y = $p.y; z = $p.z; ox = $p.ox; oy = $p.oy; oz = $p.oz; tx = $p.tx; ty = $p.ty; tz = $p.tz; otx = $p.otx;  oty = $p.oty; otz = $p.otz;
  }
  void move(float $dx,float $dy,float $dz){
    ox = x; oy = y; oz = z; x += $dx; y += $dy; z += $dz; tx = x; ty = y; tz = z;
  }
  void move_to(float $x,float $y,float $z){
    ox = x; oy = y; oz = z; x = $x; y = $y; z = $z; tx = x; ty = y; tz = z;
  }
  void direct(float $dx,float $dy,float $dz){
    otx = tx; oty = ty; otz = tz; tx += $dx; ty += $dy; tz += $dz;
  }
  void direct_to(float $tx,float $ty,float $tz){
    otx = tx; oty = ty; otz = tz; tx = $tx; ty = $ty; tz = $tz;
  }
  void rotate(float $cosa,float $sina,String $axis,float $x,float $y,float $z){
    float dx,dy,dz;
    if($axis=="x"){
      dz = z-$z; dy = y-$y;
      z = $z+dz*$cosa-dy*$sina; y = $y+dy*$cosa+dz*$sina;
    }else if($axis=="y"){
      dx = x-$x; dz = z-$z;
      x = $x+dx*$cosa-dz*$sina; z = $z+dz*$cosa+dx*$sina;
    }else if($axis=="z"){
      dx = x-$x; dy = y-$y;
      x = $x+dx*$cosa-dy*$sina; y = $y+dy*$cosa+dx*$sina;
    }
    tx = x; ty = y; tz = z; ox = x; oy = y; oz = z; otx = x; oty = y; otz = z;
  }
  float get_distance_to(float $x,float $y,float $z){
    return dist(x,y,z,$x,$y,$z);
  }
  void step(){
    ox = x;
    oy = y;
    oz = z;
    x += (tx-x)*point_speed;
    y += (ty-y)*point_speed;
    z += (tz-z)*point_speed;
  }
  void echo(int $indent){
    String indent = "";
    while(indent.length()<$indent){
      indent += "  ";
    }
    println(indent+"---- POINT #"+n+" ----");
    println(indent+"x: "+x+"  tx: "+tx);
    println(indent+"y: "+y+"  ty: "+ty);
    println(indent+"z: "+z+"  tz: "+tz);
  }
  void render(){
    beginShape();
    vertex(x-2,y-2,z);
    vertex(x+2,y-2,z);
    vertex(x+2,y+2,z);
    vertex(x-2,y+2,z);
    endShape(CLOSE);
  }
}
