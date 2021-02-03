/// @description Initialization
global.main_menu_id = id

MainEntryPage = function(): QuiContainer(0, 0, GUI_WIDTH, GUI_HEIGHT) constructor {
	visible = false
	static close = function() {
		visible = false
	}

	static draw = function() {
		draw_set_alpha(tr_count / QUI_TR_PERIOD)
	}
}

MainPageButton = function(Caption): QuiButton(Caption, 0, 0) constructor {
	set_x(GUI_WIDTH * 0.08)
	set_size(GUI_WIDTH * 0.3, GUI_HEIGHT * 0.1)
	set_anchor(0, 0.5)
}

pages_now = ds_stack_create()
make_page = function() {
	var Page = new MainEntryPage()
	ds_stack_push(pages_now, Page)
	return Page
}

make_entry_on_page = function(Page, Item) {
	Page.add_entry(Item)
	return Item
}

page_main = make_page()

// TODO
var Sy = GUI_HEIGHT * 0.45, Gap = GUI_HEIGHT * 0.12
main_start = make_entry_on_page(page_main, new MainPageButton("Start"))
main_start.focus()
main_start.set_y(Sy)

main_log = make_entry_on_page(page_main, new MainPageButton("Journey"))
main_log.set_y(Sy + Gap)

main_settings = make_entry_on_page(page_main, new MainPageButton("Setting"))
main_settings.set_y(Sy + Gap * 2)

main_exit = make_entry_on_page(page_main, new MainPageButton("Exit"))
main_exit.set_y(Sy + Gap * 3)

page_current = page_main
page_previous = page_main

Qui_awake(page_main)
page_main.focus()

show_qui_popup("Test Title", "Test Label")

