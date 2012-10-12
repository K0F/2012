// Example of GLSL shader with GLGraphics.
// Adapted from Vitamin's shaderlib:
// http://www.pixelnerve.com/processing/libraries/shaderlib/
// More online resources about GLSL:
// http://nehe.gamedev.net/data/articles/article.asp?article=21
// http://zach.in.tu-clausthal.de/teaching/cg_literatur/glsl_tutorial/index.html

import processing.opengl.*;
import codeanticode.glgraphics.*;

int numPoints = 4040; 

GLModel torus;
GLSLShader shader;
GLTexture tex;
GLModelEffect bump;

float angle;

void setup() {
  size(800, 600, GLConstants.GLGRAPHICS);
  bump = new GLModelEffect(this, "bump.xml");

  torus = createTorus(100, 50, 20, 100, 200, 0, 150, 255, "");  

  // Loading toon shader. Taken from here:
  // http://www.lighthouse3d.com/opengl/glsl/index.php?toon3
  shader = new GLSLShader(this, "toonvert.glsl", "toonfrag.glsl");

  torus.initTextures(1);
  // ... and loading and setting texture for this model.
  tex = new GLTexture(this, "crate.jpg");    
  torus.setTexture(0, tex);


  // Setting the texture coordinates.
  torus.beginUpdateTexCoords(0);
  torus.updateTexCoord(0, 0, 0);
  torus.updateTexCoord(1, 1, 0);    
  torus.updateTexCoord(2, 1, 1);
  torus.updateTexCoord(3, 0, 1);
  torus.endUpdateTexCoords();

  // Enabling colors.
  torus.initColors();
  torus.beginUpdateColors();
  for (int i = 0; i < numPoints; i++) {
    torus.updateColor(i, noise(i/3000.0,0,0)*255, noise(0,i/3000.0,0)*255, noise(0,0,i/3000)*255);
  }
  torus.endUpdateColors();
}

void draw() {
  GLGraphics renderer = (GLGraphics)g;

  pushMatrix();
  pushMatrix();

  rotateX(angle*2);


  pointLight(250, 250, 250, 0, 600, 400);   

  popMatrix();

  renderer.beginGL();

  background(0);



  // Centering the model in the screen.
  translate(width/2, height/2, 0);



  angle += 0.02;
  rotateY(angle);

  // The light is drawn after applying the translation and
  // rotation trasnformations, so it always shines on the
  // same side of the torus.

  shader.start(); // Enabling shader.
  // Any geometry drawn between the shader's stop() and end() will be 
  // processed by the sh
  renderer.model(torus);
  shader.stop(); // Disabling shader.

  renderer.endGL();

  popMatrix();
}

