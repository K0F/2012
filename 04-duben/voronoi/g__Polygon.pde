//------ POLYGON ------//
class Polygon{
  int n,npoints,nsegments;
  Point[] points = new Point[1000];
  Segment[] segments = new Segment[1000];
  Polygon(Point[] $points){
    n = global.npolygons;
    global.polygons[global.npolygons++] = this;
    npoints = nsegments = 0;
    for(int i=0;i<$points.length;i++){
      add_point($points[i]);
    }
  }
  void reset(){
    for(int i=0;i<nsegments;i++){
      segments[i].reset();
    }
  }
  void add_point(Point $p){
    for(int i=0;i<npoints;i++){
      if($p.get_distance_to(points[i].x,points[i].y,points[i].z)<distance_tolerance){ return; }
    }
    points[npoints] = $p;
    npoints++;
    if(npoints>2){
      if(npoints==3){
        //create first closing segment
        segments[nsegments] = new Segment(points[npoints-2],points[npoints-1]);
        segments[nsegments+1] = new Segment(points[npoints-1],points[0]);
        nsegments += 2;
      }else{
        //replace closing segment
        segments[nsegments-1] = new Segment(points[npoints-2],points[npoints-1]);
        segments[nsegments] = new Segment(points[npoints-1],points[0]);
        nsegments++;
      }
    }else if(npoints>1){
      segments[nsegments] = new Segment(points[npoints-2],points[npoints-1]);
      nsegments++;
    }
  }
  void delete_point(Point $p){
    //this is not an efficient way to remove points, just the easiest :: for reducing lots of large polygons, this should target only the segment to be removed, rather than rebuilding the entire polygon
    int ntemp = npoints;
    Point[] temp = new Point[1000];
    arraycopy(points,temp);
    points = new Point[1000];
    npoints = 0;
    nsegments = 0;
    for(int i=0;i<ntemp;i++){
      if(temp[i]!=$p){
        add_point(temp[i]);
      }
    }
  }
  Polygon get_bounding_box(){
    //xy coordinates only
    float xmin = 9999; float ymin = 9999; float xmax = -9999; float ymax = -9999;
    for(int i=0;i<npoints;i++){
      xmin = min(points[i].x,xmin);
      ymin = min(points[i].y,ymin);
      xmax = max(points[i].x,xmax);
      ymax = max(points[i].y,ymax);
    }
    Point[] ps = new Point[4]; ps[0] = new Point(xmin,ymin,0); ps[1] = new Point(xmax,ymin,0); ps[2] = new Point(xmax,ymax,0); ps[3] = new Point(xmin,ymax,0);
    Polygon p = new Polygon(ps);
    return p;
  }
  void simplify(){
    //xy coordinates only
    if(nsegments>2){
      for(int i=0;i<nsegments;i++){
        if(abs(segments[i].get_slope()-segments[(i+1)%nsegments].get_slope())<slope_tolerance){
          delete_point(points[(i+1)%npoints]);
          simplify();
          break;
        }
      }
    }
  }
  boolean is_complex(){
    //xy coordinates only
    for(int i=0;i<nsegments;i++){
      for(int j=i+1;j<nsegments;j++){
        if(j==i+1||j==(i+nsegments-1)%nsegments){
          if(segments[i].is_segment_intersecting(segments[j],false)){ return true; }
        }else{
          if(segments[i].is_segment_intersecting(segments[j],true)){ return true; }
        }
      }
    }
    return false;
  }
  boolean is_coord_inside(float $x,float $y,boolean $inclusive){
    //xy coordinates only
    int ints = 0;
    for(int i=0;i<nsegments;i++){
      if(segments[i].is_ray_intersecting($x,$y,$inclusive)){
        ints++;
      }
    }
    if(ints%2==0){ return false; }
    return true;
  }
  boolean is_splittable(Line $l){
    //xy coordinates only
    if(is_complex()){ return false; }
    int ints = 0;
    for(int i=0;i<npoints;i++){
      if($l.is_coord_on(points[i].x,points[i].y)){
        ints++;
      }else if($l.is_segment_intersecting(segments[i],false)){
        ints++;
      }
    }
    if(ints==2){ return true; }
    return false;
  }
  float get_distance_to(float $x,float $y){
    //xy coordinates only
    float d = segments[0].get_distance_to($x,$y);
    for(int i=1;i<nsegments;i++){
      float temp = segments[i].get_distance_to($x,$y);
      if(temp<d){ d = temp; }
    }
    return d;
  }
  Point get_closest_point(float $x,float $y){
    //xy coordinates only
    float d = segments[0].get_distance_to($x,$y);
    Point p = segments[0].get_closest_point($x,$y);
    for(int i=1;i<nsegments;i++){
      float temp = segments[i].get_distance_to($x,$y);
      if(temp<d){
        d = temp;
        p = segments[i].get_closest_point($x,$y);
      }
    }
    return p;
  }
  Point get_centroid_point(){
    float xs = 0; float ys = 0; float zs = 0;
    for(int i=0;i<npoints;i++){
      xs += points[i].x; ys += points[i].y; zs += points[i].z;
    }
    xs /= npoints; ys /= npoints; zs /= npoints;
    Point p = new Point(xs,ys,zs);
    return p;
  }
  Polygon get_convex_hull(){
    //xy coordinates only :: returns the convex hull for this polygon's set of points :: this is a relatively costly function as it is scripted here
    int ip = 0; int ntemp = 0; Point[] temp = new Point[1000]; float[] as = new float[1000]; float[] ds = new float[1000];
    //find the topmost point
    for(int i=1;i<npoints;i++){
      if(points[i].y<points[ip].y){ ip = i; }
    }
    //if two points are colinear with the topmost point, take only the one furthest away
    for(int i=0;i<npoints;i++){
      if(i!=ip){
        float a = (atan2(points[ip].y-points[i].y,points[ip].x-points[i].x)+PI)%(TWO_PI);
        float d = dist(points[ip].x,points[ip].y,points[i].x,points[i].y);
        if(d>0){
          boolean found = false;
          for(int j=0;j<ntemp;j++){
            if(a==as[j]){
              if(d>ds[j]){
                //remove the closer point
                Point[] temp1 = (Point[]) subset(temp,0,j); Point[] temp2 = (Point[]) subset(temp,j+1,temp.length-(j+1)); temp = (Point[]) concat(temp1,temp2);
                float[] as1 = subset(as,0,j); float[] as2 = subset(as,j+1,temp.length-(j+1)); as = concat(as1,as2);
                float[] ds1 = subset(ds,0,j); float[] ds2 = subset(ds,j+1,temp.length-(j+1)); ds = concat(ds1,ds2);
                ntemp--; j--;
              }else{
                //skip this point
                found = true;
                break;
              }
            }
          }
          if(!found){
            //add point to array
            temp[ntemp] = points[i]; as[ntemp] = a; ds[ntemp] = d;
            ntemp++;
          }
        }
      }
    }
    //bubble sort the arrays according to angle
    for(int i=0;i<ntemp-1;i++){
      for(int j=0;j<ntemp-1-i;j++){
        if(as[j]>as[j+1]){
          Point temp1 = temp[j]; temp[j] = temp[j+1]; temp[j+1] = temp1;
          float as1 = as[j]; as[j] = as[j+1]; as[j+1] = as1;
        }
      }
    }
    temp[ntemp] = points[ip];
    ntemp++;
    temp = (Point[]) subset(temp,0,ntemp);
    temp = (Point[]) reverse(temp);
    //find convex hull points
    if(ntemp>3){
      for(int i=0;i<ntemp;i++){
        float pbside = (temp[(i+1+ntemp)%ntemp].y-temp[(i+ntemp)%ntemp].y)*(temp[(i+2+ntemp)%ntemp].x-temp[(i+ntemp)%ntemp].x)-(temp[(i+1+ntemp)%ntemp].x-temp[(i+ntemp)%ntemp].x)*(temp[(i+2+ntemp)%ntemp].y-temp[(i+ntemp)%ntemp].y);
        if(pbside<0){
          //remove the point if it lies on the wrong side
          if((i+1+ntemp)%ntemp==0){
            temp = (Point[]) subset(temp,1,ntemp-1);
          }else if((i+1+ntemp)%ntemp==ntemp-1){
            temp = (Point[]) subset(temp,0,ntemp-1);
          }else{
            Point[] temp1 = (Point[]) subset(temp,0,(i+1+ntemp)%ntemp);
            Point[] temp2 = (Point[]) subset(temp,(i+2+ntemp)%ntemp,ntemp-(i+2+ntemp)%ntemp);
            temp = (Point[]) concat(temp1,temp2);
          }
          i -= 2; ntemp--;
          temp = (Point[]) subset(temp,0,ntemp);
        }
      }
    }
    //return new polygon
    temp = (Point[]) subset(temp,0,ntemp);
    Polygon p = new Polygon(temp);
    p.simplify();
    return p;
  }
  Polygon[] split(Line $l){
    //xy coordinates only :: must test to make sure it is a simple polygon first or you'll get strange results
    int ip = 0; Point[] ints = new Point[npoints]; float[] intsi = new float[npoints+2]; int nints = 0; Point[] temp1 = new Point[npoints+2]; float[] temp1i = new float[npoints+2]; int ntemp1 = 0; Point[] temp2 = new Point[npoints+2]; int ntemp2 = 0;
    for(int i=0;i<npoints;i++){
      if($l.is_coord_on(points[i].x,points[i].y)){
        ints[nints] = points[i]; intsi[nints] = i; nints++;
        temp1[ntemp1] = points[i]; temp1i[ntemp1] = i; ntemp1++;
        ip = i;
      }else if($l.is_segment_intersecting(segments[i],false)){
        Point lint = $l.s.get_intersect_point(segments[i]);
        ints[nints] = lint; intsi[nints] = i+0.5; nints++;
        if(nints%2==0){ temp1[ntemp1] = points[i]; temp1i[ntemp1] = i; ntemp1++; }
        temp1[ntemp1] = lint; temp1i[ntemp1] = i+0.5; ntemp1++; 
        ip = i;
      }else if(nints%2==1){
        temp1[ntemp1] = points[i]; temp1i[ntemp1] = i; ntemp1++;
      }
    }
    for(int i=ip;i<ip+npoints;i++){
      boolean found = false;
      for(int j=0;j<ntemp1;j++){
        if(i%npoints==temp1i[j]){ found = true; break; }
      }
      if(!found){ temp2[ntemp2] = points[i%npoints]; ntemp2++; }
    }
    temp2[ntemp2] = ints[0]; ntemp2++;
    temp2[ntemp2] = ints[1]; ntemp2++;
    temp1 = (Point[]) subset(temp1,0,ntemp1);
    temp2 = (Point[]) subset(temp2,0,ntemp2);
    Polygon p1 = new Polygon(temp1);
    Polygon p2 = new Polygon(temp2);
    Polygon[] ps = {p1,p2};
    return ps;
  }
  void echo(int $indent){
    String indent = "";
    while(indent.length()<$indent){
      indent += "  ";
    }
    println(indent+"---- POLYGON #"+n+" ----");
    for(int i=0;i<nsegments;i++){
      segments[i].echo($indent+1);
    }
  }
  void render(){
    beginShape();
    for(int i=0;i<npoints;i++){
      vertex(points[i].x,points[i].y,points[i].z);
    }
    endShape(CLOSE);
    /*
    for(int i=0;i<npoints;i++){
      points[i].render();
    }
    */
  }
}
