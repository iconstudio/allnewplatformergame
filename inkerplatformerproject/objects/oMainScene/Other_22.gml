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
		add_entry("Chapter 1", "")
		add_entry("Chapter 2", "")
		add_entry("Chapter 3", "")
		add_entry("Chapter 4", "")
		focus(child_first)
	}
	add_general(gamemenu)
	add_entry("Back", "", menu_goto_back)

	sidekey_predicate = function(input) {
		
	}

	focus(child_first)
	predicate = function() {
		focus(child_first)
	}
}

with entry_log {
	add_header("Logs")
	with add_space(0, global.menu_title_height) {
		
	}
	add_entry("Back", "", menu_goto_back)

	focus(child_last)
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
	add_option("SFX Volume", "volume_sfx", callback_indicator_off)
	add_option("BGM Volume", "volume_bgm", callback_indicator_off)
	add_separator()
	add_header("Graphics")
	add_option("Fullscreen", "fullscreen", callback_indicator_flags)
	add_option("Screenshake", "screenshake", callback_indicator_flags)
	add_separator()
	add_entry("Back", "", menu_goto_back)

	focus(child_first)
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

	focus(child_last)
	predicate = function() {
		focus(child_last)
	}
}
