/**
*    Blind Wanderer by kof 2012
*/


import saito.objloader.*;
OBJModel model,origos;
float rotX;
float rotX2 = HALF_PI;
float rotY;


PGraphics t;
PImage original;

PGraphics post;

void setup()
{
  size(700, 300, P3D);
  frameRate(25);
  
  textFont(loadFont("SempliceRegular-8.vlw"));
  textMode(SCREEN);
  
  model = new OBJModel(this, "weird.obj", OBJModel.RELATIVE, QUADS);
  origos = new OBJModel(this, "weird.obj", OBJModel.RELATIVE, QUADS);
 
  model.enableTexture();
  
  noStroke();
 
  background(0);
  
  
  noiseSeed(19);
background(0);

}

/////////////////////////////////////////////////

void draw()
{

  background(0);
 
  pushMatrix();
  translate(width/2, height/2+450, (-noise(frameCount/40.0)-0.5)*30.);
  perspective((noise(frameCount/40.0)-0.5)*1.+45, width/height, 20, 500);
  rotateX(rotY);
  rotateY(rotX+=0.008);

  PVector stab = model.getVertex(15305).get();
  
  scale(25.0);
  translate(-stab.x,-stab.y-5,-stab.z);
  
  stroke(255,20);
  for (int i= 1;i<model.getVertexCount();i++) {
    
PVector ref = model.getVertex(i).get();    
    
    PVector orig = origos.getVertex(i).get();
    PVector nor = origos.getNormal(i).get();
    
   
    
    float ler = 0;//(-0.2+noise((orig.y+ref.z+orig.z*noise(orig.y+frameCount/12.3)*3.0)/5.0+frameCount/100.0))*1.5;
    
    model.setVertex(i,new PVector(
    lerp(orig.x,orig.x+nor.x,ler)+(noise(orig.y/160.3+frameCount/150.0)-0.5)*15,
    lerp(orig.y,orig.y+nor.y,ler)+(noise(orig.x/160.2+frameCount/150.0)-0.5)*40,
    lerp(orig.z,orig.z+nor.z,ler)+(noise((orig.x)/200.1+frameCount/130.0)-0.5)*40
    ));
  }
  
  noStroke();
 
PVector s = model.getVertex(12000).get();

  pushMatrix();
  translate(-s.x,-s.y-15,-s.z);
  
  rotateY(rotX2+=0.234);
   pointLight(noise(frameCount/300.0)*255, noise(frameCount/300.1)*255, noise(frameCount/300.2)*200, 0, -150, 150.);
  pointLight(noise(frameCount/301.0)*70, noise(frameCount/301.1)*70, noise(frameCount/301.2)*75, width, -150, 150.);
  pointLight(noise(frameCount/300.0)*255, noise(frameCount/300.1)*255, noise(frameCount/300.2)*200, 0, 0, 150.);
  pointLight(noise(frameCount/301.0)*70, noise(frameCount/301.1)*70, noise(frameCount/301.2)*75, width, 0, 150.);
 //lights();
  noFill();
  noStroke();//stroke(0);
  strokeWeight(180);
  fill(255);
  translate(0,-50,600);
  box(330);
  noStroke();
  popMatrix();

  model.draw();
 
  popMatrix();
  
  ///////////////////// postproc
  
   int randX = 0;//(int)random(-1,2); 
   int randY = 0;//(int)random(-1,2); 
 
  
  for(int i =0 ;i<1;i++){
   fastblur(g,(int)(noise(i+frameCount/5.0)*3)+1);
   blend(g,0,0,width,height,0+randX,0+randY,width+randX,height+randY,ADD);
   
   fastblur(g,(int)(noise(i+frameCount/6.0)*4));
   blend(g,0,0,width,height,0+randX,0+randY,width+randX,height+randY,OVERLAY);
   
   fastblur(g,(int)(noise(i+frameCount/6.5)*4));
   blend(g,0,0,width,height,0+randX,0+randY,width+randX,height+randY,LIGHTEST);
  }
   resetMatrix();
   fill(120);
   text("kof 12",width-40,height-10);
   
}

