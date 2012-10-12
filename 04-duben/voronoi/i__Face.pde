class Face extends Polygon{
  Point p1,p2,p3;
  Plane pl;
  Face(Point[] $points){
    super($points);
    p1 = $points[0]; p2 = $points[1]; p3 = $points[2];
    pl = new Plane(p1,p2,p3);
  }
  void orient(Point $p){
    if(pl.get_point_side($p)>0){
      flip();
    }
  }
  void flip(){
    Point tp2 = p2;
    p2 = p3; p3 = tp2;
  }
  boolean is_acute(){
    float d1,d2,d3,x,h,y,a1,a2,a3;
    d1 = p1.get_distance_to(p2.x,p2.y,p2.z); d2 = p2.get_distance_to(p3.x,p3.y,p3.z); d3 = p3.get_distance_to(p1.x,p1.y,p1.z);
    x = (sq(d1)+sq(d2)-sq(d3))/(2*d2); h = sqrt(sq(d1)-sq(x)); y = d2-x;
    a1 = (atan(h/x)+PI)%PI; a2 = (atan(h/y)+PI)%PI; a3 = PI-(a1+a2);
    if(a1<HALF_PI&&a2<HALF_PI&&a3<HALF_PI){ return true; }
    return false;
  }
  Point get_incenter_point(){
    float d1,d2,d3; Point p;
    d1 = p2.get_distance_to(p3.x,p3.y,p3.z); d2 = p3.get_distance_to(p1.x,p1.y,p1.z); d3 = p1.get_distance_to(p2.x,p2.y,p2.z);
    p = new Point(((d1*p1.x)+(d2*p2.x)+(d3*p3.x))/(d1+d2+d3),((d1*p1.y)+(d2*p2.y)+(d3*p3.y))/(d1+d2+d3),((d1*p1.z)+(d2*p2.z)+(d3*p3.z))/(d1+d2+d3));
    return p;
  }
  Point get_circumcenter_point(){
    Vector p12,p23,n12,n23; Point mid12,mid23; Line l12,l23; Segment s;
    pl.nv = pl.get_normal();
    p12 = new Vector(p2.x-p1.x,p2.y-p1.y,p2.z-p1.z); p23 = new Vector(p3.x-p2.x,p3.y-p2.y,p3.z-p2.z);
    n12 = cross_product(pl.nv,p12); n23 = cross_product(pl.nv,p23);
    mid12 = new Point((p2.x+p1.x)/2,(p2.y+p1.y)/2,(p2.z+p1.z)/2); mid23 = new Point((p3.x+p2.x)/2,(p3.y+p2.y)/2,(p3.z+p2.z)/2);
    l12 = new Line(mid12,new Point(mid12.x+n12.vx,mid12.y+n12.vy,mid12.z+n12.vz));
    l23 = new Line(mid23,new Point(mid23.x+n23.vx,mid23.y+n23.vy,mid23.z+n23.vz));
    s = l12.get_segment_to_line(l23);
    return s.p1;
  }
  boolean is_line_intersecting(Line $l){
    float pbmud,pbmu,px,py,pz,pa1x,pa1y,pa1z,pa1m,pa2x,pa2y,pa2z,pa2m,pa3x,pa3y,pa3z,pa3m,a;
    pl.nv = pl.get_normal();
    pl.d = pl.get_d();
    pbmud = pl.nv.vx*($l.s.p2.x-$l.s.p1.x)+pl.nv.vy*($l.s.p2.y-$l.s.p1.y)+pl.nv.vz*($l.s.p2.z-$l.s.p1.z);
    if(pbmud==0){ return false; } //plane and line do not intersect
    pbmu = -(pl.d+pl.nv.vx*$l.s.p1.x+pl.nv.vy*$l.s.p1.y+pl.nv.vz*$l.s.p1.z)/pbmud;
    px = $l.s.p1.x+pbmu*($l.s.p2.x-$l.s.p1.x); py = $l.s.p1.y+pbmu*($l.s.p2.y-$l.s.p1.y); pz = $l.s.p1.z+pbmu*($l.s.p2.z-$l.s.p1.z);
    pa1x = p1.x-px; pa1y = p1.y-py; pa1z = p1.z-pz; pa1m = mag(pa1x,pa1y,pa1z); pa1x /= pa1m; pa1y /= pa1m; pa1z /= pa1m;
    pa2x = p2.x-px; pa2y = p2.y-py; pa2z = p2.z-pz; pa2m = mag(pa2x,pa2y,pa2z); pa2x /= pa2m; pa2y /= pa2m; pa2z /= pa2m;
    pa3x = p3.x-px; pa3y = p3.y-py; pa3z = p3.z-pz; pa3m = mag(pa3x,pa3y,pa3z); pa3x /= pa3m; pa3y /= pa3m; pa3z /= pa3m;
    a = acos(pa1x*pa2x+pa1y*pa2y+pa1z*pa2z)+acos(pa2x*pa3x+pa2y*pa3y+pa2z*pa3z)+acos(pa3x*pa1x+pa3y*pa1y+pa3z*pa1z);
    if(abs(a-TWO_PI)>angle_tolerance){ return false; } //intersection is not within face
    return true;
  }
  boolean is_segment_intersecting(Segment $s,boolean $inclusive){
    float pbmud,pbmu,px,py,pz,pa1x,pa1y,pa1z,pa1m,pa2x,pa2y,pa2z,pa2m,pa3x,pa3y,pa3z,pa3m,a;
    pl.nv = pl.get_normal();
    pl.d = pl.get_d();
    pbmud = pl.nv.vx*($s.p2.x-$s.p1.x)+pl.nv.vy*($s.p2.y-$s.p1.y)+pl.nv.vz*($s.p2.z-$s.p1.z);
    if(pbmud==0){ return false; } //plane and line do not intersect
    pbmu = -(pl.d+pl.nv.vx*$s.p1.x+pl.nv.vy*$s.p1.y+pl.nv.vz*$s.p1.z)/pbmud;
    if($inclusive){ if(pbmu<0||pbmu>1){ return false; } }else{ if(pbmu<=0||pbmu>=1){ return false; } } //intersection is not on segment
    px = $s.p1.x+pbmu*($s.p2.x-$s.p1.x); py = $s.p1.y+pbmu*($s.p2.y-$s.p1.y); pz = $s.p1.z+pbmu*($s.p2.z-$s.p1.z);
    pa1x = p1.x-px; pa1y = p1.y-py; pa1z = p1.z-pz; pa1m = mag(pa1x,pa1y,pa1z); pa1x /= pa1m; pa1y /= pa1m; pa1z /= pa1m;
    pa2x = p2.x-px; pa2y = p2.y-py; pa2z = p2.z-pz; pa2m = mag(pa2x,pa2y,pa2z); pa2x /= pa2m; pa2y /= pa2m; pa2z /= pa2m;
    pa3x = p3.x-px; pa3y = p3.y-py; pa3z = p3.z-pz; pa3m = mag(pa3x,pa3y,pa3z); pa3x /= pa3m; pa3y /= pa3m; pa3z /= pa3m;
    a = acos(pa1x*pa2x+pa1y*pa2y+pa1z*pa2z)+acos(pa2x*pa3x+pa2y*pa3y+pa2z*pa3z)+acos(pa3x*pa1x+pa3y*pa1y+pa3z*pa1z);
    if(abs(a-TWO_PI)>angle_tolerance){ return false; } //intersection is not within face
    return true;
  }
  boolean cull(){
    float p1x,p1y,p2x,p2y,p3x,p3y;
    p1x = screenX(p1.x,p1.y,p1.z); p1y = screenY(p1.x,p1.y,p1.z);
    p2x = screenX(p2.x,p2.y,p2.z); p2y = screenY(p2.x,p2.y,p2.z);
    p3x = screenX(p3.x,p3.y,p3.z); p3y = screenY(p3.x,p3.y,p3.z);
    if(((p2y-p1y)/(p2x-p1x)-(p3y-p1y)/(p3x-p1x)<0)^(p1x<=p2x==p1x>p3x)){ return false; }
    return true;
  }
  void render(boolean $cull){
    if(!$cull||!cull()){
      super.render();
    }
  }
}
