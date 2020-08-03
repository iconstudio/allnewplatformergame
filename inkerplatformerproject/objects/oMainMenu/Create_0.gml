/// @description 주 메뉴 초기화
event_user(10)

group_main = new MenuGroup()
entry_campaign = new MenuCaption("Campaign", "Play the story mode.")
entry_log = new MenuCaption("Log", "View the played log.")
entry_setting = new MenuCaption("Setting", "Options for game.")
entry_exit = new MenuCaption("Exit", "End the game.")
group_main.add(entry_campaign).add(entry_log).add(entry_setting).add(entry_exit)

group_campaign = new MenuGroup()
group_campaign.set_parent(group_main)
group_campaign.add(new MenuCaption("Start", "Start the single game."))
group_campaign.add(new MenuCaption("Back", ""))

group_log = new MenuGroup()
group_log.set_parent(group_main)
group_campaign.add(new MenuCaption("Start", "Start the single game."))
group_campaign.add(new MenuCaption("Back", ""))

group_setting = new MenuGroup()
group_setting.set_parent(group_main)
group_campaign.add(new MenuCaption("Start", "Start the single game."))
group_campaign.add(new MenuCaption("Back", ""))

group_exit = new MenuGroup()
group_exit.set_parent(group_main)
group_campaign.add(new MenuCaption("Yes", "Start the single game."))
group_campaign.add(new MenuCaption("No", ""))

menu_before = group_main
menu_current = group_main

function select_group(group) {
	menu_before = menu_current
	menu_current = group
}

function select_item(entry) {
	
}

function select_next_item() {
	
}

function select_before_item() {
	
}
