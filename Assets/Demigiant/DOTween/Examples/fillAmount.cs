using UnityEngine;
using System.Collections;

public class fillAmount : MonoBehaviour {
	public bool finished=false;
	// Use this for initialization
	void Start () {
	}

	void Update()
	{
		DoSkill();
	}

	public void DoSkill()
	{
		if(finished)
		{
			finished=false;
			StartCoroutine(SetSkillValue());
		}
	}

	private IEnumerator SetSkillValue()
	{
		for(int i=0;i<=50;i++)
		{
			this.GetComponent<UnityEngine.UI.Image>().fillAmount=i*0.02f;
			yield return new WaitForSeconds(0.01f);
		}
		//finished=true;
	}

	public void Show()
	{
		Debug.Log("Success!");
	}


}
