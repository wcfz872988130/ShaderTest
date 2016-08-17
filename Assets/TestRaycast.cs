using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class TestRaycast : Image {
	override public bool IsRaycastLocationValid(Vector2 sp,Camera eventCamera)
	{
		return false;
	}
}
