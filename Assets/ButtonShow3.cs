using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class ButtonShow3 : MonoBehaviour {
	private ButtonManager _Instance;
	public int[] Status=new int[4]; 
	//public List<GameObject> button=new List<GameObject>();
	// Use this for initialization
	void Start () {
		_Instance = ButtonManager.GetButtonManager ();
		//ButtonManager.doOne += DoOnething;
	}

	// Update is called once per frame
	void Update () {

	}

	public void ButtonClick()
	{
		_Instance.status = Status;
		//ButtonManager.doOne += DoOnething;
		//_Instance.Button2Function();
		_Instance.showStatus ();
	}

	void OnDisable()
	{
	}

	public void DoThirdthing(int[] s)
	{
		/*for(int i=0;i<Status.Length;i++)
		{
			if (s[i] == 0) {
				gameObject.SetActive (false);
			} else {
				gameObject.SetActive(true);
			}
		}*/
		if (s[2] == 1) {
			gameObject.SetActive (true);
		} 
		else if(s[2]==0){
			gameObject.SetActive(false);
		}
	}
}
