using UnityEngine;
using System;
using UnityEngine.EventSystems;
using System.Collections;
using UnityEngine.UI;
using DG.Tweening;

public class ButtonClick : MonoBehaviour,IPointerDownHandler,IPointerUpHandler {
	public bool _IsAlive=false;
	public int[] Status;
	public int _id;
	public ShowButton.ShowTime en;
	public Sprite _initSprite;
	private int index;
	public bool _IsFinish=false;
	private RectTransform commonRectTransform;
	//use delegate
	public delegate void DoOneButton(int id);
	public static event DoOneButton doOne; 
	private bool _IsKeepTouch=false;

	public enum stage//状态机;
	{
		init,
		enter,
		normal,
		press,
		release,
		exit
	};

	public stage sta = stage.enter;
	public float width, height;
	//<summary>
	//"enter"状态下的数据;
	//</summary>
	public Sprite[] enter_sp;
	public float enter_duringTime;
	public float enter_StartScale;
	public float enter_endScale;
	public Vector2 init_pos;
	public Vector3 enter_start_pos;
	public Vector3 enter_end_pos;

	//<summary>
	//"normal"状态下的数据;
	//</summary>
	public float normal_duringTime;
	public float normal_StartScale;
	public float normal_endScale;
	public Vector3 normal_start_pos;
	public Vector3 normal_end_pos;
	public Sprite[] normal_sp;

	//<summary>
	//"press"状态下的数据;
	//</summary>
	public float press_duringTime;
	public float press_StartScale;
	public float press_endScale;
	public Vector3 press_start_pos;
	public Vector3 press_end_pos;
	public Sprite[] press_sp;

	//<summary>
	//"release"状态下的数据;
	//</summary>
	public float release_duringTime;
	public float release_StartScale;
	public float release_endScale;
	public Vector3 release_start_pos;
	public Vector3 release_end_pos;
	public Sprite[] release_sp;

	//<summary>
	//"exit"状态下的数据;
	//</summary>
	public float exit_duringTime;
	public float exit_StartScale;
	public float exit_endScale;
	public Vector3 exit_start_pos;
	public Vector3 exit_end_pos;
	public Sprite[] exit_sp;

	// Use this for initialization
	void Start () {
		index = 0;
		commonRectTransform = gameObject.GetComponent<RectTransform> ();
		gameObject.GetComponent<Image> ().sprite = _initSprite;
	}

	// Update is called once per frame
	void Update () {
		switch(sta)
		{
		case stage.init:
			buttonInit ();
			break;
		case stage.enter:
			buttonEnter ();
			break;
		case stage.normal:
			buttonNormal ();
			break;
		case stage.press:
			buttonPress ();
			break;
		case stage.release:
			buttonRelease ();
			break;
		case stage.exit:
			buttonExit ();
			break;
		}
	}

	private void buttonInit()
	{
		if(_IsFinish)
		{
			_IsFinish = false;
			StopAllCoroutines ();
			commonRectTransform.anchoredPosition = init_pos;
			gameObject.GetComponent<Image> ().sprite = _initSprite;
		}
	}

	private void buttonEnter()
	{
		if (_IsFinish && enter_duringTime!=0) {
			_IsFinish = false;
			StartCoroutine (UpdateTexture(enter_duringTime,enter_sp));
			commonRectTransform.anchoredPosition = new Vector2(enter_start_pos.x,enter_start_pos.y);
			//gameObject.GetComponent<RectTransform> ().DOScale (new Vector3(enter_StartScale,enter_StartScale,1),enter_duringTime);
			commonRectTransform.sizeDelta = new Vector2 (width*enter_StartScale,height*enter_StartScale);
			commonRectTransform.DOAnchorPos3D (enter_end_pos, enter_duringTime);
			commonRectTransform.DOScale (new Vector3(enter_endScale/enter_StartScale,enter_endScale/enter_StartScale,1),enter_duringTime);
			sta = stage.normal;
		}
		else if(_IsFinish && enter_duringTime==0)
		{
			sta = stage.normal;
		}
	}

	private void buttonNormal()
	{
		if(_IsFinish && normal_duringTime!=0)
		{
			_IsFinish = false;
			StopAllCoroutines();
			commonRectTransform.anchoredPosition = normal_start_pos;
			commonRectTransform.sizeDelta = new Vector2 (width*normal_StartScale,height*normal_StartScale);
			commonRectTransform.DOAnchorPos3D (normal_end_pos, normal_duringTime);
			commonRectTransform.DOScale (new Vector3(normal_endScale/normal_StartScale,normal_endScale/normal_StartScale,1),normal_duringTime);
			StartCoroutine ("UpdateNormalTexture");
			sta = stage.press;
		}
		else if(_IsFinish && normal_duringTime==0)
		{
			sta = stage.init;
		}
	}

	private void buttonPress()
	{
		if(_IsFinish && press_duringTime!=0)
		{
			_IsFinish = false;
			StopCoroutine ("UpdateNormalTexture");
			StartCoroutine ("UpdateDownTexture");
			commonRectTransform.anchoredPosition = new Vector2(press_start_pos.x,press_start_pos.y);
			commonRectTransform.sizeDelta = new Vector2 (width*press_StartScale,height*press_StartScale);
			commonRectTransform.DOAnchorPos3D (press_end_pos, press_duringTime);
			commonRectTransform.DOScale (new Vector3(press_endScale/press_StartScale,press_endScale/press_StartScale,1),press_duringTime);
			sta = stage.release;
		}
		else if(_IsFinish && press_duringTime==0)
		{
			sta = stage.normal;
		}
	}

	private void buttonRelease()
	{
		if(_IsFinish && release_duringTime!=0)
		{
			_IsFinish = false;
			StartCoroutine (UpdateTexture(release_duringTime,release_sp));
			commonRectTransform.anchoredPosition = new Vector2(release_start_pos.x,release_start_pos.y);
			commonRectTransform.sizeDelta = new Vector2 (width*release_StartScale,height*release_StartScale);
			commonRectTransform.DOAnchorPos3D (release_end_pos, release_duringTime);
			commonRectTransform.DOScale (new Vector3(release_endScale/release_StartScale,release_endScale/release_StartScale,1),release_duringTime);
			sta = stage.normal;
		}
		else if(_IsFinish && release_duringTime==0)
		{
			sta = stage.normal;
		}
	}

	private void buttonExit()
	{
		if(_IsFinish && exit_duringTime!=0)
		{
			_IsFinish = false;
			StartCoroutine (UpdateTexture(exit_duringTime,exit_sp));
			commonRectTransform.anchoredPosition = new Vector2(exit_start_pos.x,exit_start_pos.y);
			commonRectTransform.sizeDelta = new Vector2 (width*exit_StartScale,height*exit_StartScale);
			commonRectTransform.DOAnchorPos3D (exit_end_pos, exit_duringTime);
			commonRectTransform.DOScale (new Vector3(exit_endScale/exit_StartScale,exit_endScale/exit_StartScale,1),exit_duringTime);
			sta = stage.init;
		}
		else if(_IsFinish && exit_duringTime==0)
		{
			sta = stage.normal;
		}
	}

	public void OnPointerDown(PointerEventData data)
	{
		Debug.Log ("Pointer Down!");
		sta = stage.press;
		_IsFinish = true;
	}

	public void OnPointerUp(PointerEventData data)
	{
		Debug.Log ("Pointer Up!");
		StopCoroutine ("UpdateDownTexture");
		_IsFinish = true;
		if(doOne!=null)
		{
			doOne (_id);
		}
	}

	public void ButtonPoint()
	{
	}
		

	IEnumerator UpdateTexture(float tt,Sprite[] s)
	{
		for(float i=0;i<tt;i+=tt/3.0f)
		{
			yield return StartCoroutine (Wait((float)tt/3.0f));
			if(s.Length>0)
			{
				if (index == s.Length) {
					index = 0;
				}
				gameObject.GetComponent<Image>().sprite=s[index++];
			}
		}
		if(sta==stage.normal)
		{
			_IsFinish = true;
		}
	}

	IEnumerator UpdateNormalTexture()
	{
		while(true)
		{
			yield return StartCoroutine (Wait((float)normal_duringTime/3.0f));
			if(normal_sp.Length>0)
			{
				if (index == normal_sp.Length) {
					index = 0;
				}
				gameObject.GetComponent<Image>().sprite=normal_sp[index++];
			}
		}
	}

	IEnumerator UpdateDownTexture()
	{
		while(true)
		{
			yield return StartCoroutine (Wait((float)press_duringTime/3.0f));
			if(press_sp.Length>0)
			{
				if (index == normal_sp.Length) {
					index = 0;
				}
				gameObject.GetComponent<Image>().sprite=press_sp[index++];
			}
		}
	}

	IEnumerator Wait(float time)
	{
		for(float i=0;i<time;i+=Time.deltaTime)
		{
			yield return 0;
		}
	}
}

