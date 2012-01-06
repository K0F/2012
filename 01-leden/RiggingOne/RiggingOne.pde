

import saito.objloader.*;
OBJModel model;
Parser parser;
PFont font;

boolean animate = false;

void setup() {
  size(512, 512, P3D);


  parser = new Parser("skeleton.bvh");

  font = loadFont("SempliceRegular-8.vlw"); 
  textFont(font);
  textMode(SCREEN);


  model = new OBJModel(this, "weird.obj", OBJModel.RELATIVE, QUADS);
}

void draw() {
  background(255);

  ambientLight(100, 100, 97);


  pushMatrix();

  translate(width/2, height/2, 0);

  rotateY(frameCount/80.0);

  scale(20.);
  noStroke();

  pointLight(255, 255, 250, 0, -150, 150.);
  pointLight(noise(frameCount/301.0)*70, noise(frameCount/301.1)*70, noise(frameCount/301.2)*75, width, -150, 150.);



 // model.draw(); 

  stroke(0);

  // parser.draw();
  parser.drawHieratical();
  popMatrix();
}




void rig() {

  for (int nod = 1;nod < parser.nodes.size();nod++) {
    Node n1 = (Node)parser.nodes.get(nod);
    Node n2 = n1.parent;
    
    for (int i =3 ; i < model.getFaceCount();i++) {
      Face f = model.getFaceInSegment(0, i);

      for (int ii = 1;ii<f.vertices.size();ii++) {
        PVector vert = f.vertices.get(ii);
        
        if(CylTest_CapsFirst(n1.pos,n2.pos,1.0,10.,vert)<0.4){
          point(vert.x,vert.y,vert.z);
          
        }
        
        //PVector uv = f.uvs.get(ii);
        //PVector nor = f.uvs.get(ii);
      }
    }
  }
}

