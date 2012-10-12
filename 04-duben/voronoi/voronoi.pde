import processing.opengl.*;

Voronoi diagram;

Point[] ps;

void setup(){
  size(400,400,OPENGL);
  //initialize global
  global = new Global();
  global.init();
  //initialize voronoi diagram
  ps = new Point[100];
  for(int i=0;i<ps.length;i++){
    ps[i] = new Point(random(-width/2,width/2),random(-height/2,height/2),0);
  }
  diagram = new Voronoi(ps,global.stage);
}

void draw(){
  
  move();
  
  render();
}

void move(){
 for(int i =0 ; i < ps.length;i++){
  ps[i] = new Point(ps[i].x+1,ps[i].y+1,0);
 } 
 
 diagram = new Voronoi(ps,global.stage);
}

void render(){
  Cell c = diagram.get_containing_cell(mouseX-width/2,mouseY-height/2);
  pushMatrix();
  background(255);
  translate(width/2,height/2,0);
  stroke(0,100);
  strokeWeight(1);
  noFill();
  diagram.render();
  fill(255,150,150,150);
  stroke(0);
  strokeWeight(1);
  c.render();
  popMatrix();
}

void mousePressed(){
  Point p = new Point(mouseX-width/2,mouseY-height/2,0);
  diagram.add_cell(p);
  render();
}
