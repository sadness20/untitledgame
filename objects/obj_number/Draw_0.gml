/// @description Insert description here
// You can write your code in this editor
draw_set_halign(fa_center);
draw_set_color(c_red);
draw_set_alpha(alpha / 100);

draw_set_font(ft_damage);
draw_text(x, y, string(num));

draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_alpha(1);