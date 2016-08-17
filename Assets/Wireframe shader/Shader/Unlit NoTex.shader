Shader "VacuumShaders/The Amazing Wireframe/Unlit/NoTex" {
Properties {
[Tag]  V_WIRE_TAG ("", Float) = 0
[DefaultOptions]  V_WIRE_D_OPTIONS ("", Float) = 0
 _Color ("Main Color (RGB)", Color) = (1,1,1,1)
[WireframeOptions]  V_WIRE_W_OPTIONS ("", Float) = 0
[MaterialToggle(V_WIRE_ANTIALIASING_ON)]  AO ("Antialiasing", Float) = 0
[MaterialToggle(V_WIRE_LIGHT_ON)]  LO ("Lightmaps effect Wire", Float) = 0
[MaterialToggle(V_WIRE_FRESNEL_ON)]  FO ("Fresnel Wire", Float) = 0
 V_WIRE_COLOR ("Wire Color (RGB) Trans (A)", Color) = (0,0,0,1)
 V_WIRE_SIZE ("Wire Size", Range(0,0.5)) = 0.05
}
SubShader { 
 Tags { "RenderType"="Opaque" "WireframeTag"="Unlit/NoTex" }
 Pass {
  Tags { "RenderType"="Opaque" "WireframeTag"="Unlit/NoTex" }
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
  vec4 tmpvar_3;
  tmpvar_3 = mix (mix (retColor_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww), retColor_1, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
  retColor_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
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
  vec4 tmpvar_3;
  tmpvar_3 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_3;
  vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_3, retColor_1, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
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
  vec3 tmpvar_3;
  vec3 t_4;
  t_4 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_3 = (t_4 * (t_4 * (3.0 - (2.0 * t_4))));
  vec4 tmpvar_5;
  tmpvar_5 = mix (mix (retColor_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww), retColor_1, vec4(min (min (tmpvar_3.x, tmpvar_3.y), tmpvar_3.z)));
  retColor_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_5;
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
  vec3 tmpvar_3;
  vec3 t_4;
  t_4 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_3 = (t_4 * (t_4 * (3.0 - (2.0 * t_4))));
  vec4 tmpvar_5;
  tmpvar_5 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5, retColor_1, vec4(min (min (tmpvar_3.x, tmpvar_3.y), tmpvar_3.z)));
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
  vec4 tmpvar_4;
  tmpvar_4 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, V_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_4;
  vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_4, retColor_1, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
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
  vec4 tmpvar_4;
  tmpvar_4 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_4;
  vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_4, retColor_1, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
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
  vec3 tmpvar_4;
  vec3 t_5;
  t_5 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_4 = (t_5 * (t_5 * (3.0 - (2.0 * t_5))));
  vec4 tmpvar_6;
  tmpvar_6 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, V_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6, retColor_1, vec4(min (min (tmpvar_4.x, tmpvar_4.y), tmpvar_4.z)));
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
  vec3 tmpvar_4;
  vec3 t_5;
  t_5 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_4 = (t_5 * (t_5 * (3.0 - (2.0 * t_5))));
  vec4 tmpvar_6;
  tmpvar_6 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6, retColor_1, vec4(min (min (tmpvar_4.x, tmpvar_4.y), tmpvar_4.z)));
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
  gl_FragData[0] = mix (mix (_Color, V_WIRE_COLOR, V_WIRE_COLOR.wwww), _Color, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
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
  vec4 tmpvar_1;
  tmpvar_1 = mix (_Color, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_1;
  gl_FragData[0] = mix (tmpvar_1, _Color, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
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
  vec3 tmpvar_1;
  vec3 t_2;
  t_2 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_1 = (t_2 * (t_2 * (3.0 - (2.0 * t_2))));
  gl_FragData[0] = mix (mix (_Color, V_WIRE_COLOR, V_WIRE_COLOR.wwww), _Color, vec4(min (min (tmpvar_1.x, tmpvar_1.y), tmpvar_1.z)));
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
  vec3 tmpvar_1;
  vec3 t_2;
  t_2 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_1 = (t_2 * (t_2 * (3.0 - (2.0 * t_2))));
  vec4 tmpvar_3;
  tmpvar_3 = mix (_Color, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_3;
  gl_FragData[0] = mix (tmpvar_3, _Color, vec4(min (min (tmpvar_1.x, tmpvar_1.y), tmpvar_1.z)));
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
  gl_FragData[0] = mix (mix (_Color, V_WIRE_COLOR, V_WIRE_COLOR.wwww), _Color, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
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
  vec4 tmpvar_1;
  tmpvar_1 = mix (_Color, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_1;
  gl_FragData[0] = mix (tmpvar_1, _Color, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
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
  vec3 tmpvar_1;
  vec3 t_2;
  t_2 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_1 = (t_2 * (t_2 * (3.0 - (2.0 * t_2))));
  gl_FragData[0] = mix (mix (_Color, V_WIRE_COLOR, V_WIRE_COLOR.wwww), _Color, vec4(min (min (tmpvar_1.x, tmpvar_1.y), tmpvar_1.z)));
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
  vec3 tmpvar_1;
  vec3 t_2;
  t_2 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_1 = (t_2 * (t_2 * (3.0 - (2.0 * t_2))));
  vec4 tmpvar_3;
  tmpvar_3 = mix (_Color, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_3;
  gl_FragData[0] = mix (tmpvar_3, _Color, vec4(min (min (tmpvar_1.x, tmpvar_1.y), tmpvar_1.z)));
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
SetTexture 0 [unity_Lightmap] 2D 0
"ps_3_0
dcl_2d s0
def c3, 8.00000000, 1.00000000, 0.00000000, 0
dcl_texcoord1 v0.xy
dcl_color0 v1.xyz
texld r0, v0, s0
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c2
min_pp r2.x, v1, v1.y
min_pp r2.x, r2, v1.z
add_pp r2.x, r2, -c1
mul_pp r0.xyz, r0, c3.x
mov_pp r0.w, c2
add_pp r1, -r0, c0
mul_pp r1, r1, c0.w
add_pp r0, r1, r0
cmp_pp r2.x, r2, c3.y, c3.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
SetTexture 0 [unity_Lightmap] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedebnfcfafaeaacojnehfmgelbapfidnmeabaaaaaaniacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpmabaaaaeaaaaaaa
hpaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaddaaaaah
bcaabaaaaaaaaaaabkbabaaaacaaaaaaakbabaaaacaaaaaaddaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackbabaaaacaaaaaabnaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaa
abaaaaaafgafbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaajgahbaaaaaaaaaaa
egiccaaaaaaaaaaaacaaaaaadgaaaaagicaabaaaabaaaaaadkiacaaaaaaaaaaa
acaaaaaaaaaaaaajpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegiocaaa
aaaaaaaaaaaaaaaadcaaaaakpcaabaaaacaaaaaapgipcaaaaaaaaaaaaaaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadoaaaaab"
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
SetTexture 0 [unity_Lightmap] 2D 0
"ps_3_0
dcl_2d s0
def c3, 8.00000000, 1.00000000, 0.00000000, 0
dcl_texcoord1 v0.xy
dcl_texcoord3 v1.x
dcl_color0 v2.xyz
texld r0, v0, s0
mul_pp r0.xyz, r0.w, r0
mul_pp r2.x, v1, c0.w
mul_pp r0.xyz, r0, c2
mul_pp r1.xyz, r0, c3.x
min_pp r2.y, v2.x, v2
mov_pp r1.w, c2
mov_pp r0.w, r2.x
mov_pp r0.xyz, c0
add_pp r0, r0, -r1
mul_pp r0, r2.x, r0
min_pp r2.y, r2, v2.z
add_pp r2.x, r2.y, -c1
add_pp r1, r0, r1
cmp_pp r2.x, r2, c3.y, c3.z
mad_pp oC0, r2.x, -r0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
SetTexture 0 [unity_Lightmap] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedckmnceflnjgmnpdlnafjehdjapkiidamabaaaaaagiadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfmacaaaaeaaaaaaajhaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaa
egiccaiaebaaaaaaaaaaaaaaacaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaaibcaabaaaacaaaaaackbabaaaabaaaaaadkiacaaaaaaaaaaa
aaaaaaaadgaaaaagicaabaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaadcaaaaal
icaabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaackbabaaaabaaaaaadkaabaia
ebaaaaaaaaaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaacaaaaaaegaobaaa
abaaaaaaegaobaaaaaaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaiaebaaaaaaabaaaaaaddaaaaahbcaabaaaacaaaaaabkbabaaaadaaaaaa
akbabaaaadaaaaaaddaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaackbabaaa
adaaaaaabnaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaa
abaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadp
dcaaaaajpccabaaaaaaaaaaaagaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaadoaaaaab"
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
texld r0, v0, s0
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c2
mul_pp r2.xyz, r1, r1
mad_pp r3.xyz, -r1, c3.z, c3.w
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
mov_pp r0.w, c2
mul_pp r0.xyz, r0, c3.x
add_pp r1, -r0, c0
mul_pp r1, r1, c0.w
add_pp r0, r1, r0
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
SetTexture 0 [unity_Lightmap] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedndokbogkollloikopoddjkdbmnglmbglabaaaaaaoiadaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcamadaaaaeaaaaaaa
mdaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
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
hcaabaaaabaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaadgaaaaag
icaabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaadcaaaaakpcaabaaa
acaaaaaapgipcaaaaaaaaaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadoaaaaab"
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
SetTexture 0 [unity_Lightmap] 2D 0
"ps_3_0
dcl_2d s0
def c3, 8.00000000, 20.00000000, 2.00000000, 3.00000000
dcl_texcoord1 v0.xy
dcl_texcoord3 v1.x
dcl_color0 v2.xyz
mul_pp r2.w, v1.x, c0
dsy_pp r0.xyz, v2
dsx_pp r1.xyz, v2
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r1.xyz, r0, c3.y
texld r0, v0, s0
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c2
rcp_pp r1.x, r1.x
rcp_pp r1.y, r1.y
rcp_pp r1.z, r1.z
mul_pp_sat r2.xyz, v2, r1
mad_pp r3.xyz, -r2, c3.z, c3.w
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
mul_pp r0.xyz, r0, c3.x
mov_pp r0.w, c2
mov_pp r1.xyz, c0
mov_pp r1.w, r2
add_pp r1, r1, -r0
mul_pp r1, r2.w, r1
add_pp r0, r1, r0
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
SetTexture 0 [unity_Lightmap] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedackakecmnidlfagdnnodchloojjdololabaaaaaahiaeaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcgmadaaaaeaaaaaaanlaaaaaafjaaaaaeegiocaaaaaaaaaaa
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
ocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaadcaaaaamhcaabaaa
abaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaajgahbaaaaaaaaaaaegiccaaa
aaaaaaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaajgahbaaaaaaaaaaaegiccaaa
aaaaaaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaackbabaaaabaaaaaadkiacaaa
aaaaaaaaaaaaaaaadgaaaaagicaabaaaacaaaaaadkiacaaaaaaaaaaaacaaaaaa
dcaaaaalicaabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaackbabaaaabaaaaaa
dkaabaiaebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaia
ebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadoaaaaab"
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
mul_pp r1.xyz, r0, c3.x
mul_pp r0.xyz, r1, c0
min_pp r2.x, v1, v1.y
min_pp r2.x, r2, v1.z
add_pp r2.x, r2, -c1
mul_pp r1.xyz, r1, c2
mov_pp r1.w, c2
mov_pp r0.w, c0
add_pp r0, r0, -r1
mul_pp r0, r0, c0.w
add_pp r1, r0, r1
cmp_pp r2.x, r2, c3.y, c3.z
mad_pp oC0, r2.x, -r0, r1
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
eefiecednnabohkcjpjfbiekgnlamfccajlccfbnabaaaaaaamadaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdaacaaaaeaaaaaaa
imaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaadgaaaaagicaabaaa
abaaaaaadkiacaaaaaaaaaaaaaaaaaaadgaaaaagicaabaaaaaaaaaaadkiacaaa
aaaaaaaaacaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaapgipcaaaaaaaaaaaaaaaaaaa
egaobaaaabaaaaaaegaobaaaaaaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaiaebaaaaaaabaaaaaaddaaaaahbcaabaaaacaaaaaabkbabaaa
acaaaaaaakbabaaaacaaaaaaddaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
ckbabaaaacaaaaaabnaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaa
aaaaaaaaabaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaiadpdcaaaaajpccabaaaaaaaaaaaagaabaaaacaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadoaaaaab"
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
mul_pp r1.xyz, r0, c3.x
mul_pp r2.x, v1, c0.w
mul_pp r0.xyz, r1, c0
min_pp r2.y, v2.x, v2
mul_pp r1.xyz, r1, c2
mov_pp r1.w, c2
mov_pp r0.w, r2.x
add_pp r0, r0, -r1
mul_pp r0, r2.x, r0
min_pp r2.y, r2, v2.z
add_pp r2.x, r2.y, -c1
add_pp r1, r0, r1
cmp_pp r2.x, r2, c3.y, c3.z
mad_pp oC0, r2.x, -r0, r1
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
eefiecedailgklecnmllkpiibgmocnmbbmdnajcbabaaaaaaemadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefceaacaaaaeaaaaaaajaaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaaiicaabaaaabaaaaaa
ckbabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaadgaaaaagicaabaaaaaaaaaaa
dkiacaaaaaaaaaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaajpcaabaaaabaaaaaapgapbaaaabaaaaaa
egaobaaaacaaaaaaegaobaaaaaaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaiaebaaaaaaabaaaaaaddaaaaahbcaabaaaacaaaaaabkbabaaa
adaaaaaaakbabaaaadaaaaaaddaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
ckbabaaaadaaaaaabnaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaa
aaaaaaaaabaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaiadpdcaaaaajpccabaaaaaaaaaaaagaabaaaacaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadoaaaaab"
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
mul_pp r1.xyz, r0, c3.y
texld r0, v0, s0
mul_pp r0.xyz, r0.w, r0
rcp_pp r1.x, r1.x
rcp_pp r1.y, r1.y
rcp_pp r1.z, r1.z
mul_pp_sat r2.xyz, v1, r1
mul_pp r0.xyz, r0, c3.x
mul_pp r1.xyz, r0, c0
mad_pp r3.xyz, -r2, c3.z, c3.w
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
mul_pp r0.xyz, r0, c2
mov_pp r0.w, c2
mov_pp r1.w, c0
add_pp r1, r1, -r0
mul_pp r1, r1, c0.w
add_pp r0, r1, r0
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
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
eefiecedljebfgimhfndnklfdmpacfeancfbhcceabaaaaaabmaeaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceaadaaaaeaaaaaaa
naaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
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
hcaabaaaabaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaadiaaaaai
hcaabaaaacaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaadgaaaaag
icaabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaadgaaaaagicaabaaaacaaaaaa
dkiacaaaaaaaaaaaacaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaapgipcaaaaaaaaaaa
aaaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpccabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadoaaaaab"
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
mul_pp r2.w, v1.x, c0
dsy_pp r0.xyz, v2
dsx_pp r1.xyz, v2
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r1.xyz, r0, c3.y
texld r0, v0, s0
mul_pp r0.xyz, r0.w, r0
rcp_pp r1.x, r1.x
rcp_pp r1.y, r1.y
rcp_pp r1.z, r1.z
mul_pp_sat r2.xyz, v2, r1
mul_pp r0.xyz, r0, c3.x
mul_pp r1.xyz, r0, c0
mad_pp r3.xyz, -r2, c3.z, c3.w
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
mul_pp r0.xyz, r0, c2
mov_pp r0.w, c2
mov_pp r1.w, r2
add_pp r1, r1, -r0
mul_pp r1, r2.w, r1
add_pp r0, r1, r0
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
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
eefiecedjhgidjbmmkbdocngfacllmmngionidgoabaaaaaafmaeaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcfaadaaaaeaaaaaaaneaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaalaaaaafhcaabaaa
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
abaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaadiaaaaaihcaabaaa
acaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaaiicaabaaa
abaaaaaackbabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaadgaaaaagicaabaaa
acaaaaaadkiacaaaaaaaaaaaacaaaaaaaaaaaaaipcaabaaaadaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaapgapbaaa
abaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpccabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadoaaaaab"
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
mov_pp r0, c0
min_pp r1.x, v0, v0.y
min_pp r1.x, r1, v0.z
add_pp r2.x, r1, -c1
add_pp r0, -c2, r0
mul_pp r0, r0, c0.w
add_pp r1, r0, c2
cmp_pp r2.x, r2, c3, c3.y
mad_pp oC0, r2.x, -r0, r1
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
eefiecedaflgoamadbnppcbfgjofkimbefilkojlabaaaaaaaiacaaaaadaaaaaa
cmaaaaaaiaaaaaaaleaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaaklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcemabaaaaeaaaaaaa
fdaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaadhcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaddaaaaahbcaabaaaaaaaaaaa
bkbabaaaabaaaaaaakbabaaaabaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaaaabaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaa
egiocaiaebaaaaaaaaaaaaaaacaaaaaadcaaaaalpcaabaaaabaaaaaapgipcaaa
aaaaaaaaaaaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaaaaaaaaaj
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaa
dcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadoaaaaab"
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
mul_pp r1.x, v0, c0.w
min_pp r1.y, v1.x, v1
min_pp r1.y, r1, v1.z
add_pp r2.x, r1.y, -c1
mov_pp r0.w, r1.x
mov_pp r0.xyz, c0
add_pp r0, r0, -c2
mul_pp r0, r1.x, r0
add_pp r1, r0, c2
cmp_pp r2.x, r2, c3, c3.y
mad_pp oC0, r2.x, -r0, r1
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
eefiecedahdklpnphhnnbcgdejiocdogjkjbbigjabaaaaaajiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaadaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaheaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefckeabaaaaeaaaaaaagjaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaagcbaaaadbcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaddaaaaahbcaabaaa
aaaaaaaabkbabaaaacaaaaaaakbabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackbabaaaacaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaaaaaaaaaakbabaaaabaaaaaa
dkiacaaaaaaaaaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
aaaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaadcaaaaamicaabaaaabaaaaaa
dkiacaaaaaaaaaaaaaaaaaaaakbabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
acaaaaaadcaaaaakpcaabaaaabaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadoaaaaab"
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
dsy_pp r0.xyz, v0
dsx_pp r1.xyz, v0
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r2.xyz, v0, r0
mul_pp r1.xyz, r2, r2
mad_pp r2.xyz, -r2, c3.y, c3.z
mul_pp r1.xyz, r1, r2
mov_pp r0, c0
add_pp r0, -c2, r0
mul_pp r0, r0, c0.w
min_pp r1.x, r1, r1.y
add_pp r2, r0, c2
min_pp r1.x, r1, r1.z
mad_pp oC0, r1.x, -r0, r2
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
eefiecedhpmcghkipadicladmpmogfnllkbcngfnabaaaaaabiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaleaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaaklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfmacaaaaeaaaaaaa
jhaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaadhcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaalaaaaafhcaabaaaaaaaaaaa
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
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaaaaaaaaaegiocaiaebaaaaaaaaaaaaaaacaaaaaa
dcaaaaalpcaabaaaabaaaaaapgipcaaaaaaaaaaaaaaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadoaaaaab"
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
mul_pp r1.w, v0.x, c0
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
mul_pp_sat r0.xyz, v1, r0
mad_pp r2.xyz, -r0, c3.y, c3.z
mul_pp r1.xyz, r0, r0
mul_pp r1.xyz, r1, r2
min_pp r1.x, r1, r1.y
mov_pp r0.xyz, c0
mov_pp r0.w, r1
add_pp r0, r0, -c2
mul_pp r0, r1.w, r0
add_pp r2, r0, c2
min_pp r1.x, r1, r1.z
mad_pp oC0, r1.x, -r0, r2
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
eefiecedndnpemngdiedcdhkegffeniapbjpiaebabaaaaaakiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaadaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaheaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcleacaaaaeaaaaaaaknaaaaaafjaaaaae
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
ccaabaaaaaaaaaaaakbabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaaaaaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaa
acaaaaaadcaaaaamicaabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaaakbabaaa
abaaaaaadkiacaiaebaaaaaaaaaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaaaaaaaaaj
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaa
dcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadoaaaaab"
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
mov_pp r0, c0
min_pp r1.x, v0, v0.y
min_pp r1.x, r1, v0.z
add_pp r2.x, r1, -c1
add_pp r0, -c2, r0
mul_pp r0, r0, c0.w
add_pp r1, r0, c2
cmp_pp r2.x, r2, c3, c3.y
mad_pp oC0, r2.x, -r0, r1
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
eefiecedaflgoamadbnppcbfgjofkimbefilkojlabaaaaaaaiacaaaaadaaaaaa
cmaaaaaaiaaaaaaaleaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaaklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcemabaaaaeaaaaaaa
fdaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaadhcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaddaaaaahbcaabaaaaaaaaaaa
bkbabaaaabaaaaaaakbabaaaabaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaaaabaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaa
egiocaiaebaaaaaaaaaaaaaaacaaaaaadcaaaaalpcaabaaaabaaaaaapgipcaaa
aaaaaaaaaaaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaaaaaaaaaj
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaa
dcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadoaaaaab"
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
mul_pp r1.x, v0, c0.w
min_pp r1.y, v1.x, v1
min_pp r1.y, r1, v1.z
add_pp r2.x, r1.y, -c1
mov_pp r0.w, r1.x
mov_pp r0.xyz, c0
add_pp r0, r0, -c2
mul_pp r0, r1.x, r0
add_pp r1, r0, c2
cmp_pp r2.x, r2, c3, c3.y
mad_pp oC0, r2.x, -r0, r1
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
eefiecedahdklpnphhnnbcgdejiocdogjkjbbigjabaaaaaajiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaadaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaheaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefckeabaaaaeaaaaaaagjaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaagcbaaaadbcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaddaaaaahbcaabaaa
aaaaaaaabkbabaaaacaaaaaaakbabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackbabaaaacaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaaaaaaaaaakbabaaaabaaaaaa
dkiacaaaaaaaaaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
aaaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaadcaaaaamicaabaaaabaaaaaa
dkiacaaaaaaaaaaaaaaaaaaaakbabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
acaaaaaadcaaaaakpcaabaaaabaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadoaaaaab"
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
dsy_pp r0.xyz, v0
dsx_pp r1.xyz, v0
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r2.xyz, v0, r0
mul_pp r1.xyz, r2, r2
mad_pp r2.xyz, -r2, c3.y, c3.z
mul_pp r1.xyz, r1, r2
mov_pp r0, c0
add_pp r0, -c2, r0
mul_pp r0, r0, c0.w
min_pp r1.x, r1, r1.y
add_pp r2, r0, c2
min_pp r1.x, r1, r1.z
mad_pp oC0, r1.x, -r0, r2
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
eefiecedhpmcghkipadicladmpmogfnllkbcngfnabaaaaaabiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaleaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaaklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfmacaaaaeaaaaaaa
jhaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaadhcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaalaaaaafhcaabaaaaaaaaaaa
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
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaaaaaaaaaegiocaiaebaaaaaaaaaaaaaaacaaaaaa
dcaaaaalpcaabaaaabaaaaaapgipcaaaaaaaaaaaaaaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadoaaaaab"
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
mul_pp r1.w, v0.x, c0
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
mul_pp_sat r0.xyz, v1, r0
mad_pp r2.xyz, -r0, c3.y, c3.z
mul_pp r1.xyz, r0, r0
mul_pp r1.xyz, r1, r2
min_pp r1.x, r1, r1.y
mov_pp r0.xyz, c0
mov_pp r0.w, r1
add_pp r0, r0, -c2
mul_pp r0, r1.w, r0
add_pp r2, r0, c2
min_pp r1.x, r1, r1.z
mad_pp oC0, r1.x, -r0, r2
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
eefiecedndnpemngdiedcdhkegffeniapbjpiaebabaaaaaakiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaadaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaheaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaaaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcleacaaaaeaaaaaaaknaaaaaafjaaaaae
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
ccaabaaaaaaaaaaaakbabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaaaaaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaa
acaaaaaadcaaaaamicaabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaaakbabaaa
abaaaaaadkiacaiaebaaaaaaaaaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaaaaaaaaaj
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaa
dcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadoaaaaab"
}
}
 }
}
}