/// @description 초기화
application_surface_enable(true)
application_surface_draw_enable(false)
device_mouse_dbclick_enable(false)

global.client = {
	width: 960,
	height: 640,
	
	game_width: 960,
	game_height: 480,

	panel_width: 960,
	panel_height: 150,

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
global.speed_interpolation = 1 / sqrt(2)

global.playerpos = [0, 0]
global.playerpos_visible = [0, 0]

global.__function_null = function() {}
#macro FUNC_NULL global.__function_null
global.skills = {
	database: ds_map_create()
}

global.__lengthdir_cashed = array_create(361, [0, 0])
for (var i = 0; i <= 360; ++i) {
	global.__lengthdir_cashed[i][0] = lengthdir_x(1, i)
	global.__lengthdir_cashed[i][1] = lengthdir_y(1, i)
}

event_user(0)
event_user(1)

global.__entity_list = ds_list_create()
global.__entity_db = ds_map_create()
event_user(2)

alarm[0] = 1
