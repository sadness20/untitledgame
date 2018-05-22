/// @description Insert description here
// You can write your code in this editor
draw_set_alpha(0.1);
for(var i = 0; i < global.mapWidth; i += 1)
{
	draw_line(i * global.gridSize, 0, i * global.gridSize, global.mapHeight * global.gridSize);
}
for(var i = 0; i < global.mapHeight; i += 1)
{
	draw_line(0, i * global.gridSize, global.mapWidth * global.gridSize, i * global.gridSize);
}

draw_set_alpha(1);
