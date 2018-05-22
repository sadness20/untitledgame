/// @description Insert description here
// You can write your code in this editor

//Enable the use of views
global.zoom = 2;

view_enabled = true;

//Make view 0 visible
view_set_visible(0, true);

var wid = 1280;
var hei = 720;



global.camera = camera_create_view(0, 0, wid / global.zoom, hei / global.zoom, 0, -1, -1, -1, 32, 32);

camera_set_view_pos(global.camera, 0, 0);


//Setting up object target information
camera_set_view_target(global.camera, obj_playerHuman);
camera_set_view_speed(global.camera, -1, -1);
camera_set_view_border(global.camera, wid, hei);

view_set_camera(0, global.camera);