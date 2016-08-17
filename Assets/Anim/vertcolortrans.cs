using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class vertcolortrans : MonoBehaviour {
	private Vector3 _StartPoint;
	public Shader newShader;
	public LayerMask m_inputMask;
	private Material curMaterial;
	private Vector4 _Pos;
	private float waveLength=1.0f;
	public Cubemap mytexture;
	private bool isFinish = false;
	public Color m_color=Color.cyan;

	/*UI的设置*/
	public RectTransform _image;
	public GameObject myImage;
	//public bool _isexit=false;
	public bool _deliver=false;
	/*Color数组*/
	public Color[] cc=new Color[6];
	public int index = 0;
	//public RectTransform myTestPoint;
	// Use this for initialization
	void Start () {
		gameObject.GetComponent<Renderer> ().sharedMaterial = material;
		isFinish = false;
		waveLength = 1.0f;
	}

	#region Properties
	public Material material {
		get {
			if (curMaterial == null) {
				curMaterial = new Material(newShader);
				//curMaterial.SetTexture("Cubemap",mytexture);
				curMaterial.hideFlags = HideFlags.HideAndDontSave;
			}
			return curMaterial;
		}
	}
	#endregion

	// Update is called once per frame
	void Update () {
		if(Input.GetMouseButton(0))
		{
			float mouseX = Input.mousePosition.x;
			float mouseY = Input.mousePosition.y;
			waveLength = 1.0f;
			Vector3 pos = Input.mousePosition;
			Ray ray = Camera.main.ScreenPointToRay (pos);
			RaycastHit hitinfo;
			bool iscast = Physics.Raycast (ray,out hitinfo,1000,m_inputMask);
			if(iscast&&(!isFinish)&&(!_deliver))
			{
				//Debug.Log (mouseX);
				_image.localPosition = new Vector3 (mouseX-Screen.width/2,mouseY-Screen.height/2,0);

				myImage.GetComponent<fillAmount>().finished = true;
				myImage.SetActive (true);

				_StartPoint = hitinfo.point;
				//Debug.Log (_StartPoint);
				isFinish = true;
				//_isexit = true;
			}
		}
		if(waveLength>=1.0f&&waveLength<=20.0f&&isFinish==true&&_deliver==true)
		{
			waveLength += Time.deltaTime*10;
			_Pos = new Vector4 (_StartPoint.x,_StartPoint.y,_StartPoint.z,0);
			if(newShader!=null)
			{
				//Debug.Log ("Success");
				material.SetVector ("_StartPos",_Pos);
				material.SetTexture ("_CubeMap",mytexture);
				material.SetFloat ("_WaveOffset",waveLength);
				material.SetColor ("_TargetColor",cc[index]);
				myImage.SetActive (false);
			}
		}
		if(waveLength>7.0f)
		{
			waveLength = 100.0f;
			material.SetFloat ("_WaveOffset",waveLength);
			_deliver = false;
			isFinish = false;
			//_isexit = false;
		}

	}
}
