/// @description 메뉴 항목 생성
entry_title = add_sprite(sTitle)
entry_start = add_entry("Campaign")
entry_log = add_entry("Logs")
entry_setting = add_entry("Setting")
entry_exit = add_entry("Exit")
focus(entry_start)
init()

with entry_title {
	height = global.menu_title_height
	scale = 0.7
}

with entry_start {
	add_header("- Select your profile -")
	for (var i = 0; i < 3; ++i) {
		var profile = new MainEntryCampaign("Profile " + string(i + 1))
		with profile {
			add_text("Stage Level")
		}
		add_general(profile)
	}
	add_entry("Back", "", menu_goto_back)

	predicate = function() {
		focus(child_first)
	}
}

with entry_log {
	add_header("Logs")
	with add_space(0, global.menu_title_height) {
		
	}
	add_entry("Back", "", menu_goto_back)

	predicate = function() {
		focus(child_last)
	}
}

with entry_setting {
	add_header("Controls")
	add_text("Does not supported now")
	add_entry("Keyboard", "")
	add_entry("Gamepad", "")
	add_separator()
	add_header("Sounds")
	with add_setting_indicator("BGM Volume", "volume_bgm", callback_indicator_off) {
		add_header("BGM Volume")
		for (var i = 0; i < 11; ++i) {
			with add_option(callback_indicator_off(i), global.settings.set_bgm) {
				index = i
			}
			if child_last.index == global.settings.get_bgm()
				focus(child_last)
		}
		add_entry("Back", "", menu_goto_back)
		if child_focused == -1 or
		(child_focused != -1 and !child_focused.focusable) {
			focus(child_last)
		}
	}
	with add_setting_indicator("SFX Volume", "volume_sfx", callback_indicator_off) {
		add_header("SFX Volume")
		for (var i = 0; i < 11; ++i) {
			with add_option(callback_indicator_off(i), global.settings.set_sfx) {
				index = i
			}
			if child_last.index == global.settings.get_sfx()
				focus(child_last)
		}
		add_entry("Back", "", menu_goto_back)
		if child_focused == -1 or
		(child_focused != -1 and !child_focused.focusable) {
			focus(child_last)
		}
	}
	add_separator()
	add_header("Graphics")
	add_setting_indicator("Fullscreen", "fullscreen", callback_indicator_flags)
	add_setting_indicator("Screenshake", "screenshake", callback_indicator_flags)
	add_separator()
	add_entry("Back", "", menu_goto_back)

	predicate = function() {
		focus(child_first)
	}
}

with entry_exit {
	with add_space(0, global.menu_title_height) {
		
	}
	add_text("Are you sure to exit?")
	add_entry("Yes", "", function() {
		with global.main_menu
			mode_change(mode_exit)
	})
	add_entry("No", "", menu_goto_back)

	predicate = function() {
		focus(child_last)
	}
}
