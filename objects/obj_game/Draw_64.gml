/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_white);
//if(global.hoverNode != noone)draw_sprite_ext(spr_grid32, 0, global.hoverNode.gridX * global.gridSize, global.hoverNode.gridY * global.gridSize, 1, 1, image_angle, c_blue, 0.2);

draw_set_font(font2);
draw_text(12, 12, "hello");

for(var i = 0; i < ds_list_size(global.units); i ++)
{
	draw_sprite(obj_turnbar, 0, i * 36 + global.turnbarX, global.turnbarY);
	
	var obj = ds_list_find_value(global.units, i);
	var spr = obj.SPRITE;
	
	var scale = 48 / max(sprite_get_width(spr), sprite_get_height(spr));
	
	draw_sprite_ext(spr, 0, global.gridSize / 2 + i * 36 + global.turnbarX, sprite_get_yoffset(spr) + global.turnbarY, scale, scale, 0, obj.image_blend, obj.image_alpha);
	var col = make_color_rgb(55, 255, 55);
	if(object_get_parent(obj) == obj_enemy)col = make_color_rgb(200, 0, 0);
	
	draw_healthbar(i * 36 + global.turnbarX + 2, global.turnbarY + 38,  i * 36 + global.turnbarX + 29,global.turnbarY + 40, obj.HP * 100 / obj.MAXHP, c_black, col, col, 0, 1, 1);
}

//draw_text(12, 12, global.thisPlayer);