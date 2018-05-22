CleanNodes();

//argument0 = origin node
//argument1 = range


var open, closed;
var start, current, neighbor;
var tempG, range;

start = argument0;
range = argument1;

open = ds_priority_create();
closed = ds_list_create();

ds_priority_add(open, start, start.G);

while(ds_priority_size(open) > 0)
{
	
	current = ds_priority_delete_min(open);
	
	ds_list_add(closed, current);
	
	for(i = 0; i < ds_list_size(current.neighbors); i ++)
	{
		neighbor = ds_list_find_value(current.neighbors, i);
		
		if(ds_list_find_index(closed, neighbor) < 0 && neighbor.passable && neighbor.occupant == noone && neighbor.cost + current.G <= range)
		{
			if(ds_priority_find_priority(open, neighbor) == 0 || ds_priority_find_priority(open, neighbor) == undefined)
			{
				neighbor.parent = current;
				
				neighbor.G = current.G + neighbor.cost;
			
				ds_priority_add(open, neighbor, neighbor.G);
			}
			else
			{
				tempG = current.G + neighbor.cost;
				if(tempG < neighbor.G)
				{
					neighbor.parent = current;
				
					neighbor.G = tempG;
					ds_priority_change_priority(open, neighbor, neighbor.G)
				}
			}
		}
	}
}

ds_priority_destroy(open);

for(i = 0; i < ds_list_size(closed); i ++)
{
	current = ds_list_find_value(closed, i);
	current.moveNode = true;
	current.color = c_aqua;
}

ds_list_destroy(closed);
