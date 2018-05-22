/// @description Insert description here
// You can write your code in this editor
global.nRooms = 5;

global.xStart = floor(random(10));
global.yStart = floor(random(10));

global.floorWidth = 10;
global.floorHeight = 10;

global.roomWidth = 640;
global.roomHeight = 352;

global.botLayer = layer_create(100);
global.midLayer = layer_create(0);
global.topLayer = layer_create(-100);

for(xx = 0; xx < global.floorWidth; xx ++)
{
	for(yy = 0; yy < global.floorHeight; yy ++)
	{
		global.floorRoom[xx, yy] = instance_create_layer(xx * global.roomWidth, yy * global.roomHeight, "back", obj_room);
		var rm = global.floorRoom[xx, yy];
	}
}