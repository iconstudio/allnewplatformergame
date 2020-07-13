/// @description 초기화
application_surface_enable(true)
application_surface_draw_enable(false)
device_mouse_dbclick_enable(false)

global.client = {
	width: 960,
	height: 608,
	
	game_width: 960,
	game_height: 480,

	view_width: 480,
	view_height: 240,

	border: 5
}

window_set_size(global.client.width, global.client.height)
surface_resize(application_surface, global.client.game_width, global.client.game_height)
//display_set_gui_size(global.client.width, global.client.height)

#macro NONE -1
#macro LEFT 0
#macro RIGHT 2
#macro UP 1
#macro DOWN 3

global.timescale = 1.00

global.gravity_normal = 20 / seconds(1)
global.friction_air = 5 / seconds(1)
global.friction_ground = 95 / seconds(1)
global.yvel_max = 256 / seconds(1)

global.skills = {
	database: ds_map_create()
}

enum entity_state {
	normal = 0,
	stunned = 90,
	dead
}


alarm[0] = 1
