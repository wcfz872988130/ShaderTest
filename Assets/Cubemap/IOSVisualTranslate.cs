//using UnityEngine;
//using System.Collections;
//
//public class VisualTranslate : MonoBehaviour {
//
////用于绑定参照物对象
//public Transform target;
////缩放系数
//float distance = 10.0f;
////左右滑动移动速度
//float xSpeed = 250.0f;
//float ySpeed = 120.0f;
////缩放限制系数
//float yMinLimit = -20f;
//float yMaxLimit = 80f;
////摄像头的位置
//float x = 0.0f;
//float y = 0.0f;
////记录上一次手机触摸位置判断用户是在左放大还是缩小手势
//private Vector2 oldPosition1;
//private Vector2 oldPosition2;
//
////初始化游戏信息设置
//void Start()
//{
//	//eulerAngles（欧拉角）：x、y、z角代表绕z轴旋转z度，绕x轴旋转x度，绕y轴旋转y度（这个顺序）。
//	var angles = transform.eulerAngles;//即摄像头的相对Rotation的值
//	x = angles.y;
//	y = angles.x;
//
//	// Make the rigid body not change rotation
//	//if (rigidbody)
//		//rigidbody.freezeRotation = true;//冻结旋转，如果freezeRotation被启用，旋转不会被物体模拟修改。这对于创建第一人称射击游戏时是很有用的，因为玩家需要使用鼠标完全控制旋转。
//}
//
//void Update()
//{
//	//判断触摸数量为单点触摸
//	if (Input.touchCount == 1)
//	{
//		//触摸类型为移动触摸
//		if (Input.GetTouch(0).phase == TouchPhase.Moved)
//		{
//			//根据触摸点计算X与Y位置
//			x += (float)(Input.GetAxis("Mouse X") * xSpeed * 0.02);
//			y -= (float)(Input.GetAxis("Mouse Y") * ySpeed * 0.02);
//		}
//	}
//
//	//判断触摸数量为多点触摸
//	if (Input.touchCount > 1)
//	{
//		//前两只手指触摸类型都为移动触摸
//		if (Input.GetTouch(0).phase == TouchPhase.Moved || Input.GetTouch(1).phase == TouchPhase.Moved)
//		{
//			//计算出当前两点触摸点的位置
//			var tempPosition1 = Input.GetTouch(0).position;
//			var tempPosition2 = Input.GetTouch(1).position;
//			//函数返回真为放大，返回假为缩小
//			if (isEnlarge(oldPosition1, oldPosition2, tempPosition1, tempPosition2))
//			{
//				//放大系数超过3以后不允许继续放大
//				//这里的数据是根据我项目中的模型而调节的，大家可以自己任意修改
//				if (distance > 3)
//				{
//					distance -= 0.5f;
//				}
//			}
//			else
//			{
//				//缩小系数返回18.5后不允许继续缩小
//				//这里的数据是根据我项目中的模型而调节的，大家可以自己任意修改
//				if (distance < 18.5)
//				{
//					distance += 0.5f;
//				}
//			}
//			//备份上一次触摸点的位置，用于对比
//			oldPosition1 = tempPosition1;
//			oldPosition2 = tempPosition2;
//		}
//	}
//}
//
////函数返回真为放大，返回假为缩小
//bool isEnlarge(Vector2 oP1, Vector2 oP2, Vector2 nP1, Vector2 nP2)
//{
//	//函数传入上一次触摸两点的位置与本次触摸两点的位置计算出用户的手势
//	// var leng1 = Mathf.Sqrt((oP1.x - oP2.x) * (oP1.x - oP2.x) + (oP1.y - oP2.y) * (oP1.y - oP2.y));
//	// var leng2 = Mathf.Sqrt((nP1.x - nP2.x) * (nP1.x - nP2.x) + (nP1.y - nP2.y) * (nP1.y - nP2.y));
//	var leng1 = Vector2.Distance(oP1, oP2);
//	var leng2 = Vector2.Distance(nP1, nP2);
//	if (leng1 < leng2)
//	{
//		//放大手势
//		return true;
//	}
//	else
//	{
//		//缩小手势
//		return false;
//	}
//}
////Update方法一旦调用结束以后进入这里算出重置摄像机的位置
//void LateUpdate()
//{
//	//target为我们绑定的箱子变量，缩放旋转的参照物
//	if (target)
//	{
//		//重置摄像机的位置
//		y = ClampAngle(y, yMinLimit, yMaxLimit);
//		var rotation = Quaternion.Euler(y, x, 0);
//		var position = rotation * new Vector3(0.0f, 0.0f, -distance) + target.position;
//		//rotation.ToAngleAxis(out zwhangle, out zwhaxis); 转换一个旋转用“角-轴”表示。
//		//position表示此时将camera对象的位置设置为new Vector3(0.0f, 0.0f, -distance)，为起点位置，然后从这个位置绕zwhaxis轴旋转zwhangle角度为止，从而获得新的位置，而加上target.position，是使camera对象的位置距离zwhaxis轴的更远
//		//transform.rotation = rotation;//这句可以用下面的方式，都是一样的
//		transform.position = position;
//		transform.rotation = Quaternion.LookRotation(target.position - transform.position);
//	}
//}
//
//static float ClampAngle(float angle, float min, float max)
//{
//	if (angle < -360)
//		angle += 360;
//	if (angle > 360)
//		angle -= 360;
//	return Mathf.Clamp(angle, min, max);
//}
//
//}