/// @description Insert description here
// You can write your code in this editor
global.gridSize = 32;
room_speed = 60;
display_set_gui_size(640, 360);


global.mapWidth = 1280/global.gridSize;
global.mapHeight = 720/global.gridSize;
global.hoverNode = noone;
lastHover = -1;

global.selectedActor = noone;
global.cturn = 0;
global.unitMoving = 0;

global.turns = ds_list_create();

state = 0;

for(xx = 0; xx < global.mapWidth; xx ++)
{
	for(yy = 0; yy < global.mapHeight; yy ++)
	{
		global.map[xx, yy] = instance_create_layer(xx * global.gridSize, yy * global.gridSize, "back", obj_node);
	}
}

//populate neighbor lists!
for(xx = 0; xx < global.mapWidth; xx += 1)
{
	for(yy = 0; yy < global.mapHeight; yy += 1)
	{
			
		node = global.map[xx, yy];
		node.gridX = xx;
		node.gridY = yy;

		//add left neighbor
		if(xx > 0)
		{
			ds_list_add(node.neighbors, global.map[xx - 1, yy]);
		}

		//add right neighbor
		if(xx < global.mapWidth - 1)
		{
			ds_list_add(node.neighbors, global.map[xx + 1, yy]);
		}

		//add top neighbor
		if(yy > 0)
		{
			ds_list_add(node.neighbors, global.map[xx, yy - 1]);
		}

		//add bottom neighbor
		if(yy < global.mapHeight - 1)
		{
			ds_list_add(node.neighbors, global.map[xx, yy + 1]);
		}
	}
}


with instance_create_layer(12 * global.gridSize, 6 * global.gridSize, "base", obj_bunny)
{
	gridX = floor(x / global.gridSize);
	gridY = floor(y / global.gridSize);
	global.map[gridX, gridY].occupant = id;
}
with instance_create_layer(12 * global.gridSize, 5 * global.gridSize, "base", obj_bunny)
{
	gridX = floor(x / global.gridSize);
	gridY = floor(y / global.gridSize);
	global.map[gridX, gridY].occupant = id;
}
with instance_create_layer(12 * global.gridSize, 4 * global.gridSize, "base", obj_bunny)
{
	gridX = floor(x / global.gridSize);
	gridY = floor(y / global.gridSize);
	global.map[gridX, gridY].occupant = id;
}
with instance_create_layer(4 * global.gridSize, 6 * global.gridSize, "base", obj_playerHuman)
{
	gridX = floor(x / global.gridSize);
	gridY = floor(y / global.gridSize);
	global.map[gridX, gridY].occupant = id;
	global.thisPlayer = id;
	lead = global.thisPlayer;
}

instance_create_layer(0, 0, "back", obj_camera);

with (obj_unit)
{
	ds_list_add(global.turns, INI);
}

ds_list_sort(global.turns, false);

global.units = ds_list_create();

for(var i = 0; i < ds_list_size(global.turns); i ++)
{
	with (obj_unit)
	{
		if(INI == ds_list_find_value(global.turns, i))
		{
			ds_list_add(global.units, id);
			ds_list_delete(global.turns, i);
		}
	}
}


global.turnbarX = 32;
global.turnbarY = 32;