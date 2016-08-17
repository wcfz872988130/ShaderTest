using UnityEngine;  
using System.Collections;  

[ExecuteInEditMode]  
public class NightVisionEffect : MonoBehaviour {  

	#region Variables  
	public Shader nightVisionShader;  

	public float contrast = 2.0f;  
	public float brightness = 1.0f;  
	public Color nightVisionColor = Color.white;  

	public Texture2D vignetteTexture;  

	public Texture2D scanLineTexture;  
	public float scanLineTileAmount = 4.0f;  

	public Texture2D nightVisionNoise;  
	public float noiseXSpeed = 100.0f;  
	public float noiseYSpeed = 100.0f;  

	public float distortion = 0.2f;  
	public float scale = 0.8f;  

	private Material curMaterial;  
	private float randomValue = 0.0f;  
	#endregion  

	#region Properties  
	public Material material {  
		get {  
			if (curMaterial == null) {  
				curMaterial = new Material(nightVisionShader);  
				curMaterial.hideFlags = HideFlags.HideAndDontSave;  
			}  
			return curMaterial;  
		}  
	}  
	#endregion  

	// Use this for initialization  
	void Start () {  
		if (SystemInfo.supportsImageEffects == false) {  
			enabled = false;  
			return;  
		}  

		if (nightVisionShader != null && nightVisionShader.isSupported == false) {  
			enabled = false;  
		}  
	}  

	void OnRenderImage (RenderTexture sourceTexture, RenderTexture destTexture){  
		if (nightVisionShader != null) {  
			material.SetFloat("_Contrast", contrast);  
			material.SetFloat("_Brightness", brightness);  
			material.SetColor("_NightVisionColor", nightVisionColor);  
			material.SetFloat("_RandomValue", randomValue);  
			material.SetFloat("_Distortion", distortion);  
			material.SetFloat("_Scale", scale);  

			if (vignetteTexture) {  
				material.SetTexture("_VignetteTex", vignetteTexture);  
			}  

			if (scanLineTexture) {  
				material.SetTexture("_ScanLineTex", scanLineTexture);  
				material.SetFloat("_ScanLineTileAmount", scanLineTileAmount);  
			}  

			if (nightVisionNoise) {  
				material.SetTexture("_NoiseTex", nightVisionNoise);  
				material.SetFloat("_NoiseXSpeed", noiseXSpeed);  
				material.SetFloat("_NoiseYSpeed", noiseYSpeed);  
			}  

			Graphics.Blit(sourceTexture, destTexture, material);  
		} else {  
			Graphics.Blit(sourceTexture, destTexture);  
		}  
	}  

	// Update is called once per frame  
	void Update () {  
		contrast = Mathf.Clamp(contrast, 0.0f, 4.0f);  
		brightness = Mathf.Clamp(brightness, 0.0f, 2.0f);  
		distortion = Mathf.Clamp(distortion, -1.0f, 1.0f);  
		scale = Mathf.Clamp(scale, 0.0f, 3.0f);  
		randomValue = Random.Range(-1.0f, 1.0f);  
	}  

	void OnDisable () {  
		if (curMaterial != null) {  
			DestroyImmediate(curMaterial);  
		}  
	}  
}  
