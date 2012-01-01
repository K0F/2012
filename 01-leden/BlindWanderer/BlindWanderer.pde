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
  
  //original = loadImage("texture.png");
  model = new OBJModel(this, "oldman.obj", OBJModel.RELATIVE, QUADS);
  origos = new OBJModel(this, "oldman.obj", OBJModel.RELATIVE, QUADS);
  // model.scale(25.);
  //model.clampUV();
  noSmooth();
  // model.enableTexture();
  // tmpmodel = new OBJModel(this);
  //model.enableDebug();
  println(	model.getTexturePathMode() );
  //model.enableMaterial();
  // model.texture(t);
  model.enableTexture();
  // model.enableMaterial();
  // model.translateToCenter();
  // tmpmodel.load("skull.obj");
  noStroke();
  // smooth();
  //t = createGraphics(original.width, original.height, P2D);
  background(0);
  
  
  post = createGraphics(width,height,P2D);
  
  noiseSeed(19);
background(0);
}

/////////////////////////////////////////////////

void draw()
{

  background(0);
 



  //pointLight(noise(frameCount/3.0)*255, noise(frameCount/3.001)*255, noise(frameCount/3.002)*255, 0, width/2, 100.);
  //pointLight(0,255,0, width,0,-10);
  pushMatrix();
  translate(width/2, height/2+450, (-noise(frameCount/40.0)-0.5)*30.);
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
    lerp(orig.y,orig.y+nor.y,ler)+(noise(orig.x/160.2+frameCount/150.0)-0.5)*15,
    lerp(orig.z,orig.z+nor.z,ler)+(noise((orig.x+orig.y)/180.1+frameCount/130.0)-0.5)*15
    ));
  }
  
  //model.translateToCenter();
  
  noStroke();
 //pointLight(noise(frameCount/300.0)*255, noise(frameCount/300.1)*255, noise(frameCount/300.2)*200, 0, 0, 100.);
  //pointLight(noise(frameCount/301.0)*70, noise(frameCount/301.1)*70, noise(frameCount/301.2)*75, width, 0, 100.);
 
PVector s = model.getVertex(12000).get();

  pushMatrix();
  translate(-s.x,-s.y-15,-s.z);
  
  rotateY(rotX2+=0.004);
   pointLight(noise(frameCount/300.0)*255, noise(frameCount/300.1)*255, noise(frameCount/300.2)*200, 0, 0, 100.);
  pointLight(noise(frameCount/301.0)*70, noise(frameCount/301.1)*70, noise(frameCount/301.2)*75, width, 0, 100.);
 
  noFill();
  noStroke();//stroke(0);
  strokeWeight(180);
  fill(255);
  translate(0,-50,300);
  box(130);
  noStroke();
  popMatrix();
 // fastblur(g,10);
//fastblur(g,(int)(noise(frameCount/220.0)*20)+1);

  model.draw();
  
  
  
  popMatrix();
  
   int randX = (int)random(-1,2); 
   int randY = (int)random(-1,2); 
 
  
   fastblur(g,(int)(noise(frameCount/220.0)*5)+1);
   blend(g,0,0,width,height,0+randX,0+randY,width+randX,height+randY,ADD);
   
   //image(g,random(-2,2),random(-2,2));
   fastblur(g,(int)(noise(frameCount/210.0)*9)+1);
   blend(g,0,0,width,height,0+randX,0+randY,width+randX,height+randY,SOFT_LIGHT);
   
   resetMatrix();
   fill(120);
   text("kof 12",width-40,height-10);
   
   
  //if(noise(frameCount/3.2)>.5)
  //{
  
    /*
    loadPixels();
  post.loadPixels();
  
  
  for(int i =0 ;i<pixels.length;i++){
    //if(brightness(pixels[i])>0)
    post.pixels[i] = pixels[i];
    
  }
  
  
  
  post.filter(BLUR,noise(frameCount/3.0)*20+1.0);
  
  
  blend(post,0,0,width,height,0,0,width,height,ADD);
 
  
  
 // }
  
  
 // blend(post,0,0,width,height,0,0,width,height,MULTIPLY);

  /*
  noStroke();
   // renders the temporary model
   //tmpmodel.draw();
   
   for (int j = 0; j < model.getSegmentCount(); j++) {
   
   Segment segment = model.getSegment(j);
   Face[] faces = segment.getFaces();
   
   beginShape(QUADS);
   
   fill(255);
   
   for(int i = 0; i < faces.length; i ++)
   {
   PVector[] v = faces[i].getVertices();
   PVector n = faces[i].getNormal();
   
   float nor = 0.0;//abs(sin(radians((frameCount+i))) * 0.1);
   //noFill();
   
   
   
   for (int k = 0; k < v.length; k++) {
   //strokeWeight(map(modelZ(v[k].x,v[k].y,0),-15,10,1.8,5));
   //stroke(noise( (i+frameCount)/30.0 ) * 255,10);
   vertex(v[k].x + (n.x*nor), v[k].y + (n.y*nor), v[k].z + (n.z*nor));
   }
   }
   
   
   endShape();
   
   }
   
   popMatrix();
   
   */
}

