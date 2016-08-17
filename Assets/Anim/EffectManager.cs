using UnityEngine;
using System.Collections;

public class EffectManager : MonoBehaviour {
	public Camera myCamera;
	public static int U1 = 1;
	public static int U2 = 1;
	public static int U3 = 1;
	public static int U4 = 1;
	public static int U5 = 1;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	void OnGUI()
	{
		if(GUI.Button(new Rect(20,20,150,60),"特效一"))
		{
			U1++;
			if(U1%2==0)
			{
				myCamera.GetComponent<OnMotionRenderImage> ().enabled = true;
				Debug.Log (U1);
			}
			else
			{
				myCamera.GetComponent<OnMotionRenderImage> ().enabled = false;
				Debug.Log (U1);
			}
		}
			
		if(GUI.Button(new Rect(20,100,150,60),"特效二"))
		{
			U2++;
			if (U2%2==0) {
				myCamera.GetComponent<ScreenWaterDropEffect> ().enabled = true;
			} else {
				myCamera.GetComponent<ScreenWaterDropEffect> ().enabled = false;
			}
		}
			
//		if(GUI.Button(new Rect(20,180,150,60),"特效三"))
//		{
//			U3++;
//			if(U3%2==0)
//			{
//				myCamera.GetComponent<BlendRender> ().enabled = true;
//			}
//			else
//			{
//				myCamera.GetComponent<BlendRender> ().enabled = false;
//			}
//		}
//			
//		if(GUI.Button(new Rect(20,260,150,60),"特效四"))
//		{
//			U4++;
//			if(U4%2==0)
//			{
//				myCamera.GetComponent<OldFilm> ().enabled = true;
//			}
//			else
//			{
//				myCamera.GetComponent<OldFilm> ().enabled = false;
//			}
//		}
//			
//		if(GUI.Button(new Rect(20,340,150,60),"特效五"))
//		{
//			U5++;
//			if(U5%2==0)
//			{
//				myCamera.GetComponent<NightVisionEffect> ().enabled = true;
//			}
//			else
//			{
//				myCamera.GetComponent<NightVisionEffect> ().enabled = false;
//			}
//		}
	}
}
