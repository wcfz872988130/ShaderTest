using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class UIManager : MonoBehaviour {
	public RectTransform _image;
	public GameObject myImage;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetMouseButton(0))
		{
			Debug.Log ("点击鼠标");
			float mouseX = Input.mousePosition.x;
			float mouseY = Input.mousePosition.y;
			Debug.Log (mouseX);Debug.Log (mouseY);
			_image.localPosition = new Vector3 (mouseX-Screen.width/2,mouseY-Screen.height/2,0);
			myImage.SetActive (true);
		}
	}
}
