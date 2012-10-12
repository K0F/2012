//------ LINE ------//
class Line{
  int n;
  float a,b;
  Segment s;
  Line(Point $p1,Point $p2){
    n = global.nlines;
    global.lines[global.nlines++] = this;
    if($p2.x-$p1.x!=0){
      a = ($p2.y-$p1.y)/($p2.x-$p1.x);
    }else{
      a = 999999999;
    }
    b = $p1.y-a*$p1.x;
    s = new Segment($p1,$p2);
  }
  void crop(){
    if(global.stage.is_splittable(this)){
      s = get_polygon_chord(global.stage);
    }
  }
  boolean is_ray_intersecting(float $x,float $y,boolean $inclusive){
    //xy coordinates only :: for inside-outside testing, etc. :: ray points right, starting from the given coordinates
    float pbua1 = (s.p2.x-s.p1.x)*($y-s.p1.y)-(s.p2.y-s.p1.y)*($x-s.p1.x);
    float pbu2 = s.p2.y-s.p1.y;
    if(pbu2==0){ return false; }
    float pbua = pbua1/pbu2;
    if($inclusive){
      if(pbua>=0){ return true; }
    }else{
      if(pbua>0){ return true; }
    }
    return false;
  }
  boolean is_line_intersecting(Line $l){
    //xy coordinates only
    float pbu2 = (s.p2.y-s.p1.y)*($l.s.p2.x-$l.s.p1.x)-(s.p2.x-s.p1.x)*($l.s.p2.y-$l.s.p1.y);
    if(pbu2==0){ return false; }
    return false;
  }
  boolean is_segment_intersecting(Segment $s,boolean $inclusive){
    if($s.is_line_intersecting(this,$inclusive)){ return true; }
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
  Segment get_polygon_chord(Polygon $p){
    //xy coordinates only
    Point[] temp1 = new Point[$p.nsegments];
    int n1 = 0;
    for(int i=0;i<$p.nsegments;i++){
      if($p.segments[i].is_line_intersecting(this,true)){
        temp1[n1] = $p.segments[i].get_intersect_point(s);
        n1++;
      }
    }
    Point p1 = new Point(9999,9999,9999);
    Point p2 = new Point(9999,9999,9999);
    if(n1>=2){
      if(n1!=2){
        //remove duplicates in case of on-point intersection
        Point[] temp2 = new Point[n1];
        int n2 = 0;
        for(int i=0;i<n1;i++){
          boolean found = false;
          for(int j=0;j<n2;j++){
            if(temp1[i].get_distance_to(temp2[j].x,temp2[j].y,temp2[j].z)<distance_tolerance){
              found = true;
              break;
            }
          }
          if(!found){
            temp2[n2] = temp1[i];
            n2++;
          }
        }
        if(n2==2){
          p1.move_to(temp2[0].x,temp2[0].y,temp2[0].z);
          p2.move_to(temp2[1].x,temp2[1].y,temp2[1].z);
        }
      }else{
        p1.move_to(temp1[0].x,temp1[0].y,temp1[0].z);
        p2.move_to(temp1[1].x,temp1[1].y,temp1[1].z);
      }
    }
    Segment s1 = new Segment(p1,p2);
    return s1;
  }
  Point get_closest_point(float $x,float $y){
    //xy coordinates only
    float u = (($x-s.p1.x)*(s.p2.x-s.p1.x)+($y-s.p1.y)*(s.p2.y-s.p1.y))/sq(dist(s.p1.x,s.p1.y,s.p2.x,s.p2.y));
    float x = s.p1.x+u*(s.p2.x-s.p1.x);
    float y = s.p1.y+u*(s.p2.y-s.p1.y);
    Point p = new Point(x,y,0);
    return p;
  }
  Point get_intersect_point(Line $l){
    //xy coordinates only
    Point p = s.get_intersect_point($l.s);
    return p;
  }
  Segment get_segment_to_line(Line $l){
    //must test for zero distance before using this function
    float p13x,p13y,p13z,p43x,p43y,p43z,p21x,p21y,p21z,d1343,d4321,d1321,d4343,d2121,pbmua,pbmub;
    p13x = s.p1.x-$l.s.p1.x; p13y = s.p1.y-$l.s.p1.y; p13z = s.p1.z-$l.s.p1.z;
    p43x = $l.s.p2.x-$l.s.p1.x; p43y = $l.s.p2.y-$l.s.p1.y; p43z = $l.s.p2.z-$l.s.p1.z;
    p21x = s.p2.x-s.p1.x; p21y = s.p2.y-s.p1.y; p21z = s.p2.z-s.p1.z;
    d1343 = p13x*p43x+p13y*p43y+p13z*p43z; d4321 = p43x*p21x+p43y*p21y+p43z*p21z; d1321 = p13x*p21x+p13y*p21y+p13z*p21z; d4343 = p43x*p43x+p43y*p43y+p43z*p43z; d2121 = p21x*p21x+p21y*p21y+p21z*p21z;
    pbmua = (d1343*d4321-d1321*d4343)/(d2121*d4343-d4321*d4321);
    pbmub = (d1343+d4321*pbmua)/d4343;
    Point p1 = new Point(s.p1.x+pbmua*p21x,s.p1.y+pbmua*p21y,s.p1.z+pbmua*p21z);
    Point p2 = new Point($l.s.p1.x+pbmub*p43x,$l.s.p1.y+pbmub*p43y,$l.s.p1.z+pbmub*p43z);
    return new Segment(p1,p2);
  }
  float get_distance_to(float $x,float $y){
    //xy coordinates only
    float u = (($x-s.p1.x)*(s.p2.x-s.p1.x)+($y-s.p1.y)*(s.p2.y-s.p1.y))/sq(dist(s.p1.x,s.p1.y,s.p2.x,s.p2.y));
    float x = s.p1.x+u*(s.p2.x-s.p1.x);
    float y = s.p1.y+u*(s.p2.y-s.p1.y);
    return dist(x,y,$x,$y);
  }
  void echo(int $indent){
    String indent = "";
    while(indent.length()<$indent){
      indent += "  ";
    }
    println(indent+"---- LINE #"+n+" ----");
    println(indent+"a: "+a+"  b: "+b);
    s.echo($indent+1);
  }
  void render(){
    s.render();
  }
}
