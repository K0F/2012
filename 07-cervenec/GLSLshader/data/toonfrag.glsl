uniform sampler2D Base;
varying float intensity;

void main()
{
	vec4 color;
	
	vec2 newUV = gl_TexCoord[0].xy + viewVec.xy * height;
	vec4 color_base = texture2D(Base,newUV);
	vec3 bump = texture2D(NormalHeight, newUV.xy).rgb * 4.0 - 1.0;
	bump = normalize(bump);
	
	
	if (intensity > 0.92)

		color = vec4(0.5,0.5,0.5,1.0);
	else if (intensity > 0.5)
		color = vec4(0.3,0.3,0.3,1.0);
	else if (intensity > 0.25)
		color = vec4(0.2,0.2,0.2,1.0);
	else
		color = vec4(0.1,0.1,0.1,1.0);
	gl_FragColor = color;

}
