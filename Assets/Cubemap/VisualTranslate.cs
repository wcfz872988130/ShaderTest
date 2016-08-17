using UnityEngine;
using System.Collections;

public class VisualTranslate : MonoBehaviour {
	public Transform _targetTransform;
	//private Vector3 _targetPos;

	/*Observe target*/

	/*Rotation Speed*/
	public float _speedX=240;
	public float _speedY=120;

	/*speed*/
	public float Damping=1.5f;

	/*degree limitation*/
	private float MinLimitY=5;
	private float MaxLimitY=80;

	/*Rotation Angle*/
	private float mx;
	private float my;

	/*Need Lerp*/
	private bool isNeedDamping = true;
	// Use this for initialization
	void Start () {
		mx = _targetTransform.eulerAngles.x;
		my = _targetTransform.eulerAngles.y;
	}

	// Update is called once per frame
	void Update () {
		if (Input.touchCount == 1)
		{
			if (Input.GetTouch(0).phase == TouchPhase.Moved)
			{
				mx += Input.GetAxis("Mouse X") * _speedX * 0.02f;
				my -= Input.GetAxis("Mouse Y") * _speedY * 0.02f;
				my = ClampAngle (my,MinLimitY,MaxLimitY);
			}
		}
			
		Quaternion mRotation = Quaternion.Euler (my,mx,0);
		//Vector3 mPosition = mRotation * new Vector3 () + _targetTransform.position;
		if (isNeedDamping) {
			transform.rotation = Quaternion.Slerp (transform.rotation, mRotation, Time.deltaTime * Damping);
		} else {
			transform.rotation = mRotation;
		}
	}

	private float ClampAngle(float angle,float min,float max)
	{
		if (angle > 360)
			angle -= 360;
		if (angle < -360)
			angle += 360;
		return Mathf.Clamp (angle,min,max);
	}
}
