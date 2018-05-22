/// @description Insert description here
// You can write your code in this editor
switch(state)
{
	case "idle":
		if(global.selectedActor == id && global.unitMoving == 0)
		{
			if(cellAttack == global.map[gridX, gridY])
			{
				if(AP >= 3)
				{
					state = "start attack";
				}
				else
				{
					state = "run";
					cellAttack = -1;
				}
				break;
			}
			else if (MP <= 0)
			{
				NextTurn(id);
				state = "idle";
				break;
			}
		
			if(AP >= 3)
			{
				state = "find target";
			} else if(MP > 0 && ran == false)
			{
				state = "run";
				ran = true;
			}
			
			if((MP <= 0 && AP <= 0 && state != "run")  || ran == true)
			{
				NextTurn(id);
				state = "idle";
				break;
			}
		}
		break;
	case "run":
		if(ran == false)
		{
			ran = true;
		}
		else
		{
			NextTurn(id);
			state = "idle";
			break;
		}
		
		cells = ds_priority_create();
		with(obj_node)
		{
			if(passable == true && occupant == noone && FindDistance(gridX, gridY, other.gridX, other.gridY) <= other.MP)
			{
				enemyScore = 0;
				sight = other.SIGHT;
				with(obj_ally)
				{
					var dis = FindDistance(gridX, gridY, other.gridX, other.gridY);
					{
						if(dis <= other.sight)
						{
							other.enemyScore += other.sight - dis;
						}
					}
				}
				ds_priority_add(other.cells, id, enemyScore);
			}
		}
		if(ds_priority_size(cells) == 0)
		{
			NextTurn(id);
			state = "idle";
			break;
		}
		else
		{
			targetCell = ds_priority_find_min(cells);
			state = "find route";
		}
		
		ds_priority_destroy(cells);
		
		break;
	case "find target":
		targets = ds_priority_create();
		var gp = -1;
		if(object_get_parent(id) == obj_animals)
		{
			gp = obj_enemy;
		}
		if(gp == -1 || gp == obj_enemy)
		{
			with (obj_ally)
			{
				ds_priority_add(other.targets, id, HP)
			}
		}
		
		target = -1;
		var h = 9999, ex = 0;
		do
		{
			var ob = ds_priority_find_min(targets);
			var dis = FindDistance(gridX, gridY, ob.gridX, ob.gridY);
			if(dis <= h)
			{
				if(target == -1)
				{
					target = ob.id;
					h = dis;
				}
				else if(dis <= MP && h > MP)
				{
					target = ob.id;
					ex = 1;
				}
			}
			ds_priority_delete_min(targets);
		}until (ds_priority_empty(targets) || ex == 1);
		
		ds_priority_destroy(targets);
		
		if(target == -1)state = "run"; else
		state = "select action";
		break;
	case "select action":
		rangeType = 0;
		rangeDis = 1;
		

		state = "start move";
		break;
	case "start move":
	
			bestCells = ds_priority_create();
			
			var tc = global.map[target.gridX, target.gridY];
			
			switch(rangeType)
			{
				case 0:
					with(obj_node)
					{
						var di = FindDistance(other.target.gridX, other.target.gridY, gridX, gridY);
						var di2 = FindDistance(other.gridX, other.gridY, gridX, gridY);
						var same = 0;
						if(gridX == other.target.gridX && gridY == other.target.gridY)same = 1;
						if(passable == true && occupant == noone && same != 1 && di <= other.rangeDis && Vision(other.target.gridX, other.target.gridY, gridX, gridY) == 1)
						{
							ds_priority_add(other.bestCells, id, di2);
						}
					}
					break;
			}
			
			targetCell = ds_priority_find_min(bestCells);
			
			cellAttack = targetCell;
			
			
			
			ds_priority_destroy(bestCells);
			state = "find route";
		break;
	case "find route":
		CleanNodes();
		UpdateNodes(global.map[gridX, gridY], 99);
		
		moveCell = -1;

		current = global.map[targetCell.gridX, targetCell.gridY];
		
		if(current.parent != noone)
		{
			//show_message(current);
		
			while(current.parent != noone || moveCell != -1)
			{
				if(FindDistance(current.gridX, current.gridY, gridX, gridY) <= MP)
				{
					moveCell = current.id;
					break;
				}
				current = current.parent;
			
			}
			state = "select cell";
		}
		else
		{
			if(MP > 0)
			{
				state = "run";
				CleanNodes();
			}
			else
			{
				state = "idle";
				NextTurn(id);
				break;
			}
		}
		
		
		break;
		
	case "select cell":
		current = moveCell;

		path = ds_priority_create();

		ds_priority_add(path, current, current.G);
		
		while(current.parent != noone)
		{
			ds_priority_add(path, current.parent, current.parent.G);
			
			current = current.parent;
		}
		
		do{
			current = ds_priority_delete_min(path);
			
			path_add_point(movementPath, current.x, current.y, 100);
		} until(ds_priority_empty(path));
		
		ds_priority_destroy(path);
		
		global.map[gridX, gridY].occupant = noone;
		
		MP -= FindDistance(gridX, gridY, moveCell.gridX, moveCell.gridY);
		
		gridX = moveCell.gridX;
		gridY = moveCell.gridY;
		
		state = "begin path";
		
		global.map[gridX, gridY].occupant = id;
	
		CleanNodes();
		
		break;
		
	case "begin path":
		path_start(movementPath, moveSpeed, 0, true);
		global.unitMoving = 1;
		
		state = "moving";
		break;
	case "start attack":
		if(AP >= 3)
		{
			instance_create_layer(target.x + global.gridSize / 2, target.y, "base", obj_number);
			state = "idle";
			AP -= 3;
		}
		if(AP <= 0)
		{
			state = "idle";
			break;
		}
		
		CleanNodes();
		
		break;
}
