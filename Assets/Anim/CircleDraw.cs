using UnityEngine;
using DG.Tweening;
using System.Collections;

public class CircleDraw : PrimitiveBase {
	[SerializeField]
	private float m_Radius;
	/// <summary>
	/// 宽度
	/// </summary>
	public float radius
	{
		get { return m_Radius; }
		set { m_Radius = value; UpdateShape(); }
	}

	/// <summary>
	/// x方向的偏移
	/// </summary>
	public float offsetX
	{
		get { return offset.x; }
		set { offset.x = value; UpdateShape(); }
	}
		

	protected override void UpdateShape()
	{
		if (cacheTransform == null || meshFilter == null)
		{
			Init();
		}

		Vector3 localPos = offset;

		vertices = new Vector3[361];
		colors=new Color[361];
		colors[360]=Color.white;
		for(int i=0;i<360;i++)
		{
			colors [i] = Color.gray;
		}

		float[] Point=new float[722];
		for(int i=0;i<722;i++)
		{
			Point[i]=0;
		}

		Point [360] = 0;
		Point [721] = 0;
		for(int i=0;i<360;i++)
		{
			Point [i] = -radius * Mathf.Cos (i*Mathf.Deg2Rad);
		}

		for(int i=361;i<721;i++)
		{
			Point [i] = radius * Mathf.Sin ((i-361)*Mathf.Deg2Rad);
		}
			
		for(int i=0;i<361;i++)
		{
			vertices[i].x=localPos.x+Point[i];
			vertices[i].y = localPos.y;
			vertices[i].z=localPos.z+Point[361+i];
		}
		UpdateMesh();
	}
	protected override void InitMesh()
	{
		if (cacheTransform == null || meshFilter == null)
		{
			Init();
		}

		//triangles = new int[] { 0,12,1, 1,12,2, 2,12,3, 3,12,4, 4,12,5, 5,12,6, 6,12,7, 7,12,8, 8,12,9, 9,12,10, 10,12,11, 11,12,0};
		triangles[1079]=0;
		for(int i=0;i<1079;i++)
		{
			if(i%3==0)
			{
				triangles[i]=i/3;
			}
			else if(i%3==2)
			{
				triangles[i]=(i+1)/3;
			}
			else
				triangles[i]=360;
		}

		uvs = new Vector2[361];
		for(int i=0;i<360;i++)
		{
			uvs [i].x=1-Mathf.Cos(i*Mathf.Deg2Rad);
			uvs [i].y = 0.5f + Mathf.Sin (i*Mathf.Deg2Rad);
		}
		uvs [360].x = 0.5f;
		uvs [360].y = 0.5f;

		normals = new Vector3[361];
		for(int i=0;i<361;i++)
		{
			normals [i].y = 1;
		}

		UpdateShape();
	}
	public Tweener DoLength(float endValue, float duration, float delay)
	{
		return DOTween.To(() => radius, x => radius = x, endValue, duration).SetDelay(delay);
	}
}
