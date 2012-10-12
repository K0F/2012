import nervoussystem.obj.*;
boolean record;

void setup() {
  size(400, 400,P3D);
}

void draw() {
  if (record) {
    beginRecord("nervoussystem.obj.OBJExport", "/home/kof/filename.obj"); 
  }  
  
  
  beginShape(QUAD_STRIP);
  for(int i =0 ;i< 512;i++){
    vertex(noise(i/5.0,0,0)-0.5,noise(0,i/5.0,0)-.5,noise(0,0,i/5.0)-.5);
    
  }
  
  endShape();
  
  if (record) {
    endRecord();
    record = false;
  }
}

void mousePressed() {
  record = true;
}
