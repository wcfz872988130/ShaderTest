Shader "Custom/BlendRender"  
{  
    //------------------------------------【属性值】------------------------------------  
    Properties  
    {  
        //主纹理  
        _MainTex ("Base (RGB)", 2D) = "white" {}  
        //屏幕水滴的素材图  
        _ScreenWaterDropTex ("Base (RGB)", 2D) = "white" {}  
        //溶解度  
        _Distortion ("_Distortion", Range(0.0, 1.0)) = 0.87  
        //不透明度
        _Opacity("_Opacity",Range(0.0,1.0))=1.0
    }  
  
    //------------------------------------【唯一的子着色器】------------------------------------  
    SubShader  
    {  
        Pass  
        {  
            //设置深度测试模式:渲染所有像素.等同于关闭透明度测试（AlphaTest Off）  
            ZTest Always  
              
            //===========开启CG着色器语言编写模块===========  
            CGPROGRAM  
  
            //编译指令:告知编译器顶点和片段着色函数的名称  
            #pragma vertex vert  
            #pragma fragment frag  
            #pragma fragmentoption ARB_precision_hint_fastest //? 
            //编译指令: 指定着色器编译目标为Shader Model 3.0  
            #pragma target 3.0  
  
            //包含辅助CG头文件  
            #include "UnityCG.cginc"  
  
            //外部变量的声明  
            uniform sampler2D _MainTex;  
            uniform sampler2D _ScreenWaterDropTex;  //纹理
            uniform float _Opacity;
            uniform float _Distortion;  
              
            //顶点输入结构  
            struct vertexInput  
            {  
                float4 vertex : POSITION;//顶点位置  
                float4 color : COLOR;//颜色值  
                float2 texcoord : TEXCOORD0;//一级纹理坐标  
            };  
  
            //顶点输出结构  
            struct vertexOutput  
            {  
                half2 texcoord : TEXCOORD0;//一级纹理坐标  
                float4 vertex : SV_POSITION;//像素位置  
                fixed4 color : COLOR;//颜色值  
            };  
  
            //--------------------------------【顶点着色函数】-----------------------------  
            // 输入：顶点输入结构体  
            // 输出：顶点输出结构体  
            //---------------------------------------------------------------------------------  
            vertexOutput vert(vertexInput Input)  
            {  
                //【1】声明一个输出结构对象  
                vertexOutput Output;  
  
                //【2】填充此输出结构  
                //输出的顶点位置为模型视图投影矩阵乘以顶点位置，也就是将三维空间中的坐标投影到了二维窗口  
                Output.vertex = mul(UNITY_MATRIX_MVP, Input.vertex);  
                //输出的纹理坐标也就是输入的纹理坐标  
                Output.texcoord = Input.texcoord;  
                //输出的颜色值也就是输入的颜色值  
                Output.color = Input.color;  
  
                //【3】返回此输出结构对象  
                return Output;  
            }  
  
            //--------------------------------【片段着色函数】-----------------------------  
            // 输入：顶点输出结构体  
            // 输出：float4型的颜色值  
            //---------------------------------------------------------------------------------  
            fixed4 frag(vertexOutput Input) : COLOR  
            {  
                //【1】获取顶点的坐标值  
                float2 uv = Input.texcoord.xy;  
  
                //【5】按照finalRainTex的坐标信息，在主纹理上进行采样  
                float3 priColor=tex2D(_MainTex,uv.xy).rgb;

                float3 midColor = tex2D(_MainTex, uv.xy).rgb * tex2D(_ScreenWaterDropTex,uv.xy).rgb;  

                float3 finalColor=lerp(priColor,midColor,_Opacity);
  
                //【6】返回加上alpha分量的最终颜色值  
                return fixed4(finalColor, 1.0);  
            }  
  
            //===========结束CG着色器语言编写模块===========  
            ENDCG  
        }  
    }  
} 
