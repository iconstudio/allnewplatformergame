/// @description 메뉴 속성 선언
global.main_menu = id
group_main = new MenuGroup()
menu_before = group_main
menu_current = group_main
push = 0
push_previous = 0

function select_group(group) {
	menu_before = menu_current
	menu_current = group
}

function menu_back() {
	
}

entry_campaign = new MenuCaption("Campaign", "Play the story mode.", function() {
	global.main_menu.menu_back()
})
entry_log = new MenuCaption("Log", "View the played log.")
entry_setting = new MenuCaption("Setting", "Options for game.")
entry_exit = new MenuCaption("Exit", "End the game.")
group_main.add(entry_campaign).add(entry_log).add(entry_setting).add(entry_exit)
group_main.focus_item(entry_campaign)

group_campaign = new MenuGroup(group_main)
with group_campaign {
	add_caption("Start", "Start the game.")
	add_caption("Back", "")
	focus_item(first)
}

group_log = new MenuGroup(group_main)
with group_log {
	add_caption("LOG", "")
	add_caption("Back", "")
	focus_item(last)
}

group_setting = new MenuGroup(group_main)
with group_setting {
	add_caption("Start", "Start the single game.")
	add_caption("Back", "")
	focus_item(first)
}

group_exit = new MenuGroup(group_main)
with group_exit {
	add_caption("Yes", "Start the single game.")
	add_caption("No", "")
	focus_item(last)
}

function select_item(entry) {
	
}

function select_next_item() {
	
}

function select_before_item() {
	
}


