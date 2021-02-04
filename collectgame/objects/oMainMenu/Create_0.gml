/// @description Initialization
global.main_menu_id = id

MainEntryPage = function(): QuiContainer(0, 0, GUI_WIDTH, GUI_HEIGHT) constructor {
	visible = true

	static close = function() {
		visible = false
	}

	static draw = function() {
		draw_set_alpha(tr_count / QUI_TR_PERIOD)
	}
}

MainPageButton = function(Caption): QuiButton(Caption, GUI_WIDTH * 0.08, 0) constructor {
	image_blend = $ffffff

	set_size(GUI_WIDTH * 0.3, GUI_HEIGHT * 0.1)
	set_anchor(0, 0.5)
	outliner_size_x = size_x * 1.5
	outliner_size_y = size_y * 1.5
	outliner_cx = outliner_size_x * 0.5
	outliner_cy = outliner_size_y * 0.5
	outliner_surface = surface_create(outliner_size_x, outliner_size_y)

	static destroy = function() {
		if surface_exists(outliner_surface)
			surface_free(outliner_surface)
	}

	static ddraw = function() {
		if !surface_exists(outliner_surface)
			outliner_surface = surface_create(outliner_size_x, outliner_size_y)

		var phase = 0
		var Alpha = draw_get_alpha() * image_alpha
		draw_set_alpha(Alpha)
		draw_set_color(image_blend)
		draw_set_font(fontMainEntry)
		draw_set_halign(1)
		draw_set_valign(1)
		if self == global.qui_cursor {
			if pressed
				draw_sprite_stretched_ext(sprite_index, 2, 0, 0, size_x, size_y, image_blend, Alpha)
			else
				draw_text(size_x * 0.5, size_y * 0.5, caption)
		} else {
			if pressed
				draw_splice(sprite_index, edge, 3, 0, 0, size_x, size_y)
			else
				draw_text(size_x * 0.5, size_y * 0.5, caption)
		}
	}
}

pages_now = ds_stack_create()
make_page = function() {
	var Page = new MainEntryPage()
	ds_stack_push(pages_now, Page)
	return Page
}

make_entry_on_page = function(Page, Item) {
	with Page
		add_entry(Item)
	return Item
}

page_main = make_page()
Qui_awake(global.qui_master, page_main)
page_main.focus()

// TODO
var Sy = GUI_HEIGHT * 0.45, Gap = GUI_HEIGHT * 0.12
main_start = new MainPageButton("Start")
main_start.set_y(Sy)
Qui_awake(page_main, main_start)
main_start.focus()

main_log = new MainPageButton("Journey")
main_log.set_y(Sy + Gap)
Qui_awake(page_main, main_log)

main_settings = new MainPageButton("Setting")
main_settings.set_y(Sy + Gap * 2)
Qui_awake(page_main, main_settings)

main_exit = new MainPageButton("Exit")
main_exit.set_y(Sy + Gap * 3)
Qui_awake(page_main, main_exit)

page_current = page_main
page_previous = page_main

//show_qui_popup("Test Title", "Test Label")

