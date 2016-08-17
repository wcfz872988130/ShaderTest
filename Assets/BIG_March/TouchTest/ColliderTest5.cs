using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class ColliderTest5 : Image {
	PolygonCollider2D collider;
	public GameObject mymodel;
	void Awake()
	{
		collider=GetComponent<PolygonCollider2D>();
	}

	public void showArea5()
	{
		mymodel = GameObject.Find ("Sphere");
		//Debug.Log ("Area5Success!");
		mymodel.GetComponent<vertcolortrans> ().index = 4;
		mymodel.GetComponent<vertcolortrans> ()._deliver = true;
	}

	override public bool IsRaycastLocationValid(Vector2 sp,Camera eventCamera)
	{
		return ContainsPoint(collider.points,sp);
	}

	bool ContainsPoint(Vector2[] polyPoints,Vector2 p)
	{
		int j = polyPoints.Length - 1;
		bool inside = false;
		for(int i=0;i<polyPoints.Length;j=i++)
		{
			polyPoints [i].x += transform.position.x;
			polyPoints [i].y += transform.position.y;
			if(((polyPoints[i].y<=p.y&&p.y<polyPoints[j].y)||(polyPoints[j].y<=p.y&&p.y<polyPoints[i].y))&&(p.x<(polyPoints[j].x-polyPoints[i].x)*(p.y-polyPoints[i].y)/(polyPoints[j].y-polyPoints[i].y)+polyPoints[i].x))
			{
				inside = !inside;
			}
		}
		return inside;
	}
}
