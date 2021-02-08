/// @description Initialization
global.main_menu_id = id

event_user(0)
event_user(1)
event_user(2)
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

