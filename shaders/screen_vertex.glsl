﻿// Only used in Modern OpenGL

#version 330
 
// shader inputs
in vec3 position;		// vertex position in Object Space
									// this shader assumes Object Space is identical to Screen Space
in vec2 texCoords;					// vertex uv texture coordinates

// shader output, will be interpolated from vertices to fragments
out vec2 uv;						// vertex uv texture coordinates (pass-through)
 
// vertex shader
void main()
{
	// vertex position already in Screen Space so no transformation needed
	gl_Position = vec4(position, 1.0);

	// pass the uv coordinate
	uv = texCoords;
}