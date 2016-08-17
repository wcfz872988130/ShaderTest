Shader "VacuumShaders/The Amazing Wireframe/Unlit/Transparent/NoTex 2 Sided" {
Properties {
[Tag]  V_WIRE_TAG ("", Float) = 0
[WireframeOptions]  V_WIRE_W_OPTIONS ("", Float) = 0
[MaterialToggle(V_WIRE_ANTIALIASING_ON)]  AO ("Antialiasing", Float) = 0
[MaterialToggle(V_WIRE_LIGHT_ON)]  LO ("Lightmaps effect Wire", Float) = 0
[MaterialToggle(V_WIRE_FRESNEL_ON)]  FO ("Fresnel Wire", Float) = 0
 V_WIRE_COLOR ("Wire Color (RGB) Trans (A)", Color) = (0,0,0,1)
 V_WIRE_SIZE ("Wire Size", Range(0,0.5)) = 0.05
}
SubShader { 
 Tags { "QUEUE"="Transparent+10" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "WireframeTag"="Unlit/Transparent/NoTex 2 Sided" }
 Pass {
  Tags { "QUEUE"="Transparent+10" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "WireframeTag"="Unlit/Transparent/NoTex 2 Sided" }
  ZWrite Off
  Cull Front
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLSL
#ifdef VERTEX

uniform vec4 unity_LightmapST;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D unity_Lightmap;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 retColor_1;
  retColor_1.w = _Color.w;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (_Color.xyz * ((8.0 * tmpvar_2.w) * tmpvar_2.xyz));
  vec4 srcColor_3;
  srcColor_3.w = retColor_1.w;
  srcColor_3.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_4;
  tmpvar_4 = mix (V_WIRE_COLOR, srcColor_3, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
  srcColor_3 = tmpvar_4;
  retColor_1 = tmpvar_4;
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord1 o1
dcl_color0 o2
dcl_position0 v0
dcl_texcoord1 v1
dcl_color0 v2
mov o2, v2
mad o1.xy, v1, c4, c4.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 64
Vector 48 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefieceddkdfcjhglijbajkcbolijhggalekbmijabaaaaaahaacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaagfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcfiabaaaaeaaaabaafgaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafpccabaaa
acaaaaaaegbobaaaacaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 unity_LightmapST;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  vec4 retColor_1;
  retColor_1.w = _Color.w;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (_Color.xyz * ((8.0 * tmpvar_2.w) * tmpvar_2.xyz));
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec4 srcColor_3;
  srcColor_3.w = retColor_1.w;
  srcColor_3.xyz = xlat_mutableV_WIRE_COLOR.xyz;
  vec4 tmpvar_4;
  tmpvar_4 = mix (xlat_mutableV_WIRE_COLOR, srcColor_3, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
  srcColor_3 = tmpvar_4;
  retColor_1 = tmpvar_4;
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord3 o2
dcl_color0 o3
def c11, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord1 v2
dcl_color0 v3
mov r1.w, c11.x
mov r1.xyz, c8
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r0.xyz, r0, c9.w
add r0.xyz, -v0, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.x, v1, r0
add o2.x, -r0, c11
mov o3, v3
mad o1.xy, v2, c10, c10.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 64
Vector 48 [unity_LightmapST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddelnjffkaklmfdfldinpdeonopaphhmeabaaaaaadiaeaaaaadaaaaaa
cmaaaaaalmaaaaaagaabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaaibaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahapaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefcnaacaaaaeaaaabaaleaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaadpcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaieccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafpccabaaaadaaaaaaegbobaaaadaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL
#ifdef VERTEX

uniform vec4 unity_LightmapST;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D unity_Lightmap;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 retColor_1;
  retColor_1.w = _Color.w;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (_Color.xyz * ((8.0 * tmpvar_2.w) * tmpvar_2.xyz));
  vec4 srcColor_3;
  srcColor_3.w = retColor_1.w;
  vec3 tmpvar_4;
  vec3 t_5;
  t_5 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_4 = (t_5 * (t_5 * (3.0 - (2.0 * t_5))));
  srcColor_3.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_6;
  tmpvar_6 = mix (V_WIRE_COLOR, srcColor_3, vec4(min (min (tmpvar_4.x, tmpvar_4.y), tmpvar_4.z)));
  srcColor_3 = tmpvar_6;
  retColor_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_6;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord1 o1
dcl_color0 o2
dcl_position0 v0
dcl_texcoord1 v1
dcl_color0 v2
mov o2, v2
mad o1.xy, v1, c4, c4.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 64
Vector 48 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefieceddkdfcjhglijbajkcbolijhggalekbmijabaaaaaahaacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaagfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcfiabaaaaeaaaabaafgaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafpccabaaa
acaaaaaaegbobaaaacaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 unity_LightmapST;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  vec4 retColor_1;
  retColor_1.w = _Color.w;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (_Color.xyz * ((8.0 * tmpvar_2.w) * tmpvar_2.xyz));
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec4 srcColor_3;
  srcColor_3.w = retColor_1.w;
  vec3 tmpvar_4;
  vec3 t_5;
  t_5 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_4 = (t_5 * (t_5 * (3.0 - (2.0 * t_5))));
  srcColor_3.xyz = xlat_mutableV_WIRE_COLOR.xyz;
  vec4 tmpvar_6;
  tmpvar_6 = mix (xlat_mutableV_WIRE_COLOR, srcColor_3, vec4(min (min (tmpvar_4.x, tmpvar_4.y), tmpvar_4.z)));
  srcColor_3 = tmpvar_6;
  retColor_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_6;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord3 o2
dcl_color0 o3
def c11, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord1 v2
dcl_color0 v3
mov r1.w, c11.x
mov r1.xyz, c8
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r0.xyz, r0, c9.w
add r0.xyz, -v0, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.x, v1, r0
add o2.x, -r0, c11
mov o3, v3
mad o1.xy, v2, c10, c10.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 64
Vector 48 [unity_LightmapST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddelnjffkaklmfdfldinpdeonopaphhmeabaaaaaadiaeaaaaadaaaaaa
cmaaaaaalmaaaaaagaabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaaibaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahapaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefcnaacaaaaeaaaabaaleaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaadpcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaieccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafpccabaaaadaaaaaaegbobaaaadaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX

uniform vec4 unity_LightmapST;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.w = V_WIRE_COLOR.w;
  vec4 retColor_1;
  retColor_1.w = _Color.w;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  vec3 tmpvar_3;
  tmpvar_3 = ((8.0 * tmpvar_2.w) * tmpvar_2.xyz);
  retColor_1.xyz = (_Color.xyz * tmpvar_3);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_3);
  vec4 srcColor_4;
  srcColor_4.w = retColor_1.w;
  srcColor_4.xyz = xlat_mutableV_WIRE_COLOR.xyz;
  vec4 tmpvar_5;
  tmpvar_5 = mix (xlat_mutableV_WIRE_COLOR, srcColor_4, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
  srcColor_4 = tmpvar_5;
  retColor_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord1 o1
dcl_color0 o2
dcl_position0 v0
dcl_texcoord1 v1
dcl_color0 v2
mov o2, v2
mad o1.xy, v1, c4, c4.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 64
Vector 48 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefieceddkdfcjhglijbajkcbolijhggalekbmijabaaaaaahaacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaagfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcfiabaaaaeaaaabaafgaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafpccabaaa
acaaaaaaegbobaaaacaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 unity_LightmapST;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 retColor_1;
  retColor_1.w = _Color.w;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  vec3 tmpvar_3;
  tmpvar_3 = ((8.0 * tmpvar_2.w) * tmpvar_2.xyz);
  retColor_1.xyz = (_Color.xyz * tmpvar_3);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_3);
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec4 srcColor_4;
  srcColor_4.w = retColor_1.w;
  srcColor_4.xyz = xlat_mutableV_WIRE_COLOR.xyz;
  vec4 tmpvar_5;
  tmpvar_5 = mix (xlat_mutableV_WIRE_COLOR, srcColor_4, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
  srcColor_4 = tmpvar_5;
  retColor_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord3 o2
dcl_color0 o3
def c11, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord1 v2
dcl_color0 v3
mov r1.w, c11.x
mov r1.xyz, c8
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r0.xyz, r0, c9.w
add r0.xyz, -v0, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.x, v1, r0
add o2.x, -r0, c11
mov o3, v3
mad o1.xy, v2, c10, c10.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 64
Vector 48 [unity_LightmapST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddelnjffkaklmfdfldinpdeonopaphhmeabaaaaaadiaeaaaaadaaaaaa
cmaaaaaalmaaaaaagaabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaaibaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahapaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefcnaacaaaaeaaaabaaleaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaadpcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaieccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafpccabaaaadaaaaaaegbobaaaadaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX

uniform vec4 unity_LightmapST;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.w = V_WIRE_COLOR.w;
  vec4 retColor_1;
  retColor_1.w = _Color.w;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  vec3 tmpvar_3;
  tmpvar_3 = ((8.0 * tmpvar_2.w) * tmpvar_2.xyz);
  retColor_1.xyz = (_Color.xyz * tmpvar_3);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_3);
  vec4 srcColor_4;
  srcColor_4.w = retColor_1.w;
  vec3 tmpvar_5;
  vec3 t_6;
  t_6 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_5 = (t_6 * (t_6 * (3.0 - (2.0 * t_6))));
  srcColor_4.xyz = xlat_mutableV_WIRE_COLOR.xyz;
  vec4 tmpvar_7;
  tmpvar_7 = mix (xlat_mutableV_WIRE_COLOR, srcColor_4, vec4(min (min (tmpvar_5.x, tmpvar_5.y), tmpvar_5.z)));
  srcColor_4 = tmpvar_7;
  retColor_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord1 o1
dcl_color0 o2
dcl_position0 v0
dcl_texcoord1 v1
dcl_color0 v2
mov o2, v2
mad o1.xy, v1, c4, c4.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 64
Vector 48 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefieceddkdfcjhglijbajkcbolijhggalekbmijabaaaaaahaacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaagfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcfiabaaaaeaaaabaafgaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafpccabaaa
acaaaaaaegbobaaaacaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 unity_LightmapST;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 retColor_1;
  retColor_1.w = _Color.w;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  vec3 tmpvar_3;
  tmpvar_3 = ((8.0 * tmpvar_2.w) * tmpvar_2.xyz);
  retColor_1.xyz = (_Color.xyz * tmpvar_3);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_3);
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec4 srcColor_4;
  srcColor_4.w = retColor_1.w;
  vec3 tmpvar_5;
  vec3 t_6;
  t_6 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_5 = (t_6 * (t_6 * (3.0 - (2.0 * t_6))));
  srcColor_4.xyz = xlat_mutableV_WIRE_COLOR.xyz;
  vec4 tmpvar_7;
  tmpvar_7 = mix (xlat_mutableV_WIRE_COLOR, srcColor_4, vec4(min (min (tmpvar_5.x, tmpvar_5.y), tmpvar_5.z)));
  srcColor_4 = tmpvar_7;
  retColor_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord3 o2
dcl_color0 o3
def c11, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord1 v2
dcl_color0 v3
mov r1.w, c11.x
mov r1.xyz, c8
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r0.xyz, r0, c9.w
add r0.xyz, -v0, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.x, v1, r0
add o2.x, -r0, c11
mov o3, v3
mad o1.xy, v2, c10, c10.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 64
Vector 48 [unity_LightmapST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddelnjffkaklmfdfldinpdeonopaphhmeabaaaaaadiaeaaaaadaaaaaa
cmaaaaaalmaaaaaagaabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaaibaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahapaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefcnaacaaaaeaaaabaaleaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaadpcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaieccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafpccabaaaadaaaaaaegbobaaaadaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLSL
#ifdef VERTEX

varying vec4 xlv_COLOR;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 srcColor_1;
  srcColor_1.w = _Color.w;
  srcColor_1.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_2;
  tmpvar_2 = mix (V_WIRE_COLOR, srcColor_1, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
  srcColor_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position o0
dcl_color0 o1
dcl_position0 v0
dcl_color0 v1
mov o1, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedamflbolapkbcdegjcikakklimmmoahnpabaaaaaanmabaaaaadaaaaaa
cmaaaaaahmaaaaaanaaaaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafaepfdejfeejepeoaaedepemepfcaaklepfdeheo
emaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaaklklfdeieefcaeabaaaaeaaaabaaebaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
vec4 xlat_mutableV_WIRE_COLOR;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec4 srcColor_1;
  srcColor_1.w = _Color.w;
  srcColor_1.xyz = xlat_mutableV_WIRE_COLOR.xyz;
  vec4 tmpvar_2;
  tmpvar_2 = mix (xlat_mutableV_WIRE_COLOR, srcColor_1, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
  srcColor_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord3 o1
dcl_color0 o2
def c10, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_color0 v2
mov r1.w, c10.x
mov r1.xyz, c8
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r0.xyz, r0, c9.w
add r0.xyz, -v0, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.x, v1, r0
add o1.x, -r0, c10
mov o2, v2
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednipohcebleioffgkpjmbdbichejgndnpabaaaaaakmadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaaeoepfcenebemaaedepemepfcaaklklepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaheaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoapaaaahnaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklfdeieefchmacaaaaeaaaabaajpaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaadpcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaaegiccaaa
abaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaabaaaaaabaaaaaaa
agiacaaaaaaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaabaaaaaabcaaaaaakgikcaaaaaaaaaaaaeaaaaaaegacbaaaaaaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaabdaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaabaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaibccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdgaaaaafpccabaaaacaaaaaa
egbobaaaacaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL
#ifdef VERTEX

varying vec4 xlv_COLOR;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 srcColor_1;
  srcColor_1.w = _Color.w;
  vec3 tmpvar_2;
  vec3 t_3;
  t_3 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_2 = (t_3 * (t_3 * (3.0 - (2.0 * t_3))));
  srcColor_1.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_4;
  tmpvar_4 = mix (V_WIRE_COLOR, srcColor_1, vec4(min (min (tmpvar_2.x, tmpvar_2.y), tmpvar_2.z)));
  srcColor_1 = tmpvar_4;
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position o0
dcl_color0 o1
dcl_position0 v0
dcl_color0 v1
mov o1, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedamflbolapkbcdegjcikakklimmmoahnpabaaaaaanmabaaaaadaaaaaa
cmaaaaaahmaaaaaanaaaaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafaepfdejfeejepeoaaedepemepfcaaklepfdeheo
emaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaaklklfdeieefcaeabaaaaeaaaabaaebaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
vec4 xlat_mutableV_WIRE_COLOR;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec4 srcColor_1;
  srcColor_1.w = _Color.w;
  vec3 tmpvar_2;
  vec3 t_3;
  t_3 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_2 = (t_3 * (t_3 * (3.0 - (2.0 * t_3))));
  srcColor_1.xyz = xlat_mutableV_WIRE_COLOR.xyz;
  vec4 tmpvar_4;
  tmpvar_4 = mix (xlat_mutableV_WIRE_COLOR, srcColor_1, vec4(min (min (tmpvar_2.x, tmpvar_2.y), tmpvar_2.z)));
  srcColor_1 = tmpvar_4;
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord3 o1
dcl_color0 o2
def c10, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_color0 v2
mov r1.w, c10.x
mov r1.xyz, c8
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r0.xyz, r0, c9.w
add r0.xyz, -v0, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.x, v1, r0
add o1.x, -r0, c10
mov o2, v2
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednipohcebleioffgkpjmbdbichejgndnpabaaaaaakmadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaaeoepfcenebemaaedepemepfcaaklklepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaheaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoapaaaahnaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklfdeieefchmacaaaaeaaaabaajpaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaadpcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaaegiccaaa
abaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaabaaaaaabaaaaaaa
agiacaaaaaaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaabaaaaaabcaaaaaakgikcaaaaaaaaaaaaeaaaaaaegacbaaaaaaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaabdaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaabaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaibccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdgaaaaafpccabaaaacaaaaaa
egbobaaaacaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX

varying vec4 xlv_COLOR;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 srcColor_1;
  srcColor_1.w = _Color.w;
  srcColor_1.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_2;
  tmpvar_2 = mix (V_WIRE_COLOR, srcColor_1, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
  srcColor_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position o0
dcl_color0 o1
dcl_position0 v0
dcl_color0 v1
mov o1, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedamflbolapkbcdegjcikakklimmmoahnpabaaaaaanmabaaaaadaaaaaa
cmaaaaaahmaaaaaanaaaaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafaepfdejfeejepeoaaedepemepfcaaklepfdeheo
emaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaaklklfdeieefcaeabaaaaeaaaabaaebaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
vec4 xlat_mutableV_WIRE_COLOR;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec4 srcColor_1;
  srcColor_1.w = _Color.w;
  srcColor_1.xyz = xlat_mutableV_WIRE_COLOR.xyz;
  vec4 tmpvar_2;
  tmpvar_2 = mix (xlat_mutableV_WIRE_COLOR, srcColor_1, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
  srcColor_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord3 o1
dcl_color0 o2
def c10, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_color0 v2
mov r1.w, c10.x
mov r1.xyz, c8
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r0.xyz, r0, c9.w
add r0.xyz, -v0, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.x, v1, r0
add o1.x, -r0, c10
mov o2, v2
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednipohcebleioffgkpjmbdbichejgndnpabaaaaaakmadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaaeoepfcenebemaaedepemepfcaaklklepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaheaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoapaaaahnaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklfdeieefchmacaaaaeaaaabaajpaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaadpcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaaegiccaaa
abaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaabaaaaaabaaaaaaa
agiacaaaaaaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaabaaaaaabcaaaaaakgikcaaaaaaaaaaaaeaaaaaaegacbaaaaaaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaabdaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaabaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaibccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdgaaaaafpccabaaaacaaaaaa
egbobaaaacaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX

varying vec4 xlv_COLOR;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 srcColor_1;
  srcColor_1.w = _Color.w;
  vec3 tmpvar_2;
  vec3 t_3;
  t_3 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_2 = (t_3 * (t_3 * (3.0 - (2.0 * t_3))));
  srcColor_1.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_4;
  tmpvar_4 = mix (V_WIRE_COLOR, srcColor_1, vec4(min (min (tmpvar_2.x, tmpvar_2.y), tmpvar_2.z)));
  srcColor_1 = tmpvar_4;
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position o0
dcl_color0 o1
dcl_position0 v0
dcl_color0 v1
mov o1, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedamflbolapkbcdegjcikakklimmmoahnpabaaaaaanmabaaaaadaaaaaa
cmaaaaaahmaaaaaanaaaaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafaepfdejfeejepeoaaedepemepfcaaklepfdeheo
emaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaaklklfdeieefcaeabaaaaeaaaabaaebaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
vec4 xlat_mutableV_WIRE_COLOR;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec4 srcColor_1;
  srcColor_1.w = _Color.w;
  vec3 tmpvar_2;
  vec3 t_3;
  t_3 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_2 = (t_3 * (t_3 * (3.0 - (2.0 * t_3))));
  srcColor_1.xyz = xlat_mutableV_WIRE_COLOR.xyz;
  vec4 tmpvar_4;
  tmpvar_4 = mix (xlat_mutableV_WIRE_COLOR, srcColor_1, vec4(min (min (tmpvar_2.x, tmpvar_2.y), tmpvar_2.z)));
  srcColor_1 = tmpvar_4;
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord3 o1
dcl_color0 o2
def c10, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_color0 v2
mov r1.w, c10.x
mov r1.xyz, c8
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r0.xyz, r0, c9.w
add r0.xyz, -v0, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.x, v1, r0
add o1.x, -r0, c10
mov o2, v2
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednipohcebleioffgkpjmbdbichejgndnpabaaaaaakmadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaaeoepfcenebemaaedepemepfcaaklklepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaheaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaoapaaaahnaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklfdeieefchmacaaaaeaaaabaajpaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaadpcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaaegiccaaa
abaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaabaaaaaabaaaaaaa
agiacaaaaaaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaabaaaaaabcaaaaaakgikcaaaaaaaaaaaaeaaaaaaegacbaaaaaaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaabdaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaabaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaibccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdgaaaaafpccabaaaacaaaaaa
egbobaaaacaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
"ps_3_0
def c3, 1.00000000, 0.00000000, 0, 0
dcl_color0 v1.xyz
min_pp r0.x, v1, v1.y
min_pp r0.x, r0, v1.z
add_pp r0.x, r0, -c1
mov_pp r1.xyz, c0
mov_pp r1.w, c2
add_pp r1, r1, -c0
cmp_pp r0.x, r0, c3, c3.y
mad_pp oC0, r0.x, r1, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmgcedooleednmlkjejceookhkbmpeklkabaaaaaapmabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefccaabaaaaeaaaaaaa
eiaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaadhcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaddaaaaahbcaabaaaaaaaaaaa
bkbabaaaacaaaaaaakbabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaaaacaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpdgaaaaaihcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaakicaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
aaaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
"ps_3_0
def c3, 1.00000000, 0.00000000, 0, 0
dcl_texcoord3 v1.x
dcl_color0 v2.xyz
min_pp r0.w, v2.x, v2.y
min_pp r0.w, r0, v2.z
add_pp r2.x, r0.w, -c1
mov_pp r1.xyz, c0
mul_pp r1.w, v1.x, c0
mov_pp r0.xyz, c0
mov_pp r0.w, c2
add_pp r0, r0, -r1
cmp_pp r2.x, r2, c3, c3.y
mad_pp oC0, r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlemefplhkddloibeaefmflpoijlmcjkeabaaaaaaheacaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcgiabaaaaeaaaaaaafkaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaddaaaaahbcaabaaaaaaaaaaabkbabaaa
adaaaaaaakbabaaaadaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckbabaaaadaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaiicaabaaaabaaaaaackbabaaaabaaaaaadkiacaaaaaaaaaaa
aaaaaaaadgaaaaaghcaabaaaabaaaaaaegiccaaaaaaaaaaaaaaaaaaadgaaaaai
hcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadcaaaaam
icaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaaaaaaaaackbabaaaabaaaaaa
dkiacaaaaaaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
"ps_3_0
def c3, 20.00000000, 2.00000000, 3.00000000, 0
dcl_color0 v1.xyz
dsy_pp r1.xyz, v1
dsx_pp r0.xyz, v1
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r0.xyz, v1, r0
mad_pp r1.xyz, -r0, c3.y, c3.z
mul_pp r0.xyz, r0, r0
mul_pp r1.xyz, r0, r1
min_pp r1.x, r1, r1.y
mov_pp r0.w, c2
mov_pp r0.xyz, c0
add_pp r0, r0, -c0
min_pp r1.x, r1, r1.z
mad_pp oC0, r1.x, r0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedaniebnfnnbmmbdcbjjcaffifnpnamfpeabaaaaaaamadaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdaacaaaaeaaaaaaa
imaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaadhcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaalaaaaafhcaabaaaaaaaaaaa
egbcbaaaacaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaaacaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaiaibaaaaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaa
diaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaakaebaaaakaeb
aaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaacaaaaaadcaaaaaphcaabaaaabaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaah
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaaihcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaakicaabaaa
abaaaaaadkiacaiaebaaaaaaaaaaaaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaa
dcaaaaakpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegiocaaa
aaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
"ps_3_0
def c3, 20.00000000, 2.00000000, 3.00000000, 0
dcl_texcoord3 v1.x
dcl_color0 v2.xyz
dsy_pp r0.xyz, v2
dsx_pp r1.xyz, v2
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r1.xyz, v2, r0
mad_pp r0.xyz, -r1, c3.y, c3.z
mul_pp r1.xyz, r1, r1
mul_pp r2.xyz, r1, r0
min_pp r2.x, r2, r2.y
mov_pp r1.xyz, c0
mul_pp r1.w, v1.x, c0
mov_pp r0.xyz, c0
mov_pp r0.w, c2
add_pp r0, r0, -r1
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedeplakhkifopaoengcoeoelkpjelinboeabaaaaaaieadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefchiacaaaaeaaaaaaajoaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaalaaaaafhcaabaaaaaaaaaaaegbcbaaa
adaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaaadaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaiaibaaaaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaakaebaaaakaebaaaakaeb
aaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egbcbaaaadaaaaaadcaaaaaphcaabaaaabaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaea
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaddaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiicaabaaaabaaaaaa
ckbabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaadgaaaaaghcaabaaaabaaaaaa
egiccaaaaaaaaaaaaaaaaaaadgaaaaaihcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadcaaaaamicaabaaaacaaaaaadkiacaiaebaaaaaa
aaaaaaaaaaaaaaaackbabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaaj
pccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [unity_Lightmap] 2D 0
"ps_3_0
dcl_2d s0
def c3, 8.00000000, 1.00000000, 0.00000000, 0
dcl_texcoord1 v0.xy
dcl_color0 v1.xyz
texld r0, v0, s0
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, c3.x
min_pp r0.w, v1.x, v1.y
min_pp r0.w, r0, v1.z
add_pp r2.x, r0.w, -c1
mov_pp r1.xyz, r0
mov_pp r1.w, c0
mov_pp r0.w, c2
add_pp r0, r0, -r1
cmp_pp r2.x, r2, c3.y, c3.z
mad_pp oC0, r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
SetTexture 0 [unity_Lightmap] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkeeijpgmbogjbkjheemnpfikdggageopabaaaaaalaacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcneabaaaaeaaaaaaa
hfaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaaddaaaaahbcaabaaa
abaaaaaabkbabaaaacaaaaaaakbabaaaacaaaaaaddaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaackbabaaaacaaaaaabnaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpdgaaaaaihcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaagicaabaaaaaaaaaaadkiacaaaaaaaaaaa
aaaaaaaaaaaaaaajicaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaadkiacaaa
aaaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaabaaaaaaegaobaaa
acaaaaaaegaobaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [unity_Lightmap] 2D 0
"ps_3_0
dcl_2d s0
def c3, 8.00000000, 1.00000000, 0.00000000, 0
dcl_texcoord1 v0.xy
dcl_texcoord3 v1.x
dcl_color0 v2.xyz
texld r0, v0, s0
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, c3.x
min_pp r0.w, v2.x, v2.y
min_pp r0.w, r0, v2.z
add_pp r2.x, r0.w, -c1
mov_pp r1.xyz, r0
mul_pp r1.w, v1.x, c0
mov_pp r0.w, c2
add_pp r0, r0, -r1
cmp_pp r2.x, r2, c3.y, c3.z
mad_pp oC0, r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
SetTexture 0 [unity_Lightmap] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhhmcjonejbochbjlgbcncninllabplnbabaaaaaaaaadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcpeabaaaaeaaaaaaahnaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaaddaaaaahbcaabaaaabaaaaaa
bkbabaaaadaaaaaaakbabaaaadaaaaaaddaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackbabaaaadaaaaaabnaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
akiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaiadpdiaaaaaiicaabaaaaaaaaaaackbabaaaabaaaaaadkiacaaa
aaaaaaaaaaaaaaaadgaaaaaihcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadcaaaaamicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaa
aaaaaaaackbabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaajpccabaaa
aaaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [unity_Lightmap] 2D 0
"ps_3_0
dcl_2d s0
def c3, 8.00000000, 20.00000000, 2.00000000, 3.00000000
dcl_texcoord1 v0.xy
dcl_color0 v1.xyz
dsy_pp r0.xyz, v1
dsx_pp r1.xyz, v1
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.y
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r1.xyz, v1, r0
mul_pp r2.xyz, r1, r1
texld r0, v0, s0
mul_pp r0.xyz, r0.w, r0
mad_pp r1.xyz, -r1, c3.z, c3.w
mul_pp r1.xyz, r2, r1
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, c3.x
min_pp r1.x, r1, r1.y
mov_pp r2.xyz, r0
mov_pp r2.w, c0
mov_pp r0.w, c2
add_pp r0, r0, -r2
min_pp r1.x, r1, r1.z
mad_pp oC0, r1.x, r0, r2
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
SetTexture 0 [unity_Lightmap] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedelejiilmegepedacgolillbijhogalddabaaaaaamaadaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoeacaaaaeaaaaaaa
ljaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaalaaaaaf
hcaabaaaaaaaaaaaegbcbaaaacaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaa
acaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaia
ibaaaaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaabaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaakaebaaaakaebaaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaaphcaabaaaabaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaeb
diaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaadgaaaaai
hcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaag
icaabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaaaaaaaaajicaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaajpccabaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
SetTexture 0 [unity_Lightmap] 2D 0
"ps_3_0
dcl_2d s0
def c3, 8.00000000, 20.00000000, 2.00000000, 3.00000000
dcl_texcoord1 v0.xy
dcl_texcoord3 v1.x
dcl_color0 v2.xyz
dsy_pp r0.xyz, v2
dsx_pp r1.xyz, v2
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.y
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r1.xyz, v2, r0
mul_pp r2.xyz, r1, r1
texld r0, v0, s0
mul_pp r0.xyz, r0.w, r0
mad_pp r1.xyz, -r1, c3.z, c3.w
mul_pp r1.xyz, r2, r1
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, c3.x
min_pp r1.x, r1, r1.y
mov_pp r2.xyz, r0
mul_pp r2.w, v1.x, c0
mov_pp r0.w, c2
add_pp r0, r0, -r2
min_pp r1.x, r1, r1.z
mad_pp oC0, r1.x, r0, r2
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
SetTexture 0 [unity_Lightmap] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbdlmnnjgcmcicbmaonaklfkjikfnfanjabaaaaaabaaeaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcaeadaaaaeaaaaaaambaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaalaaaaafhcaabaaa
aaaaaaaaegbcbaaaadaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaaadaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaiaibaaaaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaakaeb
aaaakaebaaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaaphcaabaaaabaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
ocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaadiaaaaaiicaabaaa
abaaaaaackbabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaadgaaaaaihcaabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadcaaaaamicaabaaa
acaaaaaadkiacaiaebaaaaaaaaaaaaaaaaaaaaaackbabaaaabaaaaaadkiacaaa
aaaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
"ps_3_0
def c3, 1.00000000, 0.00000000, 0, 0
dcl_color0 v0.xyz
min_pp r0.x, v0, v0.y
min_pp r0.x, r0, v0.z
add_pp r0.x, r0, -c1
mov_pp r1.xyz, c0
mov_pp r1.w, c2
add_pp r1, r1, -c0
cmp_pp r0.x, r0, c3, c3.y
mad_pp oC0, r0.x, r1, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
ConstBuffer "$Globals" 48
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecednplnedmeokcmppencdhfmagjmmneiojgabaaaaaanmabaaaaadaaaaaa
cmaaaaaaiaaaaaaaleaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaaklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefccaabaaaaeaaaaaaa
eiaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaadhcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaddaaaaahbcaabaaaaaaaaaaa
bkbabaaaabaaaaaaakbabaaaabaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaaaabaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpdgaaaaaihcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaakicaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
aaaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
"ps_3_0
def c3, 1.00000000, 0.00000000, 0, 0
dcl_texcoord3 v0.x
dcl_color0 v1.xyz
min_pp r0.w, v1.x, v1.y
min_pp r0.w, r0, v1.z
add_pp r2.x, r0.w, -c1
mov_pp r1.xyz, c0
mul_pp r1.w, v0.x, c0
mov_pp r0.xyz, c0
mov_pp r0.w, c2
add_pp r0, r0, -r1
cmp_pp r2.x, r2, c3, c3.y
mad_pp oC0, r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
ConstBuffer "$Globals" 48
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedakbgafemkhbcloliibfgpldkklaeffaoabaaaaaafmacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaadaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaheaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcgiabaaaaeaaaaaaafkaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaagcbaaaadbcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaddaaaaahbcaabaaa
aaaaaaaabkbabaaaacaaaaaaakbabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackbabaaaacaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaaiicaabaaaabaaaaaaakbabaaaabaaaaaa
dkiacaaaaaaaaaaaaaaaaaaadgaaaaaghcaabaaaabaaaaaaegiccaaaaaaaaaaa
aaaaaaaadgaaaaaihcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadcaaaaamicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaaaaaaaaa
akbabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
"ps_3_0
def c3, 20.00000000, 2.00000000, 3.00000000, 0
dcl_color0 v0.xyz
dsy_pp r1.xyz, v0
dsx_pp r0.xyz, v0
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r0.xyz, v0, r0
mad_pp r1.xyz, -r0, c3.y, c3.z
mul_pp r0.xyz, r0, r0
mul_pp r1.xyz, r0, r1
min_pp r1.x, r1, r1.y
mov_pp r0.w, c2
mov_pp r0.xyz, c0
add_pp r0, r0, -c0
min_pp r1.x, r1, r1.z
mad_pp oC0, r1.x, r0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
ConstBuffer "$Globals" 48
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmbepgepelmiiefglhchijabgliapnohnabaaaaaaomacaaaaadaaaaaa
cmaaaaaaiaaaaaaaleaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaaklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdaacaaaaeaaaaaaa
imaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaadhcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaalaaaaafhcaabaaaaaaaaaaa
egbcbaaaabaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaaabaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaiaibaaaaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaa
diaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaakaebaaaakaeb
aaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaabaaaaaadcaaaaaphcaabaaaabaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaah
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaaihcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaakicaabaaa
abaaaaaadkiacaiaebaaaaaaaaaaaaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaa
dcaaaaakpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegiocaaa
aaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
"ps_3_0
def c3, 20.00000000, 2.00000000, 3.00000000, 0
dcl_texcoord3 v0.x
dcl_color0 v1.xyz
dsy_pp r0.xyz, v1
dsx_pp r1.xyz, v1
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r1.xyz, v1, r0
mad_pp r0.xyz, -r1, c3.y, c3.z
mul_pp r1.xyz, r1, r1
mul_pp r2.xyz, r1, r0
min_pp r2.x, r2, r2.y
mov_pp r1.xyz, c0
mul_pp r1.w, v0.x, c0
mov_pp r0.xyz, c0
mov_pp r0.w, c2
add_pp r0, r0, -r1
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
ConstBuffer "$Globals" 48
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedaiomobgppflfoiggomonpmghabcllbjkabaaaaaagmadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaadaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaheaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefchiacaaaaeaaaaaaajoaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaagcbaaaadbcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaalaaaaafhcaabaaa
aaaaaaaaegbcbaaaacaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaaacaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaiaibaaaaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaakaeb
aaaakaebaaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaaphcaabaaaabaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
icaabaaaabaaaaaaakbabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaadgaaaaag
hcaabaaaabaaaaaaegiccaaaaaaaaaaaaaaaaaaadgaaaaaihcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadcaaaaamicaabaaaacaaaaaa
dkiacaiaebaaaaaaaaaaaaaaaaaaaaaaakbabaaaabaaaaaadkiacaaaaaaaaaaa
acaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
"ps_3_0
def c3, 1.00000000, 0.00000000, 0, 0
dcl_color0 v0.xyz
min_pp r0.x, v0, v0.y
min_pp r0.x, r0, v0.z
add_pp r0.x, r0, -c1
mov_pp r1.xyz, c0
mov_pp r1.w, c2
add_pp r1, r1, -c0
cmp_pp r0.x, r0, c3, c3.y
mad_pp oC0, r0.x, r1, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
ConstBuffer "$Globals" 48
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecednplnedmeokcmppencdhfmagjmmneiojgabaaaaaanmabaaaaadaaaaaa
cmaaaaaaiaaaaaaaleaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaaklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefccaabaaaaeaaaaaaa
eiaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaadhcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaddaaaaahbcaabaaaaaaaaaaa
bkbabaaaabaaaaaaakbabaaaabaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaaaabaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpdgaaaaaihcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaakicaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
aaaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
"ps_3_0
def c3, 1.00000000, 0.00000000, 0, 0
dcl_texcoord3 v0.x
dcl_color0 v1.xyz
min_pp r0.w, v1.x, v1.y
min_pp r0.w, r0, v1.z
add_pp r2.x, r0.w, -c1
mov_pp r1.xyz, c0
mul_pp r1.w, v0.x, c0
mov_pp r0.xyz, c0
mov_pp r0.w, c2
add_pp r0, r0, -r1
cmp_pp r2.x, r2, c3, c3.y
mad_pp oC0, r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
ConstBuffer "$Globals" 48
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedakbgafemkhbcloliibfgpldkklaeffaoabaaaaaafmacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaadaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaheaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcgiabaaaaeaaaaaaafkaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaagcbaaaadbcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaddaaaaahbcaabaaa
aaaaaaaabkbabaaaacaaaaaaakbabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackbabaaaacaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaaiicaabaaaabaaaaaaakbabaaaabaaaaaa
dkiacaaaaaaaaaaaaaaaaaaadgaaaaaghcaabaaaabaaaaaaegiccaaaaaaaaaaa
aaaaaaaadgaaaaaihcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadcaaaaamicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaaaaaaaaa
akbabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
"ps_3_0
def c3, 20.00000000, 2.00000000, 3.00000000, 0
dcl_color0 v0.xyz
dsy_pp r1.xyz, v0
dsx_pp r0.xyz, v0
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r0.xyz, v0, r0
mad_pp r1.xyz, -r0, c3.y, c3.z
mul_pp r0.xyz, r0, r0
mul_pp r1.xyz, r0, r1
min_pp r1.x, r1, r1.y
mov_pp r0.w, c2
mov_pp r0.xyz, c0
add_pp r0, r0, -c0
min_pp r1.x, r1, r1.z
mad_pp oC0, r1.x, r0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
ConstBuffer "$Globals" 48
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmbepgepelmiiefglhchijabgliapnohnabaaaaaaomacaaaaadaaaaaa
cmaaaaaaiaaaaaaaleaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaaklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdaacaaaaeaaaaaaa
imaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaadhcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaalaaaaafhcaabaaaaaaaaaaa
egbcbaaaabaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaaabaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaiaibaaaaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaa
diaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaakaebaaaakaeb
aaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaabaaaaaadcaaaaaphcaabaaaabaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaah
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaaihcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaakicaabaaa
abaaaaaadkiacaiaebaaaaaaaaaaaaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaa
dcaaaaakpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegiocaaa
aaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
"ps_3_0
def c3, 20.00000000, 2.00000000, 3.00000000, 0
dcl_texcoord3 v0.x
dcl_color0 v1.xyz
dsy_pp r0.xyz, v1
dsx_pp r1.xyz, v1
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r1.xyz, v1, r0
mad_pp r0.xyz, -r1, c3.y, c3.z
mul_pp r1.xyz, r1, r1
mul_pp r2.xyz, r1, r0
min_pp r2.x, r2, r2.y
mov_pp r1.xyz, c0
mul_pp r1.w, v0.x, c0
mov_pp r0.xyz, c0
mov_pp r0.w, c2
add_pp r0, r0, -r1
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
ConstBuffer "$Globals" 48
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedaiomobgppflfoiggomonpmghabcllbjkabaaaaaagmadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaadaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaheaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefchiacaaaaeaaaaaaajoaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaagcbaaaadbcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaalaaaaafhcaabaaa
aaaaaaaaegbcbaaaacaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaaacaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaiaibaaaaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaakaeb
aaaakaebaaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaaphcaabaaaabaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
icaabaaaabaaaaaaakbabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaadgaaaaag
hcaabaaaabaaaaaaegiccaaaaaaaaaaaaaaaaaaadgaaaaaihcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadcaaaaamicaabaaaacaaaaaa
dkiacaiaebaaaaaaaaaaaaaaaaaaaaaaakbabaaaabaaaaaadkiacaaaaaaaaaaa
acaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadoaaaaab"
}
}
 }
 Pass {
  Tags { "QUEUE"="Transparent+10" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "WireframeTag"="Unlit/Transparent/NoTex 2 Sided" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" }
"!!GLSL
#ifdef VERTEX

uniform vec4 unity_LightmapST;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D unity_Lightmap;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 retColor_1;
  retColor_1.w = _Color.w;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (_Color.xyz * ((8.0 * tmpvar_2.w) * tmpvar_2.xyz));
  vec4 srcColor_3;
  srcColor_3.w = retColor_1.w;
  srcColor_3.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_4;
  tmpvar_4 = mix (V_WIRE_COLOR, srcColor_3, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
  srcColor_3 = tmpvar_4;
  retColor_1 = tmpvar_4;
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord1 o1
dcl_color0 o2
dcl_position0 v0
dcl_texcoord1 v1
dcl_color0 v2
mov o2, v2
mad o1.xy, v1, c4, c4.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 64
Vector 48 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefieceddkdfcjhglijbajkcbolijhggalekbmijabaaaaaahaacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaagfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcfiabaaaaeaaaabaafgaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafpccabaaa
acaaaaaaegbobaaaacaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL
#ifdef VERTEX

uniform vec4 unity_LightmapST;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D unity_Lightmap;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 retColor_1;
  retColor_1.w = _Color.w;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (_Color.xyz * ((8.0 * tmpvar_2.w) * tmpvar_2.xyz));
  vec4 srcColor_3;
  srcColor_3.w = retColor_1.w;
  vec3 tmpvar_4;
  vec3 t_5;
  t_5 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_4 = (t_5 * (t_5 * (3.0 - (2.0 * t_5))));
  srcColor_3.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_6;
  tmpvar_6 = mix (V_WIRE_COLOR, srcColor_3, vec4(min (min (tmpvar_4.x, tmpvar_4.y), tmpvar_4.z)));
  srcColor_3 = tmpvar_6;
  retColor_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_6;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord1 o1
dcl_color0 o2
dcl_position0 v0
dcl_texcoord1 v1
dcl_color0 v2
mov o2, v2
mad o1.xy, v1, c4, c4.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 64
Vector 48 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefieceddkdfcjhglijbajkcbolijhggalekbmijabaaaaaahaacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaagfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcfiabaaaaeaaaabaafgaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafpccabaaa
acaaaaaaegbobaaaacaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" }
"!!GLSL
#ifdef VERTEX

varying vec4 xlv_COLOR;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 srcColor_1;
  srcColor_1.w = _Color.w;
  srcColor_1.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_2;
  tmpvar_2 = mix (V_WIRE_COLOR, srcColor_1, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
  srcColor_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position o0
dcl_color0 o1
dcl_position0 v0
dcl_color0 v1
mov o1, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedamflbolapkbcdegjcikakklimmmoahnpabaaaaaanmabaaaaadaaaaaa
cmaaaaaahmaaaaaanaaaaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafaepfdejfeejepeoaaedepemepfcaaklepfdeheo
emaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaaklklfdeieefcaeabaaaaeaaaabaaebaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL
#ifdef VERTEX

varying vec4 xlv_COLOR;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 srcColor_1;
  srcColor_1.w = _Color.w;
  vec3 tmpvar_2;
  vec3 t_3;
  t_3 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_2 = (t_3 * (t_3 * (3.0 - (2.0 * t_3))));
  srcColor_1.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_4;
  tmpvar_4 = mix (V_WIRE_COLOR, srcColor_1, vec4(min (min (tmpvar_2.x, tmpvar_2.y), tmpvar_2.z)));
  srcColor_1 = tmpvar_4;
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position o0
dcl_color0 o1
dcl_position0 v0
dcl_color0 v1
mov o1, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedamflbolapkbcdegjcikakklimmmoahnpabaaaaaanmabaaaaadaaaaaa
cmaaaaaahmaaaaaanaaaaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafaepfdejfeejepeoaaedepemepfcaaklepfdeheo
emaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaaklklfdeieefcaeabaaaaeaaaabaaebaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
"ps_3_0
def c3, 1.00000000, 0.00000000, 0, 0
dcl_color0 v1.xyz
min_pp r0.x, v1, v1.y
min_pp r0.x, r0, v1.z
add_pp r0.x, r0, -c1
mov_pp r1.xyz, c0
mov_pp r1.w, c2
add_pp r1, r1, -c0
cmp_pp r0.x, r0, c3, c3.y
mad_pp oC0, r0.x, r1, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" }
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmgcedooleednmlkjejceookhkbmpeklkabaaaaaapmabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefccaabaaaaeaaaaaaa
eiaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaadhcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaddaaaaahbcaabaaaaaaaaaaa
bkbabaaaacaaaaaaakbabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaaaacaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpdgaaaaaihcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaakicaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
aaaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
"ps_3_0
def c3, 20.00000000, 2.00000000, 3.00000000, 0
dcl_color0 v1.xyz
dsy_pp r1.xyz, v1
dsx_pp r0.xyz, v1
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r0.xyz, v1, r0
mad_pp r1.xyz, -r0, c3.y, c3.z
mul_pp r0.xyz, r0, r0
mul_pp r1.xyz, r0, r1
min_pp r1.x, r1, r1.y
mov_pp r0.w, c2
mov_pp r0.xyz, c0
add_pp r0, r0, -c0
min_pp r1.x, r1, r1.z
mad_pp oC0, r1.x, r0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_ON" }
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedaniebnfnnbmmbdcbjjcaffifnpnamfpeabaaaaaaamadaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdaacaaaaeaaaaaaa
imaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaadhcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaalaaaaafhcaabaaaaaaaaaaa
egbcbaaaacaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaaacaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaiaibaaaaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaa
diaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaakaebaaaakaeb
aaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaacaaaaaadcaaaaaphcaabaaaabaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaah
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaaihcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaakicaabaaa
abaaaaaadkiacaiaebaaaaaaaaaaaaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaa
dcaaaaakpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegiocaaa
aaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
"ps_3_0
def c3, 1.00000000, 0.00000000, 0, 0
dcl_color0 v0.xyz
min_pp r0.x, v0, v0.y
min_pp r0.x, r0, v0.z
add_pp r0.x, r0, -c1
mov_pp r1.xyz, c0
mov_pp r1.w, c2
add_pp r1, r1, -c0
cmp_pp r0.x, r0, c3, c3.y
mad_pp oC0, r0.x, r1, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" }
ConstBuffer "$Globals" 48
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecednplnedmeokcmppencdhfmagjmmneiojgabaaaaaanmabaaaaadaaaaaa
cmaaaaaaiaaaaaaaleaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaaklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefccaabaaaaeaaaaaaa
eiaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaadhcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaddaaaaahbcaabaaaaaaaaaaa
bkbabaaaabaaaaaaakbabaaaabaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaaaabaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpdgaaaaaihcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaakicaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
aaaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_ON" }
Vector 0 [V_WIRE_COLOR]
Float 1 [V_WIRE_SIZE]
Vector 2 [_Color]
"ps_3_0
def c3, 20.00000000, 2.00000000, 3.00000000, 0
dcl_color0 v0.xyz
dsy_pp r1.xyz, v0
dsx_pp r0.xyz, v0
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r0.xyz, v0, r0
mad_pp r1.xyz, -r0, c3.y, c3.z
mul_pp r0.xyz, r0, r0
mul_pp r1.xyz, r0, r1
min_pp r1.x, r1, r1.y
mov_pp r0.w, c2
mov_pp r0.xyz, c0
add_pp r0, r0, -c0
min_pp r1.x, r1, r1.z
mad_pp oC0, r1.x, r0, c0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_ON" }
ConstBuffer "$Globals" 48
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmbepgepelmiiefglhchijabgliapnohnabaaaaaaomacaaaaadaaaaaa
cmaaaaaaiaaaaaaaleaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaaklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdaacaaaaeaaaaaaa
imaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaadhcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaalaaaaafhcaabaaaaaaaaaaa
egbcbaaaabaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaaabaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaiaibaaaaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaa
diaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaakaebaaaakaeb
aaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaabaaaaaadcaaaaaphcaabaaaabaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
ddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaah
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaaihcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaakicaabaaa
abaaaaaadkiacaiaebaaaaaaaaaaaaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaa
dcaaaaakpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegiocaaa
aaaaaaaaaaaaaaaadoaaaaab"
}
}
 }
}
}