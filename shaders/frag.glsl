﻿#version 440 core

struct Light {
    vec3 position;
};

struct Material {
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

in vec3 FragPos;
in vec3 Color;
in vec3 Normal;
in vec2 TexCoords;

uniform sampler2D texture_diffuse1;
uniform sampler2D texture_specular1;

uniform Light[5] lights;
uniform int lightCount;
uniform Material material;

uniform vec3 viewPos;
uniform vec3 viewForward;

out vec4 finalColor;

vec3 lightDirectionNormal(Light light) {
    return normalize(light.position - FragPos);
}

vec3 diffuseLighting(Light light) {
    float angle = dot(Normal, lightDirectionNormal(light));
    vec3 diffuseColor = material.diffuse * max(0, angle);
    return diffuseColor * texture(texture_diffuse1, TexCoords).rgb;
}

vec3 specularHighlight(Light light) {
    vec3 ldn = lightDirectionNormal(light);
    vec3 specularDirection = ldn - 2 * dot(ldn, Normal) * Normal;
    
    float specularity = dot(normalize(viewForward), normalize(specularDirection));
    
    return material.specular * specularity;
}

void main() {
    vec3 ambient = material.ambient;
    
    vec3 color = vec3(0.0, 0.0, 0.0);
    for(int i = 0; i < lightCount; i++) {
        Light light = lights[i];
        color += diffuseLighting(light) + specularHighlight(light);
    }
    
    finalColor = vec4(color + material.ambient, 1.0);
}