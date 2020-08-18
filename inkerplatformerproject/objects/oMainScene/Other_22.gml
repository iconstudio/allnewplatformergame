/// @description 메뉴 항목 생성
entry_title = add_sprite(sTitle)
entry_start = add_entry("Campaign", "aa")
entry_log = add_entry("Logs", "aa")
entry_setting = add_entry("Setting", "aa")
entry_exit = add_entry("Exit", "aa")
focus(entry_start)
init()

with entry_title {
	height = global.menu_title_height
	scale = 0.7
}

with entry_start {
	add_header("Campaign")
	var gamemenu = new MainEntryCampaign()
	with gamemenu {
		var number = chapter_get_number()
		for (var i = 0; i < number; ++i) {
			var ch = chapter_get(i)
			add_entry(string(i + 1))
			
			//if !is_undefined(ch) and ch != -1 {
			//	add_entry("Chapter " + string(i + 1), ch.title)
			//}
		}
		child_first.before = -1
		child_last.next = -1
		focus(child_first)
	}
	add_general(gamemenu)
	add_text("Stage Level")
	add_entry("Back", "", menu_goto_back)
	child_first.before = -1
	child_last.next = -1

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
		add_space(0, global.menu_title_height)
		add_entry("Back", "", menu_goto_back)
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
