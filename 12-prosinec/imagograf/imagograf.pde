import processing.opengl.*;

import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

String _lon, _lat;

GPSTrack trasa;
boolean debug = true;

PeasyCam cam;

/////////////////////////////////////////

void setup() {
  size(900, 900, P3D);
  textFont(loadFont("Monaco-10.vlw"));
  textMode(SCREEN);
  noSmooth();
  
  cam = new PeasyCam(this, 700);
  cam.lookAt(width/2,height/2,0);
  
  trasa = new GPSTrack(this, "Tracks_2012_11_27_imagoZPET.xml", "Sweep-Recording_2012-11-26_1315nove.csv");
}

void draw() {
  background(0);
  
  trasa.plot();
}

