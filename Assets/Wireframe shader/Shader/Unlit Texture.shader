Shader "VacuumShaders/The Amazing Wireframe/Unlit/Texture" {
Properties {
[Tag]  V_WIRE_TAG ("", Float) = 0
[DefaultOptions]  V_WIRE_D_OPTIONS ("", Float) = 0
 _Color ("Main Color (RGB)", Color) = (1,1,1,1)
 _MainTex ("Base (RGB)", 2D) = "white" {}
[WireframeOptions]  V_WIRE_W_OPTIONS ("", Float) = 0
[MaterialToggle(V_WIRE_ANTIALIASING_ON)]  AO ("Antialiasing", Float) = 0
[MaterialToggle(V_WIRE_LIGHT_ON)]  LO ("Lightmaps effect Wire", Float) = 0
[MaterialToggle(V_WIRE_FRESNEL_ON)]  FO ("Fresnel Wire", Float) = 0
 V_WIRE_COLOR ("Wire Color (RGB) Trans (A)", Color) = (0,0,0,1)
 V_WIRE_SIZE ("Wire Size", Range(0,0.5)) = 0.05
}
SubShader { 
 Tags { "RenderType"="Opaque" "WireframeTag"="Unlit/Texture" }
 Pass {
  Tags { "RenderType"="Opaque" "WireframeTag"="Unlit/Texture" }
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 retColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (tmpvar_2.xyz * ((8.0 * tmpvar_3.w) * tmpvar_3.xyz));
  vec4 tmpvar_4;
  tmpvar_4 = mix (mix (retColor_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww), retColor_1, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
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
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
Vector 5 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_color0 o3
def c6, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
mov o3, v3
mad o1.xy, v1, c4, c4.zwzw
mad o2.xy, v2, c5, c5.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c6.x
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 48 [_MainTex_ST]
Vector 64 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmokofnkopmefedacmfcnedkichhdmjikabaaaaaapiacaaaaadaaaaaa
cmaaaaaaleaaaaaaeaabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaahbaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefclaabaaaaeaaaabaagmaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaadpcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaabaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
dgaaaaafpccabaaaadaaaaaaegbobaaaadaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
varying vec3 xlv_TEXCOORD0;
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
  vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
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
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  vec4 retColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (tmpvar_2.xyz * ((8.0 * tmpvar_3.w) * tmpvar_3.xyz));
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
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
Vector 11 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
dcl_color0 o4
def c12, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mov r1.w, c12.x
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
add o3.x, -r0, c12
mov o4, v4
mad o1.xy, v2, c10, c10.zwzw
mad o2.xy, v3, c11, c11.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c12.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 48 [_MainTex_ST]
Vector 64 [unity_LightmapST]
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
eefiecedacejcmglmpfchipmmbikfaimpapjaknlabaaaaaamaaeaaaaadaaaaaa
cmaaaaaaneaaaaaajaabaaaaejfdeheokaaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoleaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
aealaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahapaaaaknaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcciadaaaaeaaaabaamkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadeccabaaaacaaaaaa
gfaaaaadpccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafeccabaaa
abaaaaaaabeaaaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
acaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaai
eccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaal
dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadgaaaaafpccabaaaaeaaaaaaegbobaaaaeaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 retColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (tmpvar_2.xyz * ((8.0 * tmpvar_3.w) * tmpvar_3.xyz));
  vec3 tmpvar_4;
  vec3 t_5;
  t_5 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_4 = (t_5 * (t_5 * (3.0 - (2.0 * t_5))));
  vec4 tmpvar_6;
  tmpvar_6 = mix (mix (retColor_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww), retColor_1, vec4(min (min (tmpvar_4.x, tmpvar_4.y), tmpvar_4.z)));
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
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
Vector 5 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_color0 o3
def c6, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
mov o3, v3
mad o1.xy, v1, c4, c4.zwzw
mad o2.xy, v2, c5, c5.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c6.x
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 48 [_MainTex_ST]
Vector 64 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmokofnkopmefedacmfcnedkichhdmjikabaaaaaapiacaaaaadaaaaaa
cmaaaaaaleaaaaaaeaabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaahbaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefclaabaaaaeaaaabaagmaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaadpcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaabaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
dgaaaaafpccabaaaadaaaaaaegbobaaaadaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
varying vec3 xlv_TEXCOORD0;
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
  vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
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
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  vec4 retColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  retColor_1.xyz = (tmpvar_2.xyz * ((8.0 * tmpvar_3.w) * tmpvar_3.xyz));
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
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
Vector 11 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
dcl_color0 o4
def c12, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mov r1.w, c12.x
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
add o3.x, -r0, c12
mov o4, v4
mad o1.xy, v2, c10, c10.zwzw
mad o2.xy, v3, c11, c11.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c12.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 48 [_MainTex_ST]
Vector 64 [unity_LightmapST]
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
eefiecedacejcmglmpfchipmmbikfaimpapjaknlabaaaaaamaaeaaaaadaaaaaa
cmaaaaaaneaaaaaajaabaaaaejfdeheokaaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoleaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
aealaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahapaaaaknaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcciadaaaaeaaaabaamkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadeccabaaaacaaaaaa
gfaaaaadpccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafeccabaaa
abaaaaaaabeaaaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
acaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaai
eccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaal
dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadgaaaaafpccabaaaaeaaaaaaegbobaaaaeaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.w = V_WIRE_COLOR.w;
  vec4 retColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  vec3 tmpvar_4;
  tmpvar_4 = ((8.0 * tmpvar_3.w) * tmpvar_3.xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_4);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_4);
  vec4 tmpvar_5;
  tmpvar_5 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, V_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5, retColor_1, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
  retColor_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_6;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
Vector 5 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_color0 o3
def c6, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
mov o3, v3
mad o1.xy, v1, c4, c4.zwzw
mad o2.xy, v2, c5, c5.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c6.x
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 48 [_MainTex_ST]
Vector 64 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmokofnkopmefedacmfcnedkichhdmjikabaaaaaapiacaaaaadaaaaaa
cmaaaaaaleaaaaaaeaabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaahbaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefclaabaaaaeaaaabaagmaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaadpcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaabaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
dgaaaaafpccabaaaadaaaaaaegbobaaaadaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
varying vec3 xlv_TEXCOORD0;
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
  vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
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
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 retColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  vec3 tmpvar_4;
  tmpvar_4 = ((8.0 * tmpvar_3.w) * tmpvar_3.xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_4);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_4);
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec4 tmpvar_5;
  tmpvar_5 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5, retColor_1, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
  retColor_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_6;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
Vector 11 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
dcl_color0 o4
def c12, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mov r1.w, c12.x
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
add o3.x, -r0, c12
mov o4, v4
mad o1.xy, v2, c10, c10.zwzw
mad o2.xy, v3, c11, c11.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c12.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 48 [_MainTex_ST]
Vector 64 [unity_LightmapST]
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
eefiecedacejcmglmpfchipmmbikfaimpapjaknlabaaaaaamaaeaaaaadaaaaaa
cmaaaaaaneaaaaaajaabaaaaejfdeheokaaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoleaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
aealaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahapaaaaknaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcciadaaaaeaaaabaamkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadeccabaaaacaaaaaa
gfaaaaadpccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafeccabaaa
abaaaaaaabeaaaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
acaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaai
eccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaal
dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadgaaaaafpccabaaaaeaaaaaaegbobaaaaeaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.w = V_WIRE_COLOR.w;
  vec4 retColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  vec3 tmpvar_4;
  tmpvar_4 = ((8.0 * tmpvar_3.w) * tmpvar_3.xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_4);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_4);
  vec3 tmpvar_5;
  vec3 t_6;
  t_6 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_5 = (t_6 * (t_6 * (3.0 - (2.0 * t_6))));
  vec4 tmpvar_7;
  tmpvar_7 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, V_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_7, retColor_1, vec4(min (min (tmpvar_5.x, tmpvar_5.y), tmpvar_5.z)));
  retColor_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
Vector 5 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_color0 o3
def c6, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
mov o3, v3
mad o1.xy, v1, c4, c4.zwzw
mad o2.xy, v2, c5, c5.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c6.x
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 48 [_MainTex_ST]
Vector 64 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmokofnkopmefedacmfcnedkichhdmjikabaaaaaapiacaaaaadaaaaaa
cmaaaaaaleaaaaaaeaabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaahbaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefclaabaaaaeaaaabaagmaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaadpcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaabaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
dgaaaaafpccabaaaadaaaaaaegbobaaaadaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
varying vec3 xlv_TEXCOORD0;
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
  vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
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
uniform sampler2D _MainTex;
uniform sampler2D unity_Lightmap;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 retColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  retColor_1.w = tmpvar_2.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  vec3 tmpvar_4;
  tmpvar_4 = ((8.0 * tmpvar_3.w) * tmpvar_3.xyz);
  retColor_1.xyz = (tmpvar_2.xyz * tmpvar_4);
  xlat_mutableV_WIRE_COLOR.xyz = (V_WIRE_COLOR.xyz * tmpvar_4);
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec3 tmpvar_5;
  vec3 t_6;
  t_6 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_5 = (t_6 * (t_6 * (3.0 - (2.0 * t_6))));
  vec4 tmpvar_7;
  tmpvar_7 = mix (retColor_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_7, retColor_1, vec4(min (min (tmpvar_5.x, tmpvar_5.y), tmpvar_5.z)));
  retColor_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
Vector 11 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord3 o3
dcl_color0 o4
def c12, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mov r1.w, c12.x
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
add o3.x, -r0, c12
mov o4, v4
mad o1.xy, v2, c10, c10.zwzw
mad o2.xy, v3, c11, c11.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c12.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 48 [_MainTex_ST]
Vector 64 [unity_LightmapST]
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
eefiecedacejcmglmpfchipmmbikfaimpapjaknlabaaaaaamaaeaaaaadaaaaaa
cmaaaaaaneaaaaaajaabaaaaejfdeheokaaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaajaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaajaaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaajjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafaepfdejfeejepeoaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoleaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
aealaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahapaaaaknaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcciadaaaaeaaaabaamkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadpcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadeccabaaaacaaaaaa
gfaaaaadpccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafeccabaaa
abaaaaaaabeaaaaaaaaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
acaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaai
eccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaal
dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadgaaaaafpccabaaaaeaaaaaaegbobaaaaeaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  gl_FragData[0] = mix (mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww), tmpvar_1, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_color0 o2
def c5, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
mov o2, v2
mad o1.xy, v1, c4, c4.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c5.x
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedknnjdijpheedhijkpbiekgfccbnpideoabaaaaaaieacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaagfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcgmabaaaaeaaaabaaflaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafeccabaaa
abaaaaaaabeaaaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaacaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 _MainTex_ST;
varying vec3 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec4 tmpvar_2;
  tmpvar_2 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_2;
  gl_FragData[0] = mix (tmpvar_2, tmpvar_1, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
dcl_color0 o3
def c11, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
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
mov o1.z, c11.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_ST]
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
eefiecedandiceehbiifdbfelkhgeblhhhhilfijabaaaaaaemaeaaaaadaaaaaa
cmaaaaaalmaaaaaagaabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaaibaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahapaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefcoeacaaaaeaaaabaaljaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaadpcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadpccabaaa
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
aaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaiiccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egbobaaaadaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  vec3 tmpvar_2;
  vec3 t_3;
  t_3 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_2 = (t_3 * (t_3 * (3.0 - (2.0 * t_3))));
  gl_FragData[0] = mix (mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww), tmpvar_1, vec4(min (min (tmpvar_2.x, tmpvar_2.y), tmpvar_2.z)));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_color0 o2
def c5, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
mov o2, v2
mad o1.xy, v1, c4, c4.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c5.x
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedknnjdijpheedhijkpbiekgfccbnpideoabaaaaaaieacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaagfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcgmabaaaaeaaaabaaflaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafeccabaaa
abaaaaaaabeaaaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaacaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 _MainTex_ST;
varying vec3 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec3 tmpvar_2;
  vec3 t_3;
  t_3 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_2 = (t_3 * (t_3 * (3.0 - (2.0 * t_3))));
  vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_4;
  gl_FragData[0] = mix (tmpvar_4, tmpvar_1, vec4(min (min (tmpvar_2.x, tmpvar_2.y), tmpvar_2.z)));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
dcl_color0 o3
def c11, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
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
mov o1.z, c11.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_ST]
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
eefiecedandiceehbiifdbfelkhgeblhhhhilfijabaaaaaaemaeaaaaadaaaaaa
cmaaaaaalmaaaaaagaabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaaibaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahapaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefcoeacaaaaeaaaabaaljaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaadpcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadpccabaaa
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
aaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaiiccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egbobaaaadaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  gl_FragData[0] = mix (mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww), tmpvar_1, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_color0 o2
def c5, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
mov o2, v2
mad o1.xy, v1, c4, c4.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c5.x
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedknnjdijpheedhijkpbiekgfccbnpideoabaaaaaaieacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaagfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcgmabaaaaeaaaabaaflaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafeccabaaa
abaaaaaaabeaaaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaacaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 _MainTex_ST;
varying vec3 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec4 tmpvar_2;
  tmpvar_2 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_2;
  gl_FragData[0] = mix (tmpvar_2, tmpvar_1, vec4(float((min (min (xlv_COLOR.x, xlv_COLOR.y), xlv_COLOR.z) >= V_WIRE_SIZE))));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
dcl_color0 o3
def c11, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
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
mov o1.z, c11.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_ST]
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
eefiecedandiceehbiifdbfelkhgeblhhhhilfijabaaaaaaemaeaaaaadaaaaaa
cmaaaaaalmaaaaaagaabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaaibaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahapaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefcoeacaaaaeaaaabaaljaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaadpcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadpccabaaa
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
aaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaiiccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egbobaaaadaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.z = 0.0;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  vec3 tmpvar_2;
  vec3 t_3;
  t_3 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_2 = (t_3 * (t_3 * (3.0 - (2.0 * t_3))));
  gl_FragData[0] = mix (mix (tmpvar_1, V_WIRE_COLOR, V_WIRE_COLOR.wwww), tmpvar_1, vec4(min (min (tmpvar_2.x, tmpvar_2.y), tmpvar_2.z)));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_color0 o2
def c5, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
mov o2, v2
mad o1.xy, v1, c4, c4.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o1.z, c5.x
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedknnjdijpheedhijkpbiekgfccbnpideoabaaaaaaieacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaagfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklfdeieefcgmabaaaaeaaaabaaflaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaadpcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadgaaaaafeccabaaa
abaaaaaaabeaaaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaaacaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform vec4 _MainTex_ST;
varying vec3 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_COLOR;
void main ()
{
  vec3 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD3 = (1.0 - dot (gl_Normal, normalize((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - gl_Vertex.xyz))));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 V_WIRE_COLOR;
uniform float V_WIRE_SIZE;
uniform vec4 _Color;
uniform sampler2D _MainTex;
vec4 xlat_mutableV_WIRE_COLOR;
varying vec3 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec4 xlv_COLOR;
void main ()
{
  xlat_mutableV_WIRE_COLOR.xyz = V_WIRE_COLOR.xyz;
  vec4 tmpvar_1;
  tmpvar_1 = (_Color * texture2D (_MainTex, xlv_TEXCOORD0.xy));
  xlat_mutableV_WIRE_COLOR.w = (V_WIRE_COLOR.w * xlv_TEXCOORD3);
  vec3 tmpvar_2;
  vec3 t_3;
  t_3 = max (min ((xlv_COLOR.xyz / (((abs(dFdx(xlv_COLOR.xyz)) + abs(dFdy(xlv_COLOR.xyz))) * V_WIRE_SIZE) * 20.0)), 1.0), 0.0);
  tmpvar_2 = (t_3 * (t_3 * (3.0 - (2.0 * t_3))));
  vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_1, xlat_mutableV_WIRE_COLOR, xlat_mutableV_WIRE_COLOR.wwww);
  xlat_mutableV_WIRE_COLOR = tmpvar_4;
  gl_FragData[0] = mix (tmpvar_4, tmpvar_1, vec4(min (min (tmpvar_2.x, tmpvar_2.y), tmpvar_2.z)));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord3 o2
dcl_color0 o3
def c11, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
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
mov o1.z, c11.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 48 [_MainTex_ST]
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
eefiecedandiceehbiifdbfelkhgeblhhhhilfijabaaaaaaemaeaaaaadaaaaaa
cmaaaaaalmaaaaaagaabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaahiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaaibaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahapaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefcoeacaaaaeaaaabaaljaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaadpcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadpccabaaa
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
aaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaiiccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaldccabaaaabaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaa
dgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egbobaaaadaaaaaadoaaaaab"
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
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_color0 v2.xyz
texld r1, v1, s1
texld r0, v0, s0
min_pp r2.x, v2, v2.y
min_pp r2.x, r2, v2.z
add_pp r2.x, r2, -c1
mul_pp r0, r0, c2
mul_pp r1.xyz, r1.w, r1
mul_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c3.x
add_pp r1, -r0, c0
mul_pp r1, r1, c0.w
add_pp r0, r1, r0
cmp_pp r2.x, r2, c3.y, c3.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 80
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedenndjfafokfdmpfafcfllplekflmfckkabaaaaaaeaadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcemacaaaaeaaaaaaajdaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajpcaabaaa
aaaaaaaaegaobaiaebaaaaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaapgipcaaaaaaaaaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaa
abaaaaaaddaaaaahbcaabaaaacaaaaaabkbabaaaadaaaaaaakbabaaaadaaaaaa
ddaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaackbabaaaadaaaaaabnaaaaai
bcaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaabaaaaaaabaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaajpccabaaa
aaaaaaaaagaabaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadoaaaaab
"
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
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord3 v2.x
dcl_color0 v3.xyz
texld r1, v1, s1
texld r0, v0, s0
min_pp r2.y, v3.x, v3
mul_pp r0, r0, c2
mul_pp r1.xyz, r1.w, r1
mul_pp r0.xyz, r1, r0
mul_pp r2.x, v2, c0.w
mul_pp r0.xyz, r0, c3.x
mov_pp r1.w, r2.x
mov_pp r1.xyz, c0
add_pp r1, r1, -r0
mul_pp r1, r2.x, r1
min_pp r2.y, r2, v3.z
add_pp r2.x, r2.y, -c1
add_pp r0, r1, r0
cmp_pp r2.x, r2, c3.y, c3.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 80
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedldokfbfegcjfifclbehmpieahkainmahabaaaaaammadaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaaeaeaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaknaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
kiacaaaaeaaaaaaakkaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadecbabaaaacaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaaibcaabaaa
aaaaaaaackbabaaaacaaaaaadkiacaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaah
ccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaa
aaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaalhcaabaaa
acaaaaaaegacbaiaebaaaaaaabaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalicaabaaaacaaaaaadkiacaaaaaaaaaaaaaaaaaaackbabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaia
ebaaaaaaaaaaaaaaegaobaaaabaaaaaaddaaaaahbcaabaaaacaaaaaabkbabaaa
aeaaaaaaakbabaaaaeaaaaaaddaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
ckbabaaaaeaaaaaabnaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaa
aaaaaaaaabaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaiadpdcaaaaajpccabaaaaaaaaaaaagaabaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaaaaaaaaadoaaaaab"
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
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 20.00000000, 2.00000000, 3.00000000
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_color0 v2.xyz
dsy_pp r0.xyz, v2
dsx_pp r1.xyz, v2
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
texld r1, v1, s1
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.y
mul_pp r1.xyz, r1.w, r1
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r0.xyz, v2, r0
mul_pp r2.xyz, r0, r0
mad_pp r3.xyz, -r0, c3.z, c3.w
mul_pp r2.xyz, r2, r3
texld r0, v0, s0
mul_pp r0, r0, c2
mul_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c3.x
add_pp r1, -r0, c0
mul_pp r1, r1, c0.w
min_pp r2.x, r2, r2.y
add_pp r0, r1, r0
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 80
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjafbemgeebokbakaigechjhjofpabanhabaaaaaafaaeaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcfmadaaaaeaaaaaaanhaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaalaaaaaf
hcaabaaaaaaaaaaaegbcbaaaadaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaa
adaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaia
ibaaaaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaabaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaakaebaaaakaebaaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaaphcaabaaaabaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaeb
diaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaa
diaaaaahhcaabaaaabaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaa
dcaaaaakpcaabaaaacaaaaaapgipcaaaaaaaaaaaaaaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaia
ebaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadoaaaaab"
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
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 20.00000000, 2.00000000, 3.00000000
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord3 v2.x
dcl_color0 v3.xyz
dsy_pp r0.xyz, v3
dsx_pp r1.xyz, v3
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r2.xyz, r0, c3.y
texld r1, v1, s1
texld r0, v0, s0
mul_pp r1.xyz, r1.w, r1
mul_pp r0, r0, c2
mul_pp r0.xyz, r1, r0
mul_pp r2.w, v2.x, c0
rcp_pp r1.x, r2.x
rcp_pp r1.z, r2.z
rcp_pp r1.y, r2.y
mul_pp_sat r2.xyz, v3, r1
mad_pp r3.xyz, -r2, c3.z, c3.w
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
mul_pp r0.xyz, r0, c3.x
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
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 80
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkamhpegpgknacgfkckifpkhhbfneoeamabaaaaaanmaeaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaaeaeaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaknaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
liadaaaaeaaaaaaaooaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadecbabaaaacaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaalaaaaafhcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaaaeaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaiaibaaaaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaakaeb
aaaakaebaaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaadcaaaaaphcaabaaaabaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaackbabaaaacaaaaaadkiacaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaahecaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaal
hcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadcaaaaalicaabaaaadaaaaaadkiacaaaaaaaaaaaaaaaaaaackbabaaa
acaaaaaadkaabaiaebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgafbaaa
aaaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpccabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadoaaaaab"
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
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_color0 v2.xyz
texld r1, v1, s1
mul_pp r1.xyz, r1.w, r1
texld r0, v0, s0
min_pp r2.x, v2, v2.y
min_pp r2.x, r2, v2.z
add_pp r2.x, r2, -c1
mul_pp r0, r0, c2
mul_pp r1.xyz, r1, c3.x
mul_pp r0.xyz, r1, r0
mul_pp r1.xyz, r1, c0
mov_pp r1.w, c0
add_pp r1, r1, -r0
mul_pp r1, r1, c0.w
add_pp r0, r1, r0
cmp_pp r2.x, r2, c3.y, c3.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 80
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedidcaebiibhjdpnfaejaboffpbobahccbabaaaaaaheadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefciaacaaaaeaaaaaaakaaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaadgaaaaagicaabaaa
abaaaaaadkiacaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaacaaaaaa
egaobaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaapgipcaaa
aaaaaaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaacaaaaaaddaaaaahbcaabaaa
acaaaaaabkbabaaaadaaaaaaakbabaaaadaaaaaaddaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaackbabaaaadaaaaaabnaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaaakiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaiadpdcaaaaajpccabaaaaaaaaaaaagaabaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord3 v2.x
dcl_color0 v3.xyz
texld r1, v1, s1
mul_pp r1.xyz, r1.w, r1
mul_pp r2.x, v2, c0.w
texld r0, v0, s0
min_pp r2.y, v3.x, v3
mul_pp r0, r0, c2
mul_pp r1.xyz, r1, c3.x
mul_pp r0.xyz, r1, r0
mov_pp r1.w, r2.x
mul_pp r1.xyz, r1, c0
add_pp r1, r1, -r0
mul_pp r1, r2.x, r1
min_pp r2.y, r2, v3.z
add_pp r2.x, r2.y, -c1
add_pp r0, r1, r0
cmp_pp r2.x, r2, c3.y, c3.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 80
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecediemmkheaffpbdjndkfmilkikcjloallmabaaaaaaleadaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaaeaeaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaknaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
jaacaaaaeaaaaaaakeaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadecbabaaaacaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaa
acaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaiicaabaaaabaaaaaa
ckbabaaaacaaaaaadkiacaaaaaaaaaaaaaaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaaaaaaaaaa
pgapbaaaabaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaacaaaaaaddaaaaahbcaabaaa
acaaaaaabkbabaaaaeaaaaaaakbabaaaaeaaaaaaddaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaackbabaaaaeaaaaaabnaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaaakiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaiadpdcaaaaajpccabaaaaaaaaaaaagaabaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 20.00000000, 2.00000000, 3.00000000
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_color0 v2.xyz
dsy_pp r0.xyz, v2
dsx_pp r1.xyz, v2
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
texld r1, v1, s1
mul_pp r1.xyz, r1.w, r1
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.y
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r2.xyz, v2, r0
mad_pp r3.xyz, -r2, c3.z, c3.w
texld r0, v0, s0
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
mul_pp r0, r0, c2
mul_pp r1.xyz, r1, c3.x
mul_pp r0.xyz, r1, r0
mul_pp r1.xyz, r1, c0
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
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 80
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkijhdpknlpjggdkgfndjbnadnnhaobbeabaaaaaaieaeaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcjaadaaaaeaaaaaaaoeaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaalaaaaaf
hcaabaaaaaaaaaaaegbcbaaaadaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaa
adaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaia
ibaaaaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaabaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaakaebaaaakaebaaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaaphcaabaaaabaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaeb
diaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaadgaaaaag
icaabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaa
acaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaajgahbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
pgipcaaaaaaaaaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaai
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaaj
pccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaa
doaaaaab"
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
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 20.00000000, 2.00000000, 3.00000000
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord3 v2.x
dcl_color0 v3.xyz
dsy_pp r0.xyz, v3
dsx_pp r1.xyz, v3
abs_pp r1.xyz, r1
abs_pp r0.xyz, r0
add_pp r0.xyz, r1, r0
texld r1, v1, s1
mul_pp r1.xyz, r1.w, r1
mul_pp r2.w, v2.x, c0
mul_pp r0.xyz, r0, c1.x
mul_pp r0.xyz, r0, c3.y
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp_sat r2.xyz, v3, r0
mad_pp r3.xyz, -r2, c3.z, c3.w
texld r0, v0, s0
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
mul_pp r0, r0, c2
mul_pp r1.xyz, r1, c3.x
mul_pp r0.xyz, r1, r0
mul_pp r1.xyz, r1, c0
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
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 80
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedknaagfjbaiganaikfbgphkjfhcoaggecabaaaaaameaeaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaaeaeaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaknaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
kaadaaaaeaaaaaaaoiaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadecbabaaaacaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaalaaaaafhcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaamaaaaafhcaabaaaabaaaaaaegbcbaaaaeaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegacbaiaibaaaaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaakaeb
aaaakaebaaaakaebaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadicaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaadcaaaaaphcaabaaaabaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaamaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaddaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
ocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaajgahbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaiicaabaaa
abaaaaaackbabaaaacaaaaaadkiacaaaaaaaaaaaaaaaaaaaaaaaaaaipcaabaaa
adaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaapgapbaaaabaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaaaaaaaaai
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaaj
pccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaa
doaaaaab"
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
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_color0 v1.xyz
min_pp r2.x, v1, v1.y
min_pp r2.x, r2, v1.z
add_pp r2.x, r2, -c1
texld r0, v0, s0
mov_pp r1, c0
mad_pp r1, -r0, c2, r1
mul_pp r1, r1, c0.w
mad_pp r0, r0, c2, r1
cmp_pp r2.x, r2, c3, c3.y
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbddlcfbohnfabdjpbpjjbcgdkhmfjkajabaaaaaakaacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmeabaaaaeaaaaaaa
hbaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaddaaaaah
bcaabaaaaaaaaaaabkbabaaaacaaaaaaakbabaaaacaaaaaaddaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackbabaaaacaaaaaabnaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaacaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaampcaabaaaadaaaaaa
egiocaiaebaaaaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaa
aaaaaaaadcaaaaakpcaabaaaacaaaaaapgipcaaaaaaaaaaaaaaaaaaaegaobaaa
adaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaabaaaaaaegiocaaaaaaaaaaa
acaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpccabaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadoaaaaab
"
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
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1.x
dcl_color0 v2.xyz
mul_pp r2.x, v1, c0.w
min_pp r2.y, v2.x, v2
texld r0, v0, s0
mov_pp r1.w, r2.x
mov_pp r1.xyz, c0
mad_pp r1, -r0, c2, r1
mul_pp r1, r2.x, r1
min_pp r2.y, r2, v2.z
add_pp r2.x, r2.y, -c1
mad_pp r0, r0, c2, r1
cmp_pp r2.x, r2, c3, c3.y
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedemmhjhigkbdkajkihmgifiemfpajmcdoabaaaaaaceadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcbiacaaaaeaaaaaaaigaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaddaaaaahbcaabaaa
aaaaaaaabkbabaaaadaaaaaaakbabaaaadaaaaaaddaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackbabaaaadaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaaaaaaaaadkbabaaaabaaaaaa
dkiacaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaacaaaaaaegiccaia
ebaaaaaaaaaaaaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaaaaaaaa
diaaaaaipcaabaaaadaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaa
dcaaaaalicaabaaaacaaaaaadkiacaaaaaaaaaaaaaaaaaaadkbabaaaabaaaaaa
dkaabaiaebaaaaaaadaaaaaadcaaaaajpcaabaaaacaaaaaafgafbaaaaaaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaalpcaabaaaabaaaaaaegiocaaa
aaaaaaaaacaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaaj
pccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
doaaaaab"
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
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 20.00000000, 2.00000000, 3.00000000, 0
dcl_texcoord0 v0.xy
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
mul_pp_sat r2.xyz, v1, r0
mad_pp r3.xyz, -r2, c3.y, c3.z
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
texld r0, v0, s0
mov_pp r1, c0
mad_pp r1, -r0, c2, r1
mul_pp r1, r1, c0.w
mad_pp r0, r0, c2, r1
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedembjogifofeddngbggjcfndfehmabpdiabaaaaaalaadaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcneacaaaaeaaaaaaa
lfaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaalaaaaaf
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
aaaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaa
acaaaaaadcaaaaampcaabaaaadaaaaaaegiocaiaebaaaaaaaaaaaaaaacaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaadcaaaaakpcaabaaaacaaaaaa
pgipcaaaaaaaaaaaaaaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaadcaaaaal
pcaabaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaaegaobaia
ebaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadoaaaaab"
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
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 20.00000000, 2.00000000, 3.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1.x
dcl_color0 v2.xyz
mul_pp r2.w, v1.x, c0
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
mul_pp_sat r2.xyz, v2, r0
mad_pp r3.xyz, -r2, c3.y, c3.z
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
texld r0, v0, s0
mov_pp r1.xyz, c0
mov_pp r1.w, r2
mad_pp r1, -r0, c2, r1
mul_pp r1, r2.w, r1
mad_pp r0, r0, c2, r1
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_LIGHT_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefieceddfihpphepdebbghpegipoakagdohjpfpabaaaaaadeaeaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcciadaaaaeaaaaaaamkaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaa
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
ddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaadkbabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaacaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaaaaaaaaadiaaaaaipcaabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaalicaabaaaacaaaaaadkiacaaa
aaaaaaaaaaaaaaaadkbabaaaabaaaaaadkaabaiaebaaaaaaadaaaaaadcaaaaaj
pcaabaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
dcaaaaalpcaabaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadoaaaaab"
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
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_color0 v1.xyz
min_pp r2.x, v1, v1.y
min_pp r2.x, r2, v1.z
add_pp r2.x, r2, -c1
texld r0, v0, s0
mov_pp r1, c0
mad_pp r1, -r0, c2, r1
mul_pp r1, r1, c0.w
mad_pp r0, r0, c2, r1
cmp_pp r2.x, r2, c3, c3.y
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_LIGHT_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbddlcfbohnfabdjpbpjjbcgdkhmfjkajabaaaaaakaacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmeabaaaaeaaaaaaa
hbaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaddaaaaah
bcaabaaaaaaaaaaabkbabaaaacaaaaaaakbabaaaacaaaaaaddaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackbabaaaacaaaaaabnaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaacaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaampcaabaaaadaaaaaa
egiocaiaebaaaaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaa
aaaaaaaadcaaaaakpcaabaaaacaaaaaapgipcaaaaaaaaaaaaaaaaaaaegaobaaa
adaaaaaaegaobaaaacaaaaaadcaaaaalpcaabaaaabaaaaaaegiocaaaaaaaaaaa
acaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpccabaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadoaaaaab
"
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
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1.x
dcl_color0 v2.xyz
mul_pp r2.x, v1, c0.w
min_pp r2.y, v2.x, v2
texld r0, v0, s0
mov_pp r1.w, r2.x
mov_pp r1.xyz, c0
mad_pp r1, -r0, c2, r1
mul_pp r1, r2.x, r1
min_pp r2.y, r2, v2.z
add_pp r2.x, r2.y, -c1
mad_pp r0, r0, c2, r1
cmp_pp r2.x, r2, c3, c3.y
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_ANTIALIASING_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_LIGHT_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedemmhjhigkbdkajkihmgifiemfpajmcdoabaaaaaaceadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcbiacaaaaeaaaaaaaigaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaddaaaaahbcaabaaa
aaaaaaaabkbabaaaadaaaaaaakbabaaaadaaaaaaddaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackbabaaaadaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaaaaaaaaadkbabaaaabaaaaaa
dkiacaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaacaaaaaaegiccaia
ebaaaaaaaaaaaaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaaaaaaaa
diaaaaaipcaabaaaadaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaa
dcaaaaalicaabaaaacaaaaaadkiacaaaaaaaaaaaaaaaaaaadkbabaaaabaaaaaa
dkaabaiaebaaaaaaadaaaaaadcaaaaajpcaabaaaacaaaaaafgafbaaaaaaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaalpcaabaaaabaaaaaaegiocaaa
aaaaaaaaacaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaaj
pccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
doaaaaab"
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
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 20.00000000, 2.00000000, 3.00000000, 0
dcl_texcoord0 v0.xy
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
mul_pp_sat r2.xyz, v1, r0
mad_pp r3.xyz, -r2, c3.y, c3.z
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
texld r0, v0, s0
mov_pp r1, c0
mad_pp r1, -r0, c2, r1
mul_pp r1, r1, c0.w
mad_pp r0, r0, c2, r1
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_OFF" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedembjogifofeddngbggjcfndfehmabpdiabaaaaaalaadaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcneacaaaaeaaaaaaa
lfaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaalaaaaaf
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
aaaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaa
acaaaaaadcaaaaampcaabaaaadaaaaaaegiocaiaebaaaaaaaaaaaaaaacaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaaaaaaaaaadcaaaaakpcaabaaaacaaaaaa
pgipcaaaaaaaaaaaaaaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaadcaaaaal
pcaabaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaaegaobaia
ebaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadoaaaaab"
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
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 20.00000000, 2.00000000, 3.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord3 v1.x
dcl_color0 v2.xyz
mul_pp r2.w, v1.x, c0
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
mul_pp_sat r2.xyz, v2, r0
mad_pp r3.xyz, -r2, c3.y, c3.z
mul_pp r2.xyz, r2, r2
mul_pp r2.xyz, r2, r3
min_pp r2.x, r2, r2.y
texld r0, v0, s0
mov_pp r1.xyz, c0
mov_pp r1.w, r2
mad_pp r1, -r0, c2, r1
mul_pp r1, r2.w, r1
mad_pp r0, r0, c2, r1
min_pp r2.x, r2, r2.z
mad_pp oC0, r2.x, -r1, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "V_WIRE_FRESNEL_ON" "V_WIRE_ANTIALIASING_ON" "V_WIRE_LIGHT_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 0 [V_WIRE_COLOR]
Float 16 [V_WIRE_SIZE]
Vector 32 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefieceddfihpphepdebbghpegipoakagdohjpfpabaaaaaadeaeaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcciadaaaaeaaaaaaamkaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaa
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
ddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaadkbabaaaabaaaaaadkiacaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaacaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaaaaaaaaadiaaaaaipcaabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaalicaabaaaacaaaaaadkiacaaa
aaaaaaaaaaaaaaaadkbabaaaabaaaaaadkaabaiaebaaaaaaadaaaaaadcaaaaaj
pcaabaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
dcaaaaalpcaabaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadoaaaaab"
}
}
 }
}
}