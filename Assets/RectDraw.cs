using UnityEngine;
using DG.Tweening;

public class RectDraw : PrimitiveBase 
{
	[SerializeField]
	private int widthsegment=1;//宽度边段数；
	[SerializeField]
	private int heightsegment=1;//长度边段数；
	[SerializeField]
	private float unitlength = 1;//单位长度;
	/// <summary>
	/// 宽度段数
	/// </summary>
	public int widthSeg
	{
		get { return widthsegment; }
		set { widthsegment = value; UpdateShape(); }
	}
	/// <summary>
	/// 长度段数
	/// </summary>
	public int heightSeg
	{
		get { return heightsegment; }
		set { heightsegment = value; UpdateShape(); }
	}
	/// <summary>
	/// x方向的偏移
	/// </summary>
	public float offsetX
	{
		get { return offset.x; }
		set { offset.x = value; UpdateShape(); }
	}
	/// <summary>
	/// 单位长度
	/// </summary>
	public float Unit
	{
		get{ return unitlength;}
		set{ unitlength = value;UpdateShape ();}
	}

	protected override void UpdateShape()
	{
		if (cacheTransform == null || meshFilter == null)
		{
			Init();
		}

		Vector3 localPos = offset;
		//float w2 = m_Width * 0.5f;
		//float l2 = m_Length * 0.5f;

		vertices = new Vector3[(widthSeg+1)*(heightSeg+1)];

		float[] points=new float[(widthSeg+1)*(heightSeg+1)*2];
		for(int i=0;i<points.Length;i++)
		{
			points[i]=0;
		}


		for(int j=0;j<widthSeg+1;j++)
		{
			for (int i = 0; i < points.Length / 2; i++) 
			{
				if(i%(widthSeg+1)==j)
				{
					points [i] = Unit * j;
				}
			}
		}

		for(int j=0;j<heightSeg+1;j++)
		{
			for (int i = points.Length/2+1; i < points.Length; i++) 
			{
				if((i-points.Length/2)/(widthSeg+1)==j)
				{
					points [i] = Unit * j;
				}
			}
		}

		for(int i=0;i<vertices.Length;i++)
		{
			vertices[i].x=localPos.x+points[i];
			vertices[i].y=localPos.y;
			vertices[i].z=localPos.z+points[i+(widthSeg+1)*(heightSeg+1)];
		}

		UpdateMesh();
	}
	protected override void InitMesh()
	{
		if (cacheTransform == null || meshFilter == null)
		{
			Init();
		}


		triangles = new int[widthSeg*heightSeg*6];
		for(int i=0;i<triangles.Length;i++)
		{
			int triloc = i / 3;
			int pai = triloc / (widthSeg * 2);
			int lie = (triloc - pai * widthSeg * 2) / 2;
			if (triloc % 2 == 0) {
				if (i % 3 == 0) {
					triangles [i] = (widthSeg + 1) * pai + lie;
				}
				if (i % 3 == 1) {
					triangles [i] = (widthSeg + 1) * pai + lie + 1;
				}
				if (i % 3 == 2) {
					triangles [i] = (widthSeg + 1) * (pai + 1) + lie;
				}
			} else {
				if(i%3==0)
				{
					triangles [i] = (widthSeg + 1) * pai + lie+1;
				}
				if(i%3==1)
				{
					triangles[i]=(widthSeg + 1) * (pai + 1) + lie;
				}
				if(i%3==2)
				{
					triangles[i]=(widthSeg + 1) * (pai + 1) + lie+1;
				}
			}
		}

		uvs = new Vector2[(widthSeg+1)*(heightSeg+1)];
		for(int i=0;i<uvs.Length;i++)
		{
			int hang=i/(widthSeg+1);
			int pai=i-hang*(widthSeg+1);
			if(widthSeg!=0&&heightSeg!=0)
			{
				uvs[i].x=pai*(float)(100/(widthSeg)*0.01);
				uvs[i].y=hang*(float)(100/(heightSeg)*0.01);
			}
		}

		normals = new Vector3[(widthSeg+1)*(heightSeg+1)];
		for(int i=0;i<normals.Length;i++)
		{
			normals[i].y=0;
		}

		UpdateShape();
	}
	/*public Tweener DoLength(float endValue, float duration, float delay)
	{
		//return DOTween.To(() => length, x => length = x, endValue, duration).SetDelay(delay);
	}*/
	/*public Tween DoWidth(float endValue, float duration, float delay)
	{
		//return DOTween.To(() => width, x => width = x, endValue, duration).SetDelay(delay);
	}*/
}
