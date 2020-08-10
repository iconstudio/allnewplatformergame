/// @description 주 메뉴 초기화
global.main_menu = id
center_x = global.client.width * 0.5
center_y = global.client.height * 0.5
x = center_x
y = global.client.height * 0.14

key_pick = RIGHT
key_duration_pick = seconds(0.4)
key_duration_continue = seconds(0.12)
key_tick = new Countdown()

event_user(10)

entry_title = new MenuSprite(sTitle)
add_general(entry_title)
entry_start = add("Campaign", "aa")
entry_log = add("Log", "aa")
entry_setting = add("Setting", "aa")
entry_exit = add("Exit", "aa")
focus(entry_start)
init()

with entry_title {
	height = global.menu_title_height
}

with entry_start {
	add("Start", "")
	add("Back", "")
	focus(child_first)
}

with entry_log {
	add("TEST", "")
	add("Back", "")
	focus(child_last)
}

with entry_setting {
	add("TEST", "")
	add("Back", "")
	focus(child_last)
}

with entry_exit {
	add("Yes", "")
	add("No", "")
	focus(child_last)
}
