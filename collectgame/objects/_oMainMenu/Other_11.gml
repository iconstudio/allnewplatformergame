/// @description Init the menu
menu_raw = [
	["Start", undefined, [
		
	]],

	["Journey", undefined, [
		
	]],

	["Setting", undefined, [
		
	]],

	["Exit", undefined, [
		
	]]
]

/*
var cx = 0
menu_start = new MainMenuSlideshow("Start", -1, cx, MAIN_MENU_Y, true)
with menu_start {
	open = function() { // skip the buttons
		open_phase = 2
		draw_phase = 5
		Qui_open(self)
		focus()
	}
}
Qui_awake(global.qui_master, menu_start)

// display the profiles
var MainContents = new MainMenuInnerPage(menu_start)
with MainContents {
	
}
Qui_awake(global.qui_master, MainContents)
cx += MAIN_MENU_W

menu_log = new MainMenuSlideshow("Journey", -1, cx, MAIN_MENU_Y, true)
with menu_log {
	
}
Qui_awake(global.qui_master, menu_log)

// display the jorney and achievements and playlog
MainContents = new MainMenuInnerPage(menu_log)
with MainContents {
	
}
Qui_awake(global.qui_master, MainContents)
cx += MAIN_MENU_W

menu_setting = new MainMenuSlideshow("Setting", -1, cx, MAIN_MENU_Y, true)
with menu_setting {
	open_direction = LEFT
}
Qui_awake(global.qui_master, menu_setting)

// display options
MainContents = new MainMenuInnerPage(menu_setting)
with MainContents {
	
}
Qui_awake(global.qui_master, MainContents)
cx += MAIN_MENU_W

// does not have contents, only have 2 options
menu_quit = new MainMenuSlideshow("Exit", -1, cx, MAIN_MENU_Y, false)
with menu_quit {
	open_direction = LEFT
	add_entry(new MainMenuSlideButton("Yes", function() {
		with global.main_menu_id {
			mode = QUI_STATES.CLOSING
		}
	})).make_then(new MainMenuSlideButton("No", function() {
		with global.main_menu_id {
			Qui_close(menu_quit)
			menu_quit.open_phase = 0
		}
	}))
}
Qui_awake(global.qui_master, menu_quit)
cx += MAIN_MENU_W

menu_start.focus()
menu_start.brother_before = undefined
menu_quit.brother_next = undefined
