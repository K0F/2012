// vertex shader
 
varying vec2 surfacePos;
 
void main()
{
    // take our texture's surface position from the 2D
    // coordinates of gl_Vertex
    surfacePos = gl_Vertex.xy;
 
    // this is the critical line: set the vertex's screen position.
    // can also be written as gl_Position = ftransform();
    gl_Position = gl_ProjectionMatrix *  gl_ModelViewMatrix * gl_Vertex;
}
