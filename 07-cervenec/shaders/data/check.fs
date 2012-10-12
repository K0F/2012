// fragment shader
 
varying vec2 surfacePos;
const float checkSize = 5.0;
 
void main()
{
    vec3 color;
    vec2 position = surfacePos / checkSize;
 
    // carve the texture space up into 1x1 squares.
    // fract() takes the fractional part of a floating point number.
    if (fract(position.x) < 0.5)
    {
        color = vec3(0, 0, 0);
    }
    else
    {
        color = vec3(1, 1, 1);
    }
 
    // this is the critical line: set the actual fragment colour.
    gl_FragColor = vec4(color, 1.0);
}
