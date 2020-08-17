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
	var gamemenu = new MenuItem()
	with gamemenu {
		width = global.menu_width
		height = global.menu_title_height
		focusable = true
		openable = false
		add_entry("Chapter 1", "")
		add_entry("Chapter 2", "")
		add_entry("Chapter 3", "")
		add_entry("Chapter 4", "")
		focus(child_first)

		///@function draw_me(x, y)
		function draw_me(dx, dy) {
			var oalpha = draw_get_alpha()
			draw_set_alpha(oalpha * 0.3)
			//draw_set_color(0)
			draw_set_color($ffffff)
			draw_rectangle(0, dy, width, dy + height, false)
			if 0 < number {
				var temp = []
				for (var i = 0; i < number; ++i) {
					temp = get_child(i).draw(dx, dy)
					dx += 100
				}
			}

			draw_set_alpha(oalpha)
			draw_set_color($ffffff)
			return [0, height + global.menu_caption_height]
		}
	}
	add_general(gamemenu)
	add_separator()
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
	add_separator()
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
	add_setting_option("SFX Volume", "volume_sfx", callback_indicator_off)
	add_setting_option("BGM Volume", "volume_bgm", callback_indicator_off)
	add_separator()
	add_header("Graphics")
	add_setting_option("Fullscreen", "fullscreen", callback_indicator_flags)
	add_setting_option("Screenshake", "screenshake", callback_indicator_flags)
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
	add_separator()
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
