class Polyline{
  Segment[] segments = new Segment[1000];
  int nsegments = 0;
  int n;
  Polyline(Segment[] $segments){
    segments = $segments;
    nsegments = segments.length;
    n = global.npolylines;
    global.polylines[global.npolylines++] = this;
  }
  float get_length(){
    float l = 0;
    for(int i=0;i<nsegments;i++){
      l += segments[i].get_length();
    }
    return l;
  }
  void echo(int $indent){
    String indent = "";
    while(indent.length()<$indent){
      indent += "  ";
    }
    println(indent+"---- POLYLINE #"+n+" ----");
    for(int i=0;i<nsegments;i++){
      segments[i].echo($indent+1);
    }
  }
  void render(){
    for(int i=0;i<nsegments;i++){
      segments[i].render();
    }
  }
}
