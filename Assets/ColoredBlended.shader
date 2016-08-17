Shader "Custom/Colored Blended" {
	SubShader 
	{
		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Front
			Fog
			{
				Mode Off
			}
		}
	}
}
