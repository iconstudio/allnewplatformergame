/// @description Init the menu
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

MainMenuButton = function(Caption, X, Y): QuiButton(Caption, X, Y) constructor {
	set_size(other.menu_item_width, other.menu_item_height)
}

var i, Item, Caption, Entry
for (i = 0; i < menu_count; ++i) {
	Item = menu_raw[i]
	Caption = Item[0]

	Entry = new MainMenuButton(Caption, i * menu_item_width, other.menu_y)
	Qui_awake(global.qui_master, Entry)
}

MainEntryPage = function(): QuiContainer(0, 0, GUI_WIDTH, GUI_HEIGHT) constructor {
	visible = true

	static close = function() {
		visible = false
	}

	static draw = function() {
		draw_set_alpha(tr_count / QUI_TR_PERIOD)
	}
}


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
