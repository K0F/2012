Parser parser;

void setup(){
  size(640,640,P3D);
  parser = new Parser("skeleton.bvh");
  
}

void draw(){
 background(255);

 parser.drawHieratical(); 
 parser.draw();  
}
