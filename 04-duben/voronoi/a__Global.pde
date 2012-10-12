float distance_tolerance = .0001;
float slope_tolerance = .001;
float angle_tolerance = .001;
float point_speed = .1;
Point zero_point;
Global global;

//------ GLOBAL ------//
//the global class holds all other default classes
//its only purpose is for organization and to imitate actionscript
class Global{
  int npoints,nsegments,nvectors,nlines,npolygons,npolylines,nplanes,nfaces;
  Point[] points = new Point[1000000]; Segment[] segments = new Segment[1000000]; Vector[] vectors = new Vector[1000000]; Line[] lines = new Line[1000000]; Polygon[] polygons = new Polygon[100000]; Polyline[] polylines = new Polyline[100000]; Plane[] planes = new Plane[100000]; Face[] faces = new Face[100000];
  Polygon stage;
  Global(){
    npoints = nsegments = nvectors = nlines = npolygons = npolylines = nplanes = nfaces = 0;
  }
  void init(){
    Point[] ps = new Point[4]; ps[0] = new Point(-width/2,-height/2,0); ps[1] = new Point(width/2,-height/2,0); ps[2] = new Point(width/2,height/2,0); ps[3] = new Point(-width/2,height/2,0);
    stage = new Polygon(ps);
    zero_point = new Point(0,0,0);
  }
  void echo(){
    println("---- GLOBAL ----");
    println("Points: "+npoints);
    println("Segments: "+nsegments);
    println("Vectors: "+nvectors);
    println("Lines: "+nlines);
    println("Polygons: "+npolygons);
    println("Polylines: "+npolylines);
    println("Planes: "+nplanes);
    println("Faces: "+nfaces);
  }
  void render(int $n){
    if($n>=128){
      for(int i=0;i<nfaces;i++){
        fill(255,240,240);
        stroke(255);
        strokeWeight(1);
        faces[i].render();
      }
      $n -= 128;
    }
    if($n>=64){
      for(int i=0;i<npolylines;i++){
        fill(255,250,250);
        stroke(0);
        strokeWeight(1);
        polylines[i].render();
      }
      $n -= 64;
    }
    if($n>=32){
      for(int i=0;i<npolygons;i++){
        fill(255,250,250);
        stroke(0);
        strokeWeight(1);
        polygons[i].render();
      }
      $n -= 32;
    }
    if($n>=16){
      noFill();
      stroke(0,0,255);
      strokeWeight(1);
      for(int i=0;i<nlines;i++){
        lines[i].render();
      }
      $n -= 16;
    }
    if($n>=8){
      noFill();
      stroke(0,255,255);
      strokeWeight(1);
      for(int i=0;i<nvectors;i++){
        vectors[i].render(zero_point);
      }
      $n -= 8;
    }
    if($n>=4){
      noFill();
      stroke(255,0,255);
      strokeWeight(1);
      for(int i=0;i<nsegments;i++){
        segments[i].render();
      }
      $n -= 4;
    }
    if($n>=2){
      fill(0);
      stroke(0);
      strokeWeight(1);
      for(int i=0;i<npoints;i++){
        points[i].render();
      }
      $n -= 2;
    }
    if($n>=1){
      noFill();
      stroke(255,0,0);
      strokeWeight(1);
      stage.render();
      $n -= 1;
    }
  }
}
