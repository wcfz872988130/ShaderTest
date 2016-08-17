Shader "Custom/GeometryPyramidDiffuse"
{
   Properties
   {
     _Color ("Main Color", Color) = (1,1,1,1)
     _MainTex ("Particle Texture", 2D) = "white" {}
     _Explode ("Explode factor", Range(0.0, 4.0)) = 1.0
   }
 
   SubShader
   {
     Tags { "RenderType"="Opaque" }
     LOD 200
   
     Pass
     {
       Name "FORWARD"
       Tags { "LightMode" = "ForwardBase" }
     
       CGPROGRAM
       #pragma target  5.0
     
       #pragma vertex  vert
       #pragma geometry  geom
       #pragma fragment  frag
     
       #pragma fragmentoption ARB_precision_hint_fastest
       #pragma multi_compile_fwdbase
     
       #include "HLSLSupport.cginc"
       #include "UnityShaderVariables.cginc"
     
       #define UNITY_PASS_FORWARDBASE
     
       #include "UnityCG.cginc"
       #include "Lighting.cginc"
       #include "AutoLight.cginc"
     
       #define INTERNAL_DATA
       #define WorldReflectionVector(data,normal) data.worldRefl
       #define WorldNormalVector(data,normal) normal
     
       #pragma only_renderers d3d11
       // #pragma surface surf Lambert
       // #pragma debug
     
       sampler2D  _MainTex;
       fixed4  _Color;
       float  _Explode;
     
       struct Input
       {
         float2 uv_MainTex;
       };
     
       void surf (Input IN, inout SurfaceOutput o)
       {
         fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
         o.Albedo = c.rgb;
         o.Alpha  = c.a;
       }
     
       struct v2f_surf
       {
         float4 pos : SV_POSITION;
         float2 pack0 : TEXCOORD0;
         fixed3 normal : TEXCOORD1;
         fixed3 vlight : TEXCOORD2;
         LIGHTING_COORDS(3,4)
       };
     
       float4 _MainTex_ST;
     
       v2f_surf vert (appdata_full v)
       {
         v2f_surf o;
         o.pos = v.vertex; // mul (UNITY_MATRIX_MVP, v.vertex);
         o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
       
         float3 worldN = mul((float3x3)_Object2World, SCALED_NORMAL);
         o.normal = worldN;
         float3 shlight = ShadeSH9 (float4(worldN,1.0));
         o.vlight = shlight;
       
         #ifdef VERTEXLIGHT_ON
           float3 worldPos = mul(_Object2World, v.vertex).xyz;
           o.vlight += Shade4PointLights (
           unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
           unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
           unity_4LightAtten0, worldPos, worldN );
         #endif // VERTEXLIGHT_ON
       
         // TRANSFER_VERTEX_TO_FRAGMENT(o);
         return o;
       }
     
       // Geometry Shader
       [maxvertexcount(12)]
       void geom( triangle v2f_surf input[3], inout TriangleStream<v2f_surf> outStream )
       {
         v2f_surf output;
       
         // Calculate the face normal
         float3 faceEdgeA = input[1].pos - input[0].pos;
         float3 faceEdgeB = input[2].pos - input[0].pos;
         float3 faceNormal = normalize( cross(faceEdgeA, faceEdgeB) );
         float3 ExplodeAmt = faceNormal*_Explode;
       
         // Calculate the face center
         float3 centerPos = (input[0].pos.xyz + input[1].pos.xyz + input[2].pos.xyz)/3.0;
         float2 centerTex = (input[0].pack0 + input[1].pack0 + input[2].pack0)/3.0;
         centerPos += faceNormal*_Explode;
       
         // Output the pyramid
         for( int looper=0; looper<3; looper++ )
         {
           output.pos = input[looper].pos + float4(ExplodeAmt,0);
           output.pos = mul(UNITY_MATRIX_MVP, output.pos);
           output.normal = input[looper].normal;
           output.pack0 = input[looper].pack0;
           output.vlight = input[looper].vlight;
           TRANSFER_GEOM_TO_FRAGMENT(output); // Probably need to do this by hand since it uses v.vertex!!    
           outStream.Append( output );
         
           // uint iNext = (looper+1)%3; // Note: this causes errors in compilation
           uint iNext = looper+1;
           if (iNext>2) iNext = 0;
         
           output.pos = input[iNext].pos + float4(ExplodeAmt,0);
           output.pos = mul(UNITY_MATRIX_MVP, output.pos);
           output.normal = input[iNext].normal;
           output.pack0 = input[iNext].pack0;
           output.vlight = input[iNext].vlight;
           TRANSFER_GEOM_TO_FRAGMENT(output);     // TRANSFER_VERTEX_TO_FRAGMENT
           outStream.Append( output );
         
           output.pos = float4(centerPos,1) + float4(ExplodeAmt,0);
           output.pos = mul(UNITY_MATRIX_MVP, output.pos);
           output.normal = faceNormal;
           output.pack0 = centerTex;
           output.vlight = input[looper].vlight;
           TRANSFER_GEOM_TO_FRAGMENT(output);
           outStream.Append( output );
         
           outStream.RestartStrip();
         }
       
         for(int cpt=2; cpt>=0; cpt-- )
         {
           output.pos = input[cpt].pos + float4(ExplodeAmt,0);
           output.pos = mul(UNITY_MATRIX_MVP, output.pos);
           output.normal = -input[cpt].normal;
           output.pack0 = input[cpt].pack0;
           output.vlight = input[cpt].vlight;
           TRANSFER_GEOM_TO_FRAGMENT(output);
           outStream.Append( output );
         }
       
         outStream.RestartStrip();
       }
     
     
       fixed4 frag (v2f_surf IN) : COLOR
       {
         Input surfIN;
         surfIN.uv_MainTex = IN.pack0.xy;
       
         #ifdef UNITY_COMPILER_HLSL
           SurfaceOutput o = (SurfaceOutput)0;
         #else
           SurfaceOutput o;
         #endif
       
         o.Albedo  = 0.0;
         o.Emission  = 0.0;
         o.Specular  = 0.0;
         o.Alpha  = 0.0;
         o.Gloss  = 0.0;
         o.Normal = IN.normal;
       
         surf (surfIN, o);
         fixed atten = LIGHT_ATTENUATION(IN);
         fixed4 c = 0;
       
         c = LightingLambert (o, _WorldSpaceLightPos0.xyz, atten);
         c.rgb += o.Albedo * IN.vlight;
         return c;
       }
     
       ENDCG    
     } // Pass ForwardBase
   
       
     // Pass to render object as a shadow caster
     Pass
     {
       Name "ShadowCaster"
       Tags { "LightMode" = "ShadowCaster" }
     
       Fog {Mode Off}
       ZWrite On ZTest LEqual Cull Off
       Offset 1, 1
       CGPROGRAM
       #pragma target  5.0
     
       #pragma vertex      vert
       #pragma geometry  geom
       #pragma fragment    frag
     
       #pragma multi_compile_shadowcaster
       #pragma only_renderers d3d11
     
       #include "UnityCG.cginc"
       #include "HLSLSupport.cginc"
     
       float  _Explode;
       struct v2f
       {
         V2F_SHADOW_CASTER;
       };
       v2f vert( appdata_base v )
       {
         v2f o;
         //o.pos = v.vertex;
         TRANSFER_SHADOW_CASTER(o)
         o.pos = v.vertex;
         return o;
       }
       // Geometry Shader
       [maxvertexcount(12)]
       void geom( triangle v2f input[3], inout TriangleStream<v2f> outStream )
       {
         v2f output;
       
         // Calculate the face normal
         float3 faceEdgeA = input[1].pos - input[0].pos;
         float3 faceEdgeB = input[2].pos - input[0].pos;
         float3 faceNormal = normalize( cross(faceEdgeA, faceEdgeB) );
         float3 ExplodeAmt = faceNormal*_Explode;
       
         // Calculate the face center
         float3 centerPos = (input[0].pos.xyz + input[1].pos.xyz + input[2].pos.xyz)/3.0;
         centerPos += faceNormal*_Explode;
       
         // Define for TRANSFER_GEOM_SHADOW_CASTER
         float clamped;
       
         // Output the pyramid
         for( int looper=0; looper<3; looper++ )
         {
           output.pos = input[looper].pos + float4(ExplodeAmt,0);
           TRANSFER_GEOM_SHADOW_CASTER(output)
         
           output.pos = input[looper].pos + float4(ExplodeAmt,0);    
           output.pos = mul(UNITY_MATRIX_MVP, output.pos);          
           outStream.Append( output );
         
           uint iNext = looper+1;
           if (iNext>2) iNext = 0;
         
           output.pos = input[iNext].pos + float4(ExplodeAmt,0);
           TRANSFER_GEOM_SHADOW_CASTER(output)
         
           output.pos = input[iNext].pos + float4(ExplodeAmt,0);
           output.pos = mul(UNITY_MATRIX_MVP, output.pos);
           outStream.Append( output );
         
           output.pos = float4(centerPos,1) + float4(ExplodeAmt,0);
           TRANSFER_GEOM_SHADOW_CASTER(output)
         
           output.pos = float4(centerPos,1) + float4(ExplodeAmt,0);
           output.pos = mul(UNITY_MATRIX_MVP, output.pos);        
           outStream.Append( output );
         
           outStream.RestartStrip();
         }
       
         for(int cpt=2; cpt>=0; cpt-- )
         {
           output.pos = input[cpt].pos + float4(ExplodeAmt,0);
           TRANSFER_GEOM_SHADOW_CASTER(output)
         
           output.pos = input[cpt].pos + float4(ExplodeAmt,0);
           output.pos = mul(UNITY_MATRIX_MVP, output.pos);        
           outStream.Append( output );
         }
       
         outStream.RestartStrip();
       }
     
     
       float4 frag( v2f i ) : COLOR
       {
         SHADOW_CASTER_FRAGMENT(i)
       }
       ENDCG
     }
 
     // Pass to render object as a shadow collector
     Pass
     {
       Name "ShadowCollector"
       Tags { "LightMode" = "ShadowCollector" }
     
       Fog {Mode Off}
       ZWrite On ZTest LEqual
       CGPROGRAM
       #pragma target  5.0
     
       #pragma vertex      vert
       #pragma geometry  geom
       #pragma fragment    frag
     
       #pragma multi_compile_shadowcollector
       #pragma only_renderers d3d11
     
       #define SHADOW_COLLECTOR_PASS
     
       #include "UnityCG.cginc"
       #include "HLSLSupport.cginc"
     
       float  _Explode;
     
       struct appdata
       {
         float4 vertex : POSITION;
       };
       struct v2f
       {
         V2F_SHADOW_COLLECTOR;
       };
   
       v2f vert (appdata v)
       {
         v2f o;
         TRANSFER_SHADOW_COLLECTOR(o)
         o.pos = v.vertex;
         return o;
       }
     
       // Geometry Shader
       [maxvertexcount(12)]
       void geom( triangle v2f input[3], inout TriangleStream<v2f> outStream )
       {
         v2f output;
       
         // Calculate the face normal
         float3 faceEdgeA = input[1].pos - input[0].pos;
         float3 faceEdgeB = input[2].pos - input[0].pos;
         float3 faceNormal = normalize( cross(faceEdgeA, faceEdgeB) );
         float3 ExplodeAmt = faceNormal*_Explode;
       
         // Calculate the face center
         float3 centerPos = (input[0].pos.xyz + input[1].pos.xyz + input[2].pos.xyz)/3.0;
         centerPos += faceNormal*_Explode;
       
         // Define for TRANSFER_GEOM_SHADOW_CASTER
         float    clamped;
         float4    vert;
         float4    wpos;
       
         // Output the pyramid
         for( int looper=0; looper<3; looper++ )
         {
           vert = input[looper].pos + float4(ExplodeAmt,0);
           TRANSFER_GEOM_SHADOW_COLLECTOR(output, vert)          
           outStream.Append( output );
         
           uint iNext = looper+1;
           if (iNext>2) iNext = 0;
         
           vert = input[iNext].pos + float4(ExplodeAmt,0);
           TRANSFER_GEOM_SHADOW_COLLECTOR(output, vert)
           outStream.Append( output );
         
           vert = float4(centerPos,1) + float4(ExplodeAmt,0);
           TRANSFER_GEOM_SHADOW_COLLECTOR(output, vert)      
           outStream.Append( output );
         
           outStream.RestartStrip();
         }
       
         for(int cpt=2; cpt>=0; cpt-- )
         {
           vert = input[cpt].pos + float4(ExplodeAmt,0);
           TRANSFER_GEOM_SHADOW_COLLECTOR(output, vert)        
           outStream.Append( output );
         }
       
         outStream.RestartStrip();
       }
     
       fixed4 frag (v2f i) : COLOR
       {
         SHADOW_COLLECTOR_FRAGMENT(i)
       }
       ENDCG
     }
   } // subshader
   // FallBack "Diffuse" // Use for testing shadows via Normal-VertexLit.shader fallback.
 
   FallBack Off
}