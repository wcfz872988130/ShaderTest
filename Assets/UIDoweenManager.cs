//using UnityEngine;
//using System.Collections;
//using System.Collections.Generic;
//using UnityEngine.UI;
//using DG.Tweening;
//
//public class UIDoweenManager : MonoBehaviour {
//	public RectTransform _button1;
//	public RectTransform _button2;
//	public RectTransform _button3;
//	public RectTransform _button4;
//	public int[] status=new int[4];
//	private static List<RectTransform> button=new List<RectTransform>();
//	public  enum showType
//	{
//		showAll, showSingle
//	}
//
//	public enum ShowTime
//	{
//		AfterAnimation,
//		Immediately
//	}
//	public ShowTime ST=ShowTime.AfterAnimation;
//	public showType sty=showType.showAll;
//
//
//	private static UIDoweenManager _Instance;
//	private int button_id;
//	private UIDoweenManager()
//	{
//		_Instance = this;
//	}
//
//	public static UIDoweenManager GetUIDoweenManager()
//	{
//		if(_Instance==null)
//		{
//			_Instance = new UIDoweenManager ();
//		}
//		return _Instance;
//	}
//
//	// Use this for initialization
//	void Start () {
//		button.Add (_button1);
//		button.Add (_button2);
//		button.Add (_button3);
//		button.Add (_button4);
//		switch(sty)
//		{
//		case showType.showAll:
//			_button1.DOAnchorPos3D (new Vector3 (100, -250, 0), 2);
//			_button2.DOAnchorPos3D (new Vector3 (0, -50, 0), 2);
//			_button3.DOAnchorPos3D (new Vector3 (0, 50, 0), 2);
//			_button4.DOAnchorPos3D (new Vector3(-100,0,0),2);
//			break;
//		case showType.showSingle:
//			for(int i=0;i<status.Length;i++)
//			{
//				if (status [i]==1) {
//					switch(i)
//					{
//					case 1:
//						_button1.DOAnchorPos3D (new Vector3 (100, -250, 0), 2);
//						break;
//					case 2:
//						_button2.DOAnchorPos3D (new Vector3 (0, -50, 0), 2);
//						break;
//					case 3:
//						_button3.DOAnchorPos3D (new Vector3 (0, 50, 0), 2);
//						break;
//					case 4:
//						_button4.DOAnchorPos3D (new Vector3 (-100, 0, 0), 2);
//						break;
//					}
//				}
//			}
//			break;
//		}
//		ButtonClick.doOne+=DecideAnimationPlay;
//	}
//
//	// Update is called once per frame
//	void Update () {
//	}
//
//
//	public void DecideAnimationPlay(int _id)
//	{
//		button_id = _id;
//		status = button [_id].GetComponent<ButtonClick> ().Status;
//		ST = button [_id].GetComponent<ButtonClick> ().en;
//		ButtonFunction ();
//	}
//
//	public void ButtonFunction()
//	{
//		if (ST == ShowTime.AfterAnimation) {
//			Debug.Log ("Button2----播放动画2");
//			StartCoroutine (GetResult ());
//		} 
//		else
//		{
//			for(int i=0;i<button.Count;i++)
//			{
//				if(status[i]==0)
//				{
//					switch(i)
//					{
//					case 0:
//						_button1.DOAnchorPos3D (new Vector3 (-100, -250, 0), 2);
//						break;
//					case 1:
//						_button2.DOAnchorPos3D (new Vector3 (0, 40, 0), 2);
//						break;
//					case 2:
//						_button3.DOAnchorPos3D (new Vector3 (0, -40, 0), 2);
//						break;
//					case 3:
//						_button4.DOAnchorPos3D (new Vector3 (100, 0, 0), 2);
//						break;
//					}
//				}
//				else if(status[i]==1)
//				{
//					switch(i)
//					{
//					case 0:
//						_button1.DOAnchorPos3D (new Vector3 (100, -250, 0), 2);
//						break;
//					case 1:
//						_button2.DOAnchorPos3D (new Vector3 (0, -50, 0), 2);
//						break;
//					case 2:
//						_button3.DOAnchorPos3D (new Vector3 (0, 50, 0), 2);
//						break;
//					case 3:
//						_button4.DOAnchorPos3D (new Vector3 (-100, 0, 0), 2);
//						break;
//					}
//				}
//			}
//		}
//	}
//
//	public void Button3Function()
//	{
//		Debug.Log ("Button2----");
//	}
//
//	public void showStatus()
//	{
//		for(int i=0;i<status.Length;i++)
//		{
//			Debug.Log (status[i]);
//		}
//	}
//
//	IEnumerator GetResult()
//	{
//		//Debug.Log ("开启协程");
//		yield return StartCoroutine (Wait(5));
//		//_button2.SetActive (true);
//		for(int i=0;i<button.Count;i++)
//		{
//			if(status[i]==0)
//			{
//				switch(i)
//				{
//				case 0:
//					_button1.DOAnchorPos3D (new Vector3 (-100, -250, 0), 2);
//					break;
//				case 1:
//					_button2.DOAnchorPos3D (new Vector3 (0, 40, 0), 2);
//					break;
//				case 2:
//					_button3.DOAnchorPos3D (new Vector3 (0, -40, 0), 2);
//					break;
//				case 3:
//					_button4.DOAnchorPos3D (new Vector3 (100, 0, 0), 2);
//					break;
//				}
//			}
//			else if(status[i]==1)
//			{
//				switch(i)
//				{
//				case 0:
//					_button1.DOAnchorPos3D (new Vector3 (100, -250, 0), 2);
//					break;
//				case 1:
//					_button2.DOAnchorPos3D (new Vector3 (0, -50, 0), 2);
//					break;
//				case 2:
//					_button3.DOAnchorPos3D (new Vector3 (0, 50, 0), 2);
//					break;
//				case 3:
//					_button4.DOAnchorPos3D (new Vector3 (-100, 0, 0), 2);
//					break;
//				}
//			}
//		}
//	}
//
//	IEnumerator Wait(int lastTime)
//	{
//		for(float time=0;time<lastTime;time+=Time.deltaTime)
//		{
//			yield return 0;
//		}
//	}
//}
//
