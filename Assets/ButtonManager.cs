using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.UI;
using DG.Tweening;

public class ButtonManager : MonoBehaviour {
	public GameObject _button1;
	public GameObject _button2;
	public GameObject _button3;
	public GameObject _button4;
	public int[] status=new int[4];
	private static List<GameObject> button=new List<GameObject>();
	public  enum showType
	{
		showAll, showSingle
	}

	public enum ShowTime
	{
		AfterAnimation,
		Immediately
	}
	public ShowTime ST=ShowTime.AfterAnimation;
	public showType sty=showType.showAll;
 

	private static ButtonManager _Instance;
	private int button_id;
	private ButtonManager()
	{
		_Instance = this;
	}

	public static ButtonManager GetButtonManager()
	{
		if(_Instance==null)
		{
			_Instance = new ButtonManager ();
		}
		return _Instance;
	}

	// Use this for initialization
	void Start () {
		button.Add (_button1);
		button.Add (_button2);
		button.Add (_button3);
		button.Add (_button4);
		switch(sty)
		{
		case showType.showAll:
			_button1.SetActive (true);
			_button2.SetActive (true);
			_button3.SetActive (true);
			_button4.SetActive (true);
			break;
		case showType.showSingle:
			for(int i=0;i<status.Length;i++)
			{
				if (status [i]==1) {
					button [i].SetActive (true);
				}
			}
			break;
		}
		ButtonClick.doOne+=DecideAnimationPlay;
	}
	
	// Update is called once per frame
	void Update () {
	}
		

	public void DecideAnimationPlay(int _id)
	{
		button_id = _id;
		status = button [_id].GetComponent<ButtonClick> ().Status;
		//ST = button [_id].GetComponent<ButtonClick> ().en;
		ButtonFunction ();
	}

	public void ButtonFunction()
	{
		if (ST == ShowTime.AfterAnimation) {
			Debug.Log ("Button2----播放动画2");
			StartCoroutine (GetResult ());
		} 
		else
		{
			for(int i=0;i<button.Count;i++)
			{
				if(status[i]==0)
				{
					button [i].SetActive (false);
				}
				else if(status[i]==1&&button_id==1)
				{
					button [i].SetActive (true);
				}
			}
		}
	}

	public void Button3Function()
	{
		Debug.Log ("Button2----");
	}

	public void showStatus()
	{
		for(int i=0;i<status.Length;i++)
		{
			Debug.Log (status[i]);
		}
	}

	public void exit()
	{
		for(int i=0;i<button.Count;i++)
		{
			button[i].SetActive(false);
		}
	}

	IEnumerator GetResult()
	{
		//Debug.Log ("开启协程");
		yield return StartCoroutine (Wait(5));
		//_button2.SetActive (true);
		for(int i=0;i<button.Count;i++)
		{
			if(status[i]==0)
			{
				button [i].SetActive (false);
			}
			else if(status[i]==1)
			{
				button [i].SetActive (true);
			}
		}
	}

	IEnumerator Wait(int lastTime)
	{
		for(float time=0;time<lastTime;time+=Time.deltaTime)
		{
			yield return 0;
		}
	}
}
