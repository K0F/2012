import processing.opengl.*;

import wblut.hemesh.modifiers.*;
import wblut.geom.frame.*;
import wblut.hemesh.composite.*;
import wblut.core.processing.*;
import wblut.hemesh.tools.*;
import wblut.hemesh.simplifiers.*;
import wblut.hemesh.subdividors.*;
import wblut.geom.nurbs.*;
import wblut.core.random.*;
import wblut.geom.triangulate.*;
import wblut.hemesh.creators.*;
import wblut.geom.tree.*;
import wblut.hemesh.core.*;
import wblut.geom.grid.*;
import wblut.core.structures.*;
import wblut.core.math.*;
import wblut.geom.core.*;



HE_Mesh mesh;
WB_Render render;

void setup()
{
    size( 720, 360, P3D );
    hint( DISABLE_OPENGL_2X_SMOOTH );
    hint( ENABLE_OPENGL_4X_SMOOTH );
  
   HEC_Icosahedron icosahedron = new HEC_Icosahedron().setEdge(60);
mesh = new HE_Mesh(icosahedron);
HEM_Extrude extrude = new HEM_Extrude().setDistance(20);
mesh.modify(extrude);

    render = new WB_Render( this );  
}

void keyPressed(){
  
 HEM_Extrude extrude = new HEM_Extrude().setDistance(random(10));
mesh.modify(extrude); 
}

void draw()
{
    lights();
    
    background( 200 );
    
    
    
    // Draw Faces Smooth
    pushMatrix();
    translate( 337, 120 ); 
    rotateY( radians( frameCount ) );
    fill( 255 );
    noStroke();
    render.drawFacesSmooth( mesh );
    popMatrix();
    
    /*
    
    // Draw Face Normals
    pushMatrix();
    translate( 112, 345 );
    rotateY( radians( frameCount ) );
    fill( 255 );
    noStroke();
    render.drawFaces( mesh );
    noFill();
    stroke( 255, 0, 0 );
    render.drawFaceNormals( 20, mesh );
    popMatrix();
    
    // Draw Edges
    pushMatrix();
    translate( 337, 345 ); 
    rotateY( radians( frameCount ) );
    noFill();
    stroke( 0 );
    render.drawEdges( mesh );
    popMatrix();    

    // Draw Vertices
    pushMatrix();
    translate( 112, 570 ); 
    rotateY( radians( frameCount ) );
    noFill();
    stroke( 0 );
    render.drawVertices( 10, mesh );
    popMatrix();   
   
    // Draw Vertices
    pushMatrix();
    translate( 337, 570 ); 
    rotateY( radians( frameCount ) );
    noFill();
    render.drawHalfedges( 10, mesh );
    popMatrix();
    
    // draw all text to the screen
    fill( 0 );
    textAlign( CENTER );  
    text("drawFaces()", 112, 210 );
    text("drawFacesSmooth()", 337, 210 );
    text("drawFaceNormals()", 112, 435 );
    text("drawEdges()", 337, 435 );
    text("drawVertices()", 112, 660 );
    text("drawHalfedges()", 337, 660 );
*/    
}

