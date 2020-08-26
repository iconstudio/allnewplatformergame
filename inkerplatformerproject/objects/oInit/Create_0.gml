/// @description 초기화

// GRIEF
// Doou'hl

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

global.settings = {
	control_modified_keyboard: false,
	control_modified_gamepad: false,
	volume_sfx: 10,
	volume_bgm: 7,
	fullscreen: false,
	screenshake: true,

	///@function set_bgm(value)
	set_bgm: function(value) {
		global.settings.volume_bgm = value
		audio_set_gain_bgm(global.settings.volume_bgm / 10)
	},

	///@function set_sfx(value)
	set_sfx: function(value) {
		global.settings.volume_sfx = value
		audio_set_gain_sfx(global.settings.volume_sfx / 10)
	},

	///@function get_bgm()
	get_bgm: function() {
		return global.settings.volume_bgm
	},

	///@function get_sfx()
	get_sfx: function() {
		return global.settings.volume_sfx
	},

	///@function set_fullscreen(flag)
	set_fullscreen: function(flag) {
		global.settings.fullscreen = flag
		if global.flag_is_desktop {
			window_set_fullscreen(flag)
			global.resolution.update()
		}
	},

	///@function get_fullscreen()
	get_fullscreen: function() {
		return global.settings.fullscreen
	},

	///@function set_screen_shake(flag)
	set_screen_shake: function(flag) {
		global.settings.screenshake = flag
	},

	///@function get_screen_shake()
	get_screen_shake: function() {
		return global.settings.screenshake
	},
}

global.setting_control_keyboard = {
	
}

global.setting_control_gamepad = {
	
}

global.aspect = 2 / 3

var dw = display_get_width()
global.resolution = {
	display_width: dw,
	display_height: display_get_height(),
	display_height_biased: floor(dw * global.aspect),

	width: 960,
	height: 640,

	game_width: 960,
	game_height: 480,

	panel_width: 960,
	panel_height: 150,

	view_width: 480,
	view_height: 240,

	border: 5,
	
	update: function() {
		if !global.flag_is_desktop
			exit

		if window_get_fullscreen() {
			display_set_gui_maximize(self.display_width / self.width, self.display_height_biased / self.height)
		} else {
			var cw = window_get_width()
			//var ch = window_get_height()
			var ch_biased = floor(cw * global.aspect)
			display_set_gui_maximize(cw / self.width, ch_biased / self.height)
		}

			//self.width = display_get_gui_width() //960
			//self.height = display_get_gui_height() //640
	},
}
	
window_set_min_width(global.resolution.width)
window_set_min_height(global.resolution.height)

window_set_size(global.resolution.width, global.resolution.height)
surface_resize(application_surface, global.resolution.game_width, global.resolution.game_height)

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
global.speed_debri_bounced = 100 / seconds(1)

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
