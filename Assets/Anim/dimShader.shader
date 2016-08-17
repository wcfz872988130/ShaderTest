Shader "Custom/dimShader" {
	Properties
	{
		_MainTex("主纹理",2D)="white"{}
		_IterationNumber("迭代次数", Int)=16  
	}

	SubShader
	{
		Pass
		{
			ZTest Always//深度测试模式：渲染所有元素，等同于关闭透明度测试（AlphaTest Off）
			CGPROGRAM
			#pragma target 3.0

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			uniform float _Value;
			uniform float _Value2;
			uniform float _Value3;
			uniform int _IterationNumber;

			struct vertexInput
			{
				float4 vertex: POSITION;
				float4 color: COLOR;
				float2 texcoord:TEXCOORD0;
			};

			struct vertexOutput
			{
				half2 texcoord:TEXCOORD0;
				float4 vertex:SV_POSITION;
				fixed4 color:COLOR;
			};

			vertexOutput vert(vertexInput Input)
			{
				vertexOutput Output;
				Output.vertex=mul(UNITY_MATRIX_MVP,Input.vertex);
				//Output.texcoord=Input.texcoord;
				Output.texcoord=TRANSFORM_TEX(Input.texcoord,_MainTex);
				Output.color=Input.color;
				return Output;  
			}

			//--------------------------------【片段着色函数】-----------------------------  
            // 输入：顶点输出结构体  
            // 输出：float4型的颜色值  
            //---------------------------------------------------------------------------------  
            float4 frag(vertexOutput i) : COLOR  
            {  
                //【1】设置中心坐标  
                float2 center = float2(_Value2, _Value3);  
                //【2】获取纹理坐标的x，y坐标值  
                float2 uv = i.texcoord.xy;  
                //【3】纹理坐标按照中心位置进行一个偏移  
                uv -= center;  
                //【4】初始化一个颜色值  
                float4 color = float4(0.0, 0.0, 0.0, 0.0);  
                //【5】将Value乘以一个系数  
                _Value *= 0.085;  
                //【6】设置坐标缩放比例的值  
                float scale = 1;  
  
                //【7】进行纹理颜色的迭代  
                for (int j = 1; j < _IterationNumber; ++j)  
                {  
                    //将主纹理在不同坐标采样下的颜色值进行迭代累加  
                    color += tex2D(_MainTex, uv * scale + center);  
                    //坐标缩放比例依据循环参数的改变而变化  
                    scale = 1 + (float(j * _Value));  
                }  
  
                //【8】将最终的颜色值除以迭代次数，取平均值  
                color /= (float)_IterationNumber;  
  
                //【9】返回最终的颜色值  
                return  color;  
            }  
  
            //===========结束CG着色器语言编写模块===========  
            ENDCG  
        }  
    }  
}  

