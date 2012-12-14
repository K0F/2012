class TrackPoint {
  PVector pos;

  float lat, lon, ele;

  String time;
  String name;

  TrackPoint(String _lat, String _lon) {
    lat = parseFloat(_lat);
    lon = parseFloat(_lon);
  }

  void plot() {
    /*pushMatrix();
    translate(pos.x, pos.y);
    point(0, 0);
    popMatrix();*/
    
    curveVertex(pos.x,pos.y,pos.z);
    
    float xx = screenX(pos.x,pos.y,pos.z);
    float yy = screenY(pos.x,pos.y,pos.z);
    
    cam.beginHUD();
    fill(255,50);
    text(time,xx,yy);
    noFill();
    cam.endHUD();
  }

  void setTime(String _in) {
    if (debug)
      println("time: "+_in);
    time = _in;
  }

  void setEle(float _in) {
    if (debug)
      println("elevation: "+_in);
    ele = _in;
  }

  void setName(String _in) {
    if (debug)
      println("name: "+_in);
    name = _in;
  }


  /*
  TrackPoint(long _lat, long _lon, long _alt, String _time, String _id) {
   lat=_lat;
   lon=_lon;
   alt=_alt;
   time=_time;
   id = _id;
   }
   */
}

