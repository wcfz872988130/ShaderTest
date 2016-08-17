Shader "Unlit/ConcentricCircles"
{
	Properties
	{
		//_MainTex ("Texture", 2D) = "white" {}
		_MainColor("MainColor",Color)=(0,0,1,1)
	}
	SubShader
	{
		Tags { 
				"IgnoreProjector"="True"  
            	"Queue"="Transparent"  
            	"RenderType"="Transparent" 
             }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				fixed4 color:COLOR;
				float3 normal:NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				fixed4 color:Color;
				float3 normalDir:TEXCOORD1;
				float3 posWorld:TEXCOORD2;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			//float4 _MainColor;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.posWorld=mul(_Object2World,v.vertex);
				o.normalDir=mul(float4(v.normal,0),_World2Object).xyz;
				o.color=v.color;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float3 viewDirection=normalize(_WorldSpaceCameraPos.xyz-i.posWorld.xyz);
				float3 normalDirection=i.normalDir;
				// sample the texture
//				fixed3 col = (tex2D(_MainTex, i.uv)*i.color).rgb;
//				return fixed4(col,0);
				return fixed4((i.color).rgb,(1.0-max(0,dot(normalDirection, viewDirection))));
			}
			ENDCG
		}
	}
}
