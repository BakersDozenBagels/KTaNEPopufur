Shader "Custom/FurShader"
{
	Properties
	{
	    _Offset ("Offset", Range (0, 1)) = 0.7
        _ColorL ("Color", Color) = (0,0,0,0)
        _ColorR ("Color2", Color) = (0,0,0,0)
        
	    _MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		LOD 100

		Pass
		{		    
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
                        //CG keywords
                        //http://developer.download.nvidia.com/CgTutorial/cg_tutorial_appendix_d.html
                        //CG library functions:
                        //http://developer.download.nvidia.com/CgTutorial/cg_tutorial_appendix_e.html

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			uniform fixed4 _ColorL, _ColorR;
			uniform float _Offset;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				float lerpVal = 1.0 / (1.0 + exp(-50.0 * (i.uv.x - _Offset)));

				return col * lerp(_ColorL, _ColorR, lerpVal);
			}
			ENDCG
		}
	}
}