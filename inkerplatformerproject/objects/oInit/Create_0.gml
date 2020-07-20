/// @description 초기화
global.flag_debug = false
global.flag_is_mobile = (os_type == os_android or os_type == os_ios) // 하지만 안드로이드만 지원
global.flag_is_browser = (os_browser != browser_not_a_browser)
global.flag_is_desktop = (os_type == os_windows or os_type == os_macosx or os_type == os_linux) and !global.flag_is_browser

application_surface_enable(true)
application_surface_draw_enable(false)
device_mouse_dbclick_enable(false)

display_reset(0, false)
display_set_timing_method(tm_countvsyncs)
gpu_set_ztestenable(true)
gpu_set_zwriteenable(true)

if global.flag_is_mobile {
	window_set_fullscreen(true)
	os_powersave_enable(false)
}
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

audio_loaded = true
if global.flag_is_mobile {
	audio_channel_num(16)
} else if global.flag_is_browser {
	audio_channel_num(4)
} else {
	audio_channel_num(32)
}
//if !audio_group_is_loaded(audiogroup_everthing) {
//	audio_group_load(audiogroup_everthing)
//	audio_loaded = false
//}

global.shader_supported = shaders_are_supported()
if !global.shader_supported {
	throw "Shaders are not supported on this device."
}

alarm[0] = 1
