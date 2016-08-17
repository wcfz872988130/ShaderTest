using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

[Serializable]
public class enter
{
	public string subIcon;
	public string startPos;
	public string endPos;
	public float startScale;
	public float endScale;
	public float during;
}

[Serializable]
public class normal
{
	public string subIcon;
	public string startPos;
	public string endPos;
	public float startScale;
	public float endScale;
	public float during;
}

[Serializable]
public class press
{
	public string subIcon;
	public string startPos;
	public string endPos;
	public float startScale;
	public float endScale;
	public float during;
}

[Serializable]
public class release
{
	public string subIcon;
	public string startPos;
	public string endPos;
	public float startScale;
	public float endScale;
	public float during;
}
[Serializable]
public class exit
{
	public string subIcon;
	public string startPos;
	public string endPos;
	public float startScale;
	public float endScale;
	public float during;
}

[Serializable]
public class button
{
	public int index;
	public string type;
	public string pos;
	public int width;
	public int height;
	public string actionType;
	public string subcommand;
	public string icon;
	public enter enter;
	public normal normal;
	public press press;
	public release release;
	public exit exit;
}
	
[Serializable]
public class JsonParse
{
	public string id;
	public string command;
	public button[] buttons;



	public static JsonParse CreateFromJSON(string jsonString){
		return JsonUtility.FromJson<JsonParse>(jsonString);	
	}
}
