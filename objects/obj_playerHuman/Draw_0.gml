/// @description Insert description here
// You can write your code in this editor
if(global.unitMoving == 0 && global.selectedActor == id && global.hoverNode != noone && global.hoverNode != global.map[gridX, gridY])
{
	current = global.hoverNode;
	while(current.parent != noone)
	{

		draw_sprite_ext(spr_grid32, 0, current.x, global.gridSize + current.y - global.gridSize, 1, 1, 0, make_color_rgb(255, 160, 40), 0.3);
		current = current.parent;
	}
}

draw_sprite_ext(SPRITE, 0, x + global.gridSize / 2, y + global.gridSize / 2, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
