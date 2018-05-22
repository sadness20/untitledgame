/// @description Insert description here
// You can write your code in this editor

var xpos = (camera_get_view_width(view_camera[0]) - 381) / 2;
var ypos = camera_get_view_height(view_camera[0]) - 55;

if(global.currentBackground != -1)
{
	draw_sprite(global.currentBackground, 0, 0, 0);
}

if(global.dialogue != -1)
{
	draw_sprite(spr_dialogue, 0, xpos, ypos)
	
	draw_set_font(font2);
	draw_set_color(make_color_rgb(68, 51, 31));
	draw_text_ext(xpos + 28, ypos - 2, "You compliment me left and right You compliment me left and right. ", 18, 320);
}
