/// @description Initialization
global.main_menu_id = id

event_user(0)
event_user(1)
event_user(2)

menu_raw = [
	["Start"],
	["Journey"],
	["Setting"],
	["Exit"],
]
menu_count = array_length(menu_raw)
menu_item_width = GUI_WIDTH / menu_count
menu_item_height = GUI_HEIGHT * 0.8
menu_y = (GUI_HEIGHT - menu_item_height) * 0.5

var i, Item, Caption, Entry
for (i = 0; i < menu_count; ++i) {
	Item = menu_raw[i]
	Caption = Item[0]

	Entry = new MainMenuSlideshow(Caption, -1, i * menu_item_width, other.menu_y)
	Qui_awake(global.qui_master, Entry)
}


/*
page_main = new MainEntryPage()
Qui_awake(global.qui_master, page_main)
page_main.focus()

var Sy = GUI_HEIGHT * 0.45, Gap = GUI_HEIGHT * 0.12
main_start = new MainPageButton("Start")
main_start.set_y(Sy)
//Qui_awake(page_main, main_start)
//main_start.focus()

main_log = new MainPageButton("Journey")
main_log.set_y(Sy + Gap)
//Qui_awake(page_main, main_log)

main_settings = new MainPageButton("Setting")
//main_settings.set_y(Sy + Gap * 2)
Qui_awake(page_main, main_settings)

main_exit = new MainPageButton("Exit")
main_exit.set_y(Sy + Gap * 3)
//Qui_awake(page_main, main_exit)

page_current = page_main
page_previous = page_main

//show_qui_popup("Test Title", "Test Label")

