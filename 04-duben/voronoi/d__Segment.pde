//------ SEGMENT ------//
class Segment{
  int n;
  float l;
  Point p1,p2;
  Segment(Point $p1,Point $p2){
    p1 = $p1; p2 = $p2;
    n = global.nsegments;
    global.segments[global.nsegments++] = this;
    l = get_length();
  }
  void reset(){
    p1.reset();
    p2.reset();
  }
  void match(Segment $s){
    p1.match($s.p1);
    p2.match($s.p2);
  }
  float get_length(){
    return dist(p1.x,p1.y,p1.z,p2.x,p2.y,p2.z);
  }
  float get_slope(){
    //xy coordinates only
    if(p2.x!=p1.x){
      return ((p2.y-p1.y)/(p2.x-p1.x));
    }else{
      return 999999999;
    }
  }
  boolean is_ray_intersecting(float $x,float $y,boolean $inclusive){
    //xy coordinates only :: for inside-outside testing, etc. :: ray points right, starting from the given coordinates
    float pbua1 = (p2.x-p1.x)*($y-p1.y)-(p2.y-p1.y)*($x-p1.x);
    float pbu2 = p2.y-p1.y;
    float pbub1 = $y-p1.y;
    if(pbu2==0){ return false; }
    float pbua = pbua1/pbu2;
    float pbub = pbub1/pbu2;
    if($inclusive){
      if(pbua>=0&&pbub>=0&&pbub<=1){ return true; }
    }else{
      if(pbua>0&&pbub>0&&pbub<1){ return true; }
    }
    return false;
  }
  boolean is_line_intersecting(Line $l,boolean $inclusive){
    //xy coordinates only
    float pbua1 = (p2.x-p1.x)*($l.s.p1.y-p1.y)-(p2.y-p1.y)*($l.s.p1.x-p1.x);
    float pbu2 = (p2.y-p1.y)*($l.s.p2.x-$l.s.p1.x)-(p2.x-p1.x)*($l.s.p2.y-$l.s.p1.y);
    float pbub1 = ($l.s.p2.x-$l.s.p1.x)*($l.s.p1.y-p1.y)-($l.s.p2.y-$l.s.p1.y)*($l.s.p1.x-p1.x);
    if(pbu2==0){ return false; }
    float pbua = pbua1/pbu2;
    float pbub = pbub1/pbu2;
    if($inclusive){
      if(pbub>=0&&pbub<=1){ return true; }
    }else{
      if(pbub>0&&pbub<1){ return true; }
    }
    return false;
  }
  boolean is_segment_intersecting(Segment $s,boolean $inclusive){
    //xy coordinates only
    float pbua1 = (p2.x-p1.x)*($s.p1.y-p1.y)-(p2.y-p1.y)*($s.p1.x-p1.x);
    float pbu2 = (p2.y-p1.y)*($s.p2.x-$s.p1.x)-(p2.x-p1.x)*($s.p2.y-$s.p1.y);
    float pbub1 = ($s.p2.x-$s.p1.x)*($s.p1.y-p1.y)-($s.p2.y-$s.p1.y)*($s.p1.x-p1.x);
    if(pbu2==0){ return false; }
    float pbua = pbua1/pbu2;
    float pbub = pbub1/pbu2;
    if($inclusive){
      if(pbub>=0&&pbub<=1&&pbua>=0&&pbua<=1){ return true; }
    }else{
      if(pbub>0&&pbub<1&&pbua>0&&pbua<1){ return true; }
    }
    return false;
  }
  boolean is_coord_on(float $x,float $y){
    //xy coordinates only
    float d = get_distance_to($x,$y);
    if(d<=distance_tolerance){
      return true;
    }
    return false;
  }
  float get_distance_to(float $x,float $y){
    //xy coordinates only
    float u = (($x-p1.x)*(p2.x-p1.x)+($y-p1.y)*(p2.y-p1.y))/sq(dist(p1.x,p1.y,p2.x,p2.y));
    float x = p1.x+u*(p2.x-p1.x);
    float y = p1.y+u*(p2.y-p1.y);
    if(x>p1.x&&x>p2.x){ x = max(p1.x,p2.x); }
    if(x<p1.x&&x<p2.x){ x = min(p1.x,p2.x); }
    if(y>p1.y&&y>p2.y){ y = max(p1.y,p2.y); }
    if(y<p1.y&&y<p2.y){ y = min(p1.y,p2.y); }
    return dist(x,y,$x,$y);
  }
  Point get_closest_point(float $x,float $y){
    //xy coordinates only
    float u = (($x-p1.x)*(p2.x-p1.x)+($y-p1.y)*(p2.y-p1.y))/sq(dist(p1.x,p1.y,p2.x,p2.y));
    float x = p1.x+u*(p2.x-p1.x);
    float y = p1.y+u*(p2.y-p1.y);
    if(x>p1.x&&x>p2.x){ x = max(p1.x,p2.x); }
    if(x<p1.x&&x<p2.x){ x = min(p1.x,p2.x); }
    if(y>p1.y&&y>p2.y){ y = max(p1.y,p2.y); }
    if(y<p1.y&&y<p2.y){ y = min(p1.y,p2.y); }
    Point p = new Point(x,y,0);
    return p;
  }
  Point get_intersect_point(Segment $s){
    //xy coordinates only :: must test for on-segment intersection before using this, otherwise it will project the segments as lines to their intersection point :: it will also return {9999,9999,9999} for parallel lines (should be tested for prior to using this)
    float pbua1 = (p2.x-p1.x)*($s.p1.y-p1.y)-(p2.y-p1.y)*($s.p1.x-p1.x);
    float pbu2 = (p2.y-p1.y)*($s.p2.x-$s.p1.x)-(p2.x-p1.x)*($s.p2.y-$s.p1.y);
    float x = 9999;
    float y = 9999;
    if(pbu2!=0){
      float pbua = pbua1/pbu2;
      x = $s.p1.x+($s.p2.x-$s.p1.x)*pbua;
      y = $s.p1.y+($s.p2.y-$s.p1.y)*pbua;
    }
    Point p = new Point(x,y,0);
    return p;
  }
  void echo(int $indent){
    String indent = "";
    while(indent.length()<$indent){
      indent += "  ";
    }
    println(indent+"---- SEGMENT #"+n+" ----");
    p1.echo($indent+1);
    p2.echo($indent+1);
  }
  void render(){
    beginShape();
    vertex(p1.x,p1.y,p1.z);
    vertex(p2.x,p2.y,p2.z);
    endShape();
  }
}
