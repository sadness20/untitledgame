/// @description Insert description here
// You can write your code in this editor

switch(state)
{
	case 0:
		with (obj_node)
		{
			tempObject = instance_position(x + global.gridSize / 2, y + global.gridSize / 2, obj_marker1);
			if(tempObject)
			{
				switch(tempObject.zone)
				{
					case 1:
						zone = 1;
						break;
					case 2:
						zone = 2;
						break;
					case 3:
						zone = 3;
						break;
				}
			}
			if(zone == 0)passable = false;
			tempObject = instance_position(x + global.gridSize / 2, y + global.gridSize / 2, obj_terrain);
			if(tempObject)
			{
				switch(tempObject.type)
				{
					case 1:
						passable = false;
						cost = 1;
			
						break;
					case 2:
						passable = true;
						cost = 2;
						break;
				}
				//sprite_index = tempObject.sprite_index;
				type = tempObject.type;
	
				with tempObject instance_destroy();
			}
			tempObject = instance_position(x + global.gridSize / 2, y + global.gridSize / 2, obj_unit);
			{
				if(tempObject)
				{
					occupant = tempObject;
					occupant.gridX = gridX;
					occupant.gridY = gridY;
				}
			}
			
		}
		state = 1;
		break;
	case 1:
		break;
}

global.mx = mouse_x;
global.my = mouse_y;

cx = floor(global.mx / global.gridSize);
cy = floor(global.my / global.gridSize);

if(cx < 0 || cy < 0 || cx > global.mapWidth - 1 || cy > global.mapHeight - 1 || global.map[cx, cy].zone == 0)
{
	global.hoverNode = noone;
}
else
{
	global.hoverNode = global.map[cx, cy];
}

if(global.selectedActor == noone)
{
	with(obj_unit)
	{
		if(ds_list_find_value(global.units, global.cturn) == id)
		{
			global.selectedActor = id;
			UpdateNodes(global.map[gridX, gridY], global.selectedActor.MP);
		}
	}
}

if(mouse_check_button_pressed(mb_left) && global.unitMoving == 0)
{
	if(global.selectedActor != noone && global.selectedActor.lead = global.thisPlayer && global.hoverNode.moveNode)
	{
		current = global.hoverNode;
		
		path = ds_priority_create();
		
		ds_priority_add(path, current, current.G);
		
		while(current.parent != noone)
		{
			ds_priority_add(path, current.parent, current.parent.G);
			
			current = current.parent;
		}
		
		do{
			current = ds_priority_delete_min(path);
			
			path_add_point(global.selectedActor.movementPath, current.x, current.y, 100);
		} until(ds_priority_empty(path));
		
		ds_priority_destroy(path);
		
		global.map[global.selectedActor.gridX, global.selectedActor.gridY].occupant = noone;
		
		global.selectedActor.gridX = cx;
		global.selectedActor.gridY = cy;
		
		global.selectedActor.state = "begin path";
		
		global.hoverNode.occupant = global.selectedActor;
		
		CleanNodes();
		NextTurn(global.selectedActor);
	}
}
