/// @description 초기화

// GRIEF
// Doou'hl

global.flag_debug = false
global.flag_is_mobile = (os_type == os_android or os_type == os_ios) // 하지만 안드로이드만 지원
global.flag_is_browser = (os_browser != browser_not_a_browser)
global.flag_is_desktop = (os_type == os_windows or os_type == os_macosx or os_type == os_linux) and !global.flag_is_browser

device_mouse_dbclick_enable(false)
application_surface_enable(true)
application_surface_draw_enable(false)
display_reset(0, false)
display_set_timing_method(tm_countvsyncs)
gpu_set_ztestenable(true)
gpu_set_zwriteenable(true)

global.settings = {
	control_modified_keyboard: false,
	control_modified_gamepad: false,
	volume_sfx: 10,
	volume_bgm: 7,
	fullscreen: false,
	screenshake: true,
	
	set_bgm: function(value) {
		global.settings.volume_bgm = value
	},

	set_sfx: function(value) {
		global.settings.volume_sfx = value
	},

	get_bgm: function() {
		return global.settings.volume_bgm
	},

	get_sfx: function() {
		return global.settings.volume_sfx
	},
}

global.setting_control_keyboard = {
	
}

global.setting_control_gamepad = {
	
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
#macro HORIZONTAL 0
#macro VERTICAL 2

global.timescale = 1.00

global.gravity_normal = 20 / seconds(1)
global.friction_air = 5 / seconds(1)
global.friction_ground = 95 / seconds(1)
global.yvel_max = 256 / seconds(1)
global.speed_interpolation = 1 / sqrt(2)

global.playerid = noone
global.playerpos = [0, 0]
global.playerpos_visible = [0, 0]

global.inventory_item_preset = function() constructor {
	
}

global.inventory_item = (function() constructor {
	
})

global.inventory = new (function() constructor {
	opened = false
	
	/*
		GUI에 표시됨 (터치 가능)
			첫번째 칸은 무기
			두번째 칸은 장비 혹은 소모품
			세번째 칸은 장비 혹은 소모품
			네번째 칸은 장비 혹은 소모품
			다섯번째 칸은 장비 혹은 소모품
			여섯번째 칸은 장비 혹은 소모품

		인벤토리를 열어야 보임
			다음 여덟칸은 가방
	*/
	number = 6 + 8
	datas = array_create(number, noone)
})()

global.__function_null = function() {}
#macro FUNC_NULL global.__function_null

global.__lengthdir_cashed = array_create(361, [0, 0])
for (var i = 0; i <= 360; ++i) {
	global.__lengthdir_cashed[i][0] = lengthdir_x(1, i)
	global.__lengthdir_cashed[i][1] = lengthdir_y(1, i)
}

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

event_user(0)
event_user(1)

global.__entity_list = ds_list_create()
global.__entity_db = ds_map_create()
event_user(2)
event_user(3)

event_user(4)

alarm[0] = 1
