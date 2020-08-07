/// @description 메뉴 속성 선언
global.main_menu = id

group_main = new MenuGroup()
menu_before = group_main
menu_current = group_main
push = (new Countdown()).set(1)
push_predicate = global.ease.linear

function select_group(group) {
	menu_before = menu_current
	menu_current = group
}

function menu_back() {
	select_group(menu_before)
}

title = new MenuEntry()
title.draw = function() {
	return global.menu_title_height
}

entry_campaign = new MenuCaption("Campaign", "Play the story mode.", function() {
	select_group(group_campaign)
})
entry_log = new MenuCaption("Log", "View the played log.", function() {
	select_group(group_log)
})
entry_setting = new MenuCaption("Setting", "Options for game.", function() {
	select_group(group_setting)
})
entry_exit = new MenuCaption("Exit", "End the game.", function() {
	select_group(group_exit)
})
group_main.add(title).add(entry_campaign).add(entry_log).add(entry_setting).add(entry_exit)
group_main.focus_item(entry_campaign)

group_campaign = new MenuGroup(group_main)
with group_campaign {
	add_caption("Start", "Start the game.", -1)
	add_caption("Back", "", other.menu_back)
	focus_item(first)
}

group_log = new MenuGroup(group_main)
with group_log {
	add_caption("LOG", "", -1)
	add_caption("Back", "", other.menu_back)
	focus_item(last)
}

group_setting = new MenuGroup(group_main)
with group_setting {
	add_caption("Start", "Start the single game.", -1)
	add_caption("Back", "", other.menu_back)
	focus_item(first)
}

group_exit = new MenuGroup(group_main)
with group_exit {
	add_caption("Yes", "Start the single game.", -1)
	add_caption("No", "", other.menu_back)
	focus_item(last)
}

function select_item(entry) {
	
}

function select_next_item() {
	
}

function select_before_item() {
	
}


