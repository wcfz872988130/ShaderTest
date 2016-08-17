using UnityEngine;
using System;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

public class ShowButton : MonoBehaviour {
	private static ShowButton _Instance;
	private TextAsset s;
	private int button_id;//按钮的ID;
	public List<GameObject> Bbutton;
	//private Sprite[] enter_sprite;
	public GameObject m_button;
	JsonParse aa;

	public  enum showType
	{
		showAll, showSingle
	}

	public enum ShowTime
	{
		AfterAnimation,
		Immediately
	}
	public showType sty=showType.showAll;
	private ShowTime ST;//按钮的显示状态；
	private int[] status;
	// Use this for initialization
	private ShowButton()
	{
		_Instance = this;
	}
	void Start () {
		string path = "StreamingAsset/buttonConfig.json";
		string tmp = JsonFile.ParseJson (path);
//		s = Resources.Load ("buttonConfig") as TextAsset;
//		string tmp = s.text;
		aa=JsonParse.CreateFromJSON (tmp);
		string id = aa.id;
		switch(id)
		{
		case "001":
			UpdateButton ();
			break;
		}
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	private void UpdateButton()
	{
		int numButton = aa.buttons.Length;
		string commands = aa.command;
		for (int i = 0; i < numButton; i++) {
			string actionType = aa.buttons [i].actionType;//获取按钮触发方式;
			string subcommand = aa.buttons [i].subcommand;//获取触发后所有按钮的状态;
			int[] sub=StringToInt(subcommand);
			GameObject mm_button = Resources.Load ("Button1") as GameObject;
			GameObject m_button=Instantiate (mm_button)as GameObject;
			Vector2 tpos = vectorParse (aa.buttons[i].pos);
			m_button.GetComponent<ButtonClick> ().init_pos = new Vector2(tpos.x*Screen.width,-tpos.y*Screen.height);
			//<Summary>
			//设置按钮的初始纹理;
			//</Summary>
			string icon = aa.buttons [i].icon;
			string path = "Texture and Sprites/Rounded UI/" + icon;
			Sprite init_icon = Resources.Load(path,typeof(Sprite)) as Sprite;
			m_button.GetComponent<ButtonClick> ()._initSprite=init_icon;
			if(actionType=="0")
			{
				m_button.GetComponent<ButtonClick> ().en = ShowTime.Immediately;
			}
			else if(actionType=="1")
			{
				m_button.GetComponent<ButtonClick> ().en = ShowTime.AfterAnimation;
			}
			m_button.GetComponent<ButtonClick> ()._id = i;//传递按钮的id;
			m_button.GetComponent<ButtonClick> ().Status = sub;//传递其他按钮的状态;
			TransEnterData(i,m_button);
			TransNormalData (i,m_button);
			TransPressData (i,m_button);
			TransReleaseData (i,m_button);
			TransExitData (i,m_button);
			m_button.GetComponentInChildren<Text> ().text = (i + 1).ToString();
			m_button.transform.parent = GameObject.Find ("Canvas").transform;
			m_button.GetComponent<ButtonClick> ().width = aa.buttons [i].width;
			m_button.GetComponent<ButtonClick> ().height= aa.buttons[i].height;
			m_button.SetActive (true);
			Bbutton.Add (m_button);
		}
		switch(sty)
		{
		case showType.showAll:
			for(int i=0;i<Bbutton.Count;i++)
			{
				Bbutton [i].GetComponent<ButtonClick> ().sta = ButtonClick.stage.enter;
				Bbutton [i].GetComponent<ButtonClick> ()._IsFinish=true;
				Bbutton [i].GetComponent<ButtonClick> ()._IsAlive = true;
			}
			break;
		case showType.showSingle:
			for(int i=0;i<commands.Length;i++)
			{
				if(IsButtonVisible(i,commands)==1)
				{
					Bbutton [i].GetComponent<ButtonClick> ().sta = ButtonClick.stage.enter;
					Bbutton [i].GetComponent<ButtonClick> ()._IsFinish=true;
					Bbutton [i].GetComponent<ButtonClick> ()._IsAlive = true;
				}
			}
			break;
		}
		ButtonClick.doOne+=DecideAnimationPlay;
	}

	private void TransEnterData(int i,GameObject m_button)
	{
		string _EnterIcon = aa.buttons [i].enter.subIcon;//解析enter状态下的图集;
		string[] enter_subIcon = IconSequence (_EnterIcon);
		m_button.GetComponent<ButtonClick> ().enter_sp = ButtonSprite (enter_subIcon);
		Vector2 startpos = vectorParse (aa.buttons[i].enter.startPos);
		Vector2 endpos = vectorParse (aa.buttons[i].enter.endPos);
		m_button.GetComponent<ButtonClick> ().enter_start_pos = new Vector3 (startpos.x * Screen.width,-startpos.y*Screen.height,0);
		m_button.GetComponent<ButtonClick> ().enter_end_pos = new Vector3 ( endpos.x * Screen.width,-endpos.y*Screen.height,0);
		m_button.GetComponent<ButtonClick> ().enter_duringTime = aa.buttons[i].enter.during;
		m_button.GetComponent<ButtonClick> ().enter_StartScale = aa.buttons[i].enter.startScale;
		m_button.GetComponent<ButtonClick> ().enter_endScale = aa.buttons[i].enter.endScale;
	}

	private void TransNormalData (int i,GameObject m_button)
	{
		string _NormalIcon = aa.buttons [i].normal.subIcon;//解析normal状态下的图集;
		string[] normal_subIcon = IconSequence (_NormalIcon);
		m_button.GetComponent<ButtonClick> ().normal_sp = ButtonSprite (normal_subIcon);
		Vector2 startpos = vectorParse (aa.buttons[i].normal.startPos);
		Vector2 endpos = vectorParse (aa.buttons[i].normal.endPos);    
		m_button.GetComponent<ButtonClick> ().normal_start_pos = new Vector3 (startpos.x * Screen.width,-startpos.y*Screen.height,0);
		m_button.GetComponent<ButtonClick> ().normal_end_pos = new Vector3 ( endpos.x * Screen.width,-endpos.y*Screen.height,0);
		m_button.GetComponent<ButtonClick> ().normal_duringTime = aa.buttons[i].normal.during;
		m_button.GetComponent<ButtonClick> ().normal_StartScale = aa.buttons[i].normal.startScale;
		m_button.GetComponent<ButtonClick> ().normal_endScale = aa.buttons[i].normal.endScale;
	}

	private void TransPressData(int i,GameObject m_button)
	{
		string _PressIcon = aa.buttons [i].press.subIcon;//解析press状态下的图集;
		string[] press_subIcon = IconSequence (_PressIcon);
		m_button.GetComponent<ButtonClick> ().press_sp = ButtonSprite (press_subIcon);
		Vector2 startpos = vectorParse (aa.buttons[i].press.startPos);
		Vector2 endpos = vectorParse (aa.buttons[i].press.endPos);
		m_button.GetComponent<ButtonClick> ().press_start_pos = new Vector3 (startpos.x * Screen.width,-startpos.y*Screen.height,0);
		m_button.GetComponent<ButtonClick> ().press_end_pos = new Vector3 ( endpos.x * Screen.width,-endpos.y*Screen.height,0);
		m_button.GetComponent<ButtonClick> ().press_duringTime = aa.buttons[i].press.during;
		m_button.GetComponent<ButtonClick> ().press_StartScale = aa.buttons[i].press.startScale;
		m_button.GetComponent<ButtonClick> ().press_endScale = aa.buttons[i].press.endScale;
	}

	private void TransReleaseData(int i,GameObject m_button)
	{
		string _ReleaseIcon = aa.buttons [i].release.subIcon;//解析Release状态下的图集;
		string[] release_subIcon = IconSequence (_ReleaseIcon);
		m_button.GetComponent<ButtonClick> ().release_sp = ButtonSprite (release_subIcon);
		Vector2 startpos = vectorParse (aa.buttons[i].release.startPos);
		Vector2 endpos = vectorParse (aa.buttons[i].release.endPos);
		m_button.GetComponent<ButtonClick> ().release_start_pos = new Vector3 (startpos.x * Screen.width,-startpos.y*Screen.height,0);
		m_button.GetComponent<ButtonClick> ().release_end_pos = new Vector3 ( endpos.x * Screen.width,-endpos.y*Screen.height,0);
		m_button.GetComponent<ButtonClick> ().release_duringTime = aa.buttons[i].release.during;
		m_button.GetComponent<ButtonClick> ().release_StartScale = aa.buttons[i].release.startScale;
		m_button.GetComponent<ButtonClick> ().release_endScale = aa.buttons[i].release.endScale;
	}

	private void TransExitData(int i,GameObject m_button)
	{
		string _EixtIcon = aa.buttons [i].exit.subIcon;//解析exit状态下的图集;
		string[] exit_subIcon = IconSequence (_EixtIcon);
		m_button.GetComponent<ButtonClick> ().exit_sp = ButtonSprite (exit_subIcon);
		Vector2 startpos = vectorParse (aa.buttons[i].exit.startPos);
		Vector2 endpos = vectorParse (aa.buttons[i].exit.endPos);
		m_button.GetComponent<ButtonClick> ().exit_start_pos = new Vector3 (startpos.x * Screen.width,-startpos.y*Screen.height,0);
		m_button.GetComponent<ButtonClick> ().exit_end_pos = new Vector3 ( endpos.x * Screen.width,-endpos.y*Screen.height,0);
		m_button.GetComponent<ButtonClick> ().exit_duringTime = aa.buttons[i].exit.during;
		m_button.GetComponent<ButtonClick> ().exit_StartScale = aa.buttons[i].exit.startScale;
		m_button.GetComponent<ButtonClick> ().exit_endScale = aa.buttons[i].exit.endScale;
	}

	public void DecideAnimationPlay(int _id)
	{
		button_id = _id;
		status = Bbutton [_id].GetComponent<ButtonClick> ().Status;
		ST = Bbutton [_id].GetComponent<ButtonClick> ().en;
		//Bbutton [_id].GetComponent<ButtonClick> ().sta = ButtonClick.stage.press;
		//Bbutton [_id].GetComponent<ButtonClick> ()._IsFinish = true;
		switch(ST)
		{
		case ShowTime.AfterAnimation:
			StartCoroutine (GetResult());
			break;
		case ShowTime.Immediately:
			for(int i=0;i<Bbutton.Count;i++)
			{
				if(status[i]==0 && Bbutton [i].GetComponent<ButtonClick> ()._IsAlive)
				{
					Bbutton [i].GetComponent<ButtonClick>().sta=ButtonClick.stage.exit;
					Bbutton [i].GetComponent<ButtonClick> ()._IsFinish = true;
					Bbutton [i].GetComponent<ButtonClick> ()._IsAlive = false;
				}
				else if(status[i]==1)
				{
					if (Bbutton [i].GetComponent<ButtonClick> ()._IsAlive == false) {
						Bbutton [i].GetComponent<ButtonClick> ().sta = ButtonClick.stage.enter;
						Bbutton [i].GetComponent<ButtonClick> ()._IsFinish = true;
						Bbutton [i].GetComponent<ButtonClick> ()._IsAlive = true;
					} else {
						Bbutton [i].GetComponent<ButtonClick> ().sta = ButtonClick.stage.normal;
						Bbutton [i].GetComponent<ButtonClick> ()._IsFinish = true;
					}
				}
			}
			break;
		}
		//ButtonFunction ();
	}

	private Vector2 vectorParse(string s)
	{
		if(s==null)
		{
			Debug.Log ("VectorParse False!");
			return Vector2.zero;
		}
		string[] partName = s.Split (' ');
		float a1 = float.Parse (partName [0]);
		float a2 = float.Parse (partName [1]);
		Vector2 pos = new Vector2 (a1,a2);
		return pos;
	}

	private string[] IconSequence(string s)
	{
		if(s==null)
		{
			Debug.Log ("IconSequence False!");
			return null;
		}
		string[] partName = s.Split (' ');
		return partName;
	}
		
	private int IsButtonVisible(int i,string s)
	{
		if(s==null)
		{
			Debug.Log ("IsButtonVisible False!");
			return 0;
		}
		char[] cc = s.ToCharArray ();
		int a=Convert.ToInt32 (cc[i])-48;
		return a;
	}

	private int[] StringToInt(string s)
	{
		if(s==null)
		{
			Debug.Log ("StringToInt False!");
			return null;
		}
		char[] cc = s.ToCharArray ();
		int[] aa=new int[cc.Length];
		for(int i=0;i<cc.Length;i++)
		{
			aa[i]=Convert.ToInt32 (cc[i])-48;
		}
		return aa;
	}

	private Sprite[] ButtonSprite(string[] s)
	{
		if(s==null)
		{
			Debug.Log ("ButtonSprite False!");
			return null;
		}
		Sprite[] enter_sprite=new Sprite[s.Length];
		for(int i=0;i<s.Length;i++)
		{
			string path = "Texture and Sprites/Rounded UI/" + s [i];
			enter_sprite [i] = Resources.Load (path,typeof(Sprite)) as Sprite;
		}
		return enter_sprite;
	}

	IEnumerator GetResult()
	{
		yield return StartCoroutine (Wait(3));
		for(int i=0;i<Bbutton.Count;i++)
		{
			if(status[i]==0)
			{
				Bbutton [i].GetComponent<ButtonClick>().sta=ButtonClick.stage.exit;
				Bbutton [i].GetComponent<ButtonClick> ()._IsFinish = true;
				Bbutton [i].GetComponent<ButtonClick> ()._IsAlive = false;
			}
			else if(status[i]==1)
			{
				if (Bbutton [i].GetComponent<ButtonClick> ()._IsAlive == false) {
					Bbutton [i].GetComponent<ButtonClick> ().sta = ButtonClick.stage.enter;
					Bbutton [i].GetComponent<ButtonClick> ()._IsFinish = true;
					Bbutton [i].GetComponent<ButtonClick> ()._IsAlive = true;
				} else {
					Bbutton [i].GetComponent<ButtonClick> ().sta = ButtonClick.stage.normal;
					Bbutton [i].GetComponent<ButtonClick> ()._IsFinish = true;
				}
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
