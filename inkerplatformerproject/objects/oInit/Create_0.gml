/// @description 초기화
// GRIEF
// Doou'hl
global.file_saves = "data"
global.flag_debug = false
global.flag_is_mobile = (os_type == os_android or os_type == os_ios) // 하지만 안드로이드만 지원
global.flag_is_browser = (os_browser != browser_not_a_browser)
global.flag_is_desktop = !global.flag_is_browser and (os_type == os_windows or os_type == os_macosx or os_type == os_linux)

device_mouse_dbclick_enable(false)
application_surface_enable(true)
application_surface_draw_enable(false)
display_reset(0, false)
display_set_timing_method(tm_countvsyncs)
gpu_set_ztestenable(true)
gpu_set_zwriteenable(true)

var dw = display_get_width()
global.aspect = 1 / 2
global.resolution = {
	display_width: dw,
	display_height: display_get_height(),
	display_height_biased: floor(dw * global.aspect),

	width: 960,
	height: 720,

	view_width: 480,
	view_height: 360,

	border: 5,
	
	update: function() { display_set_gui_maximize() }
}
window_set_min_width(global.resolution.width)
window_set_min_height(global.resolution.height)
//window_set_size(global.resolution.width, global.resolution.height)
//surface_resize(application_surface, global.resolution.game_width, global.resolution.game_height)

global.settings = new MainSetting()
global.settings.init()

global.setting_control_keyboard = {
	
}

global.setting_control_gamepad = {
	
}

#macro SECOND 100 // seconds(1)
#macro NONE -1
#macro LEFT 0
#macro RIGHT 2
#macro UP 1
#macro DOWN 3
#macro HORIZONTAL 0
#macro VERTICAL 2

global.timescale = 1.00

global.gravity_normal = 20 / SECOND
global.friction_air = 5 / SECOND
global.friction_ground = 95 / SECOND
global.yvel_max = 256 / SECOND
global.speed_interpolation = 1 / sqrt(2)
global.speed_bounced_x = 60 / SECOND
global.speed_bounced_y = 80 / SECOND
global.speed_debri_bounced = 100 / SECOND


global.playerid = noone
global.playerpos = [0, 0]
global.playerpos_visible = [0, 0]

global.inventory_item_preset = function() constructor {
	
}

global.inventory_item = function() constructor {
	
}

global.inventory = new (function() constructor {
	opened = false
	
	/*
			가방은 총 6칸
			4칸의 일반 인벤토리
			2칸의 특수 인벤토리
				1. 퀘스트
				2. 룬
			
			그 외 착용 아이템도 존재한다.
	*/
	number = 6
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
if !audio_group_is_loaded(audio_bgm) {
	audio_group_load(audio_bgm)
	audio_loaded = false
}

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
