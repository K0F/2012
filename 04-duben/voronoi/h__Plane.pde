class Plane{
  Vector nv;
  int n;
  float d;
  Point p1,p2,p3;
  Vector pv1,pv2,pv3,v12,v23,v31;
  Plane(Point $p1,Point $p2,Point $p3){
    p1 = $p1; p2 = $p2; p3 = $p3;
    n = global.nplanes;
    global.planes[global.nplanes++] = this;
    v12 = new Vector(p2.x-p1.x,p2.y-p1.y,p2.z-p1.z); v23 = new Vector(p3.x-p2.x,p3.y-p2.y,p3.z-p2.z); v31 = new Vector(p1.x-p3.x,p1.y-p3.y,p1.z-p3.z);
    nv = get_normal();
    d = get_d();
  }
  Vector get_normal(){
    v12.vx = p2.x-p1.x; v12.vy = p2.y-p1.y; v12.vz = p2.z-p1.z; v23.vx = p3.x-p2.x; v23.vy = p3.y-p2.y; v23.vz = p3.z-p2.z;
    nv = cross_product(v12,v23);
    nv.unitize();
    nv.scale(100);
    return nv;
  }
  float get_d(){
    d = -dot_product_1p(nv,p1);
    return d;
  }
  int get_point_side(Point $p){
    float side = dot_product_1p(nv,$p)-d;
    if(side<0){ return 1; }
    if(side>0){ return -1; }
    return 0;
  }
  boolean is_plane_parallel(Plane $pl1){
    Vector v = cross_product($pl1.nv,nv);
    if(v.m==0){ return true; }
    return false;
  }
  boolean is_line_intersecting(Line $l){
    float pbmud = nv.vx*($l.s.p2.x-$l.s.p1.x)+nv.vy*($l.s.p2.y-$l.s.p1.y)+nv.vz*($l.s.p2.z-$l.s.p1.z);
    if(pbmud==0){ return false; } //plane and line do not intersect
    return true;
  }
  boolean is_segment_intersecting(Segment $s,boolean $inclusive){
    float pbmud,pbmu;
    nv = get_normal();
    d = get_d();
    pbmud = nv.vx*($s.p2.x-$s.p1.x)+nv.vy*($s.p2.y-$s.p1.y)+nv.vz*($s.p2.z-$s.p1.z);
    if(pbmud==0){ return false; } //plane and line do not intersect
    pbmu = -(d+nv.vx*$s.p1.x+nv.vy*$s.p1.y+nv.vz*$s.p1.z)/pbmud;
    if($inclusive){ if(pbmu<0||pbmu>1){ return false; } }else{ if(pbmu<=0||pbmu>=1){ return false; } } //intersection is not on segment
    return true;
  }
  Point get_3plane_intersection_point(Plane $pl1,Plane $pl2){
    //must check for parallel planes first
    Vector n12,n23,n31; float px,py,pz,pbden;
    nv = get_normal();
    d = get_d();
    n12 = cross_product($pl1.nv,$pl2.nv); n23 = cross_product($pl2.nv,nv); n31 = cross_product(nv,$pl1.nv);
    pbden = dot_product($pl1.nv,n23);
    px = ($pl1.d*n23.vx+$pl2.d*n31.vx+d*n12.vx)/pbden;
    py = ($pl1.d*n23.vy+$pl2.d*n31.vy+d*n12.vy)/pbden;
    pz = ($pl1.d*n23.vz+$pl2.d*n31.vz+d*n12.vz)/pbden;
    return new Point(px,py,pz);
  }
  void echo(int $indent){
    String indent = "";
    while(indent.length()<$indent){
      indent += "  ";
    }
    println(indent+"---- PLANE #"+n+" ----");
    nv.echo($indent+1);
  }
}
