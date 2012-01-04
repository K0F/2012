Parser parser;

void setup(){
  size(320,320,P3D);
  parser = new Parser("skeleton.bvh");
  
}

void draw(){
 background(255);

 parser.draw(); 
  
}
