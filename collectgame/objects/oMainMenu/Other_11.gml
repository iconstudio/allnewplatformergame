/// @description Init the menu
/// @function MainMenuSlideshow(title, logo, x, y)
MainMenuSlideshow = function(Caption, Logo, X, Y): QuiEntry(true, true) constructor {
	static toString = function() { return "Main Menu: " + string(caption) }

	opened = false
	pressed = false
	caption = Caption

	sprite_index = Logo
	image_alpha = 1
	image_blend = $ffffff

	x = X
	y = Y
	size_x = other.menu_item_width
	size_y = other.menu_item_height

	static update = function() {
		if global.qui_io_last == QUI_IO_STATES.MOUSE {
			if self == global.qui_cursor {
				if !pressed {
					if global.io_mouse_pressed_left {
						pressed = true
						focus()
					}
				} else { // pressed
					if global.io_mouse_released_left {
						//TODO
						pressed = false
					}
				}
				if global.io_pressed_back
					pressed = false
				if pressed
					phase = 2
				else
					phase = 1
			} else {
				if global.io_pressed_back
					pressed = false
				if pressed and ((!global.io_mouse_left and configuration == "Mobile") or global.io_mouse_released_left)
					pressed = false

				if pressed
					phase = 3
				else
					phase = 0
			}
		} else if global.qui_focused == self {
			var check = (global.io_pressed_right or global.io_pressed_down) - (global.io_pressed_left or global.io_pressed_up)
			if check == 1 {
				if !is_undefined(brother_next)
					brother_next.focus()
				pressed = false
				phase = 0
			} else if check == -1 {
				if !is_undefined(brother_before)
					brother_before.focus()
				pressed = false
				phase = 0
			} else {
				phase = 1
				if global.io_pressed_yes {
					//TODO
					phase = 2
				}
			}
		} else {
			phase = 0
		}
	}

	static draw = function() {
		var Alpha = draw_get_alpha() * image_alpha
		draw_set_alpha(Alpha)
		draw_set_color(image_blend)
		switch phase {
			case 0:
				draw_sprite_stretched_ext(sButtonSplices, 0, 0, 0, size_x, size_y, image_blend, Alpha)
		        break

			case 1:
				draw_splice(sButtonSplices, 5, 1, 0, 0, size_x, size_y)
		        break

			case 2:
				draw_sprite_stretched_ext(sButtonSplices, 2, 0, 0, size_x, size_y, image_blend, Alpha)
		        break

			case 3:
				draw_splice(sButtonSplices, 5, 3, 0, 0, size_x, size_y)
		        break

			default:
				break
		}

		draw_set_color(0)
		draw_set_font(fontQuiText)
		draw_set_halign(1)
		draw_set_valign(1)
		draw_text(size_x * 0.5, size_y * 0.5, caption)
	}
}

/*
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
