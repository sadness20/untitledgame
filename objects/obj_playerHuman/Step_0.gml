/// @description Insert description here
// You can write your code in this editor
switch(state)
{
	case "idle":
		break;
		
	case "begin path":
		path_start(movementPath, moveSpeed, 0, true);
		global.unitMoving = 1;
		
		state = "moving";
		break;
}
