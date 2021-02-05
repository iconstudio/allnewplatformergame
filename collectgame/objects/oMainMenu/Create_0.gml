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

event_user(0)

MainPageButton = function(Caption): QuiButton(Caption, GUI_WIDTH * 0.08, 0, undefined, 0, 0.5) constructor {
	set_size(GUI_WIDTH * 0.3, GUI_HEIGHT * 0.1)

	static outliner_padding = 1.5
	static outliner_size_x = size_x * 2
	static outliner_size_y = size_y * 2
	static outliner_ix = outliner_size_x * 0.5
	static outliner_iy = outliner_size_y * 0.5
	static caption_sx = outliner_size_x * 0.2
	static caption_sy = outliner_size_y * 0.5

	outliner_surface = surface_create(outliner_size_x, outliner_size_y)
	outliner_texture = surface_get_texture(outliner_surface)

	static destroy = function() {
		if surface_exists(outliner_surface)
			surface_free(outliner_surface)
	}

	static draw_caption = function(X, Y, Xscl, Yscl) {
		draw_text_transformed(X, Y, caption, Xscl, Yscl, 0)
	}

	static draw = function() {
		var Target = global.main_menu_id.Page_surface
		if !surface_exists(Target) {
			with global.main_menu_id
				event_user(0)
		}
		Target = global.main_menu_id.Page_surface

		draw_set_font(fontMainEntry)
		draw_set_halign(0)
		draw_set_valign(1)

		var Alpha = draw_get_alpha() * image_alpha
		if phase != 0 {
			draw_set_alpha(1)
			draw_set_color(0xF25EE1)
			surface_set_target(outliner_surface)
			draw_clear_alpha(0, 0.3)
			draw_transform_stack_push()
			draw_transform_set_translation(outliner_ix, outliner_iy, 0)
			draw_caption(0, 0, 0.5, 0.5)
			draw_caption(outliner_padding, 0, 0.5, 0.5)
			draw_caption(-outliner_padding, 0, 0.5, 0.5)
			draw_caption(0, outliner_padding, 0.5, 0.5)
			draw_caption(0, -outliner_padding, 0.5, 0.5)
			draw_transform_set_identity()
			draw_transform_stack_pop()
			surface_reset_target()
		}

		draw_set_alpha(Alpha)
		switch phase {
			case 0:
				draw_set_color($ffffff)
				draw_caption(caption_sx, caption_sy, 1, 1)
		        break

			case 1:
				draw_surface_ext(outliner_surface, -outliner_ix, -outliner_iy, 2, 2, 0, $ffffff, Alpha)
				draw_set_color($ffffff)
				draw_caption(caption_sx, caption_sy, 1, 1)
		        break

			case 2:
				draw_surface_ext(outliner_surface, -outliner_ix, -outliner_iy, 2, 2, 0, $ffffff, Alpha)
				draw_set_color($fbfbfb)
				draw_caption(caption_sx, caption_sy, 1, 1)
		        break

			case 3:
				draw_set_color($ffffff)
				draw_caption(caption_sx, caption_sy, 1, 1)
		        break

			default:
				break
		}
	}
}

pages_now = ds_stack_create()
make_page = function() {
	var Page = new MainEntryPage()
	ds_stack_push(pages_now, Page)
	return Page
}

page_main = make_page()
Qui_awake(global.qui_master, page_main)
page_main.focus()

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

