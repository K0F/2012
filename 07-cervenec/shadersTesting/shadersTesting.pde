import processing.opengl.*;
import codeanticode.glgraphics.*;

GLSLShader shader;
GLModel plane;
GLTexture tex;

void setup() {
  size(800, 600, GLConstants.GLGRAPHICS);
  plane = createPlane(width, height);
  shader = new GLSLShader(this, "vert.glsl", "fragment.glsl");
  GLTexture tex;
}

void draw() {
  GLGraphics renderer = (GLGraphics)g;
  lights();
  translate(width/2, height/2);
  renderer.beginGL();
  shader.start();
  renderer.model(plane);
  shader.stop(); 
  renderer.endGL();
}

