
function Setting(filepath) constructor {
	file = filepath
	options = ds_map_create()

	function init() {
		if !import() {
			make_default()
			export()
		}
		if !ds_exists(options, ds_type_map)
			throw "Cannot create a map!"
	}

	function make_default() {}

	function import() {
		if !file_exists(file) {
			return false
		}

		try {
			var source = file_text_open_read(file)
			var content = file_text_read_string(source)
			var result = json_decode(content)
			ds_map_copy(options, result)
			file_text_close(source)

			if !ds_exists(options, ds_type_map) or ds_map_size(options) == 0 {
				file_delete(file)
				return false
			} else {
				return true
			}
		} catch (e) {
			throw e + "\nUnexpected Error occured when importing settings."
		}
	}

	function export() {
		var target = file_text_open_write(file)
		var mapped = json_encode(options)
		file_text_write_string(target, mapped)
		file_text_close(target)
	}

	function set(variable_name, value) {
		ds_map_set(options, variable_name, value)
	}

	function get(variable_name) {
		return ds_map_find_value(options, variable_name)
	}
}

function MainSetting(): Setting("setting.json") constructor {
	function make_default() {
		set_bgm(7)
		set_sfx(10)
		set_fullscreen(false)
		set_screen_shake(true)
	}

	///@function set_bgm(value)
	function set_bgm(value) {
		ds_map_set(options, "volume_bgm", value)
		audio_set_gain_bgm(value / 10)
	}

	///@function set_sfx(value)
	function set_sfx(value) {
		ds_map_set(options, "volume_sfx", value)
		audio_set_gain_sfx(value / 10)
	}

	///@function get_bgm()
	function get_bgm() {
		return get("volume_bgm")
	}

	///@function get_sfx()
	function get_sfx() {
		return get("volume_sfx")
	}

	///@function set_fullscreen(flag)
	function set_fullscreen(flag) {
		ds_map_set(options, "fullscreen", bool(flag))
		if global.flag_is_desktop {
			window_set_fullscreen(flag)
			global.resolution.update()
		}
	}

	///@function get_fullscreen()
	function get_fullscreen() {
		return get("fullscreen")
	}

	///@function set_screen_shake(flag)
	function set_screen_shake(flag) {
		ds_map_set(options, "screenshake", bool(flag))
	}

	///@function get_screen_shake()
	function get_screen_shake() {
		return get("screenshake")
	}
}
