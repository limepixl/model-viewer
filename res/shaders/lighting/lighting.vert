#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec2 aUVs;
layout (location = 2) in vec3 aNormal;
layout (location = 3) in vec3 aTangent;
layout (location = 4) in vec3 aBiTangent;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform vec3 pointLightPos;
uniform vec3 cameraPos;

out vec2 uvs;
//out vec3 fragPos_tangentSpace;
//out vec3 lightPos_tangentSpace;
//out vec3 viewPos_tangentSpace;
out vec3 fragPos;
out vec3 lightPos;
out vec3 viewPos;
out mat3 TBN;

void main()
{
    vec3 T = normalize(vec3(model * vec4(aTangent, 0.0)));
    vec3 B = normalize(vec3(model * vec4(aBiTangent, 0.0)));
    vec3 N = normalize(vec3(model * vec4(aNormal, 0.0)));
    TBN = mat3(T, B, N);

    uvs = aUVs;

    //lightPos_tangentSpace = TBN * pointLightPos;
    //viewPos_tangentSpace = TBN * cameraPos;
    //fragPos_tangentSpace = TBN * vec3(model * vec4(aPos, 0.0));

    lightPos = pointLightPos;
    viewPos = cameraPos;
    fragPos = aPos;

    gl_Position = projection * view * model * vec4(aPos, 1.0);
}