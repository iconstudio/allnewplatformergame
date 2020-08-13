/// @description 메뉴 상태 선언
mode_logo_fadein = new menu_mode(1, function() {
	menu_push.set(seconds(0.4))
}, function() {
	if menu_push.update() <= 0
		mode_change(mode_logo)
}, function() {
	var alpha = ease.out_quad(1 - menu_push.get())
	if 0 < alpha
		draw_sprite_ext(sLogo, 0, center_x, center_y, 1, 1, 0, $ffffff, alpha)
})

mode_logo = new menu_mode(1, function() {
	menu_push.set(seconds(4.6))
	//logo_time = seconds(2)
}, function() {
	if menu_push.update() <= 0
		mode_change(mode_title)
}, function() {
	draw_sprite_ext(sLogo, 0, center_x, center_y, 1, 1, 0, $ffffff, 1)
	/*
	var lim = menu_push.get_max()
	var time = menu_push.get_time()
	if time <= logo_time {
		var alpha = 1 - ((logo_time - time) / (lim - logo_time))
		if 0 < alpha
			draw_sprite_ext(sLogo, 0, center_x, center_y, 1, 1, 0, $ffffff, alpha)
	} else {
		draw_sprite_ext(sLogo, 0, center_x, center_y, 1, 1, 0, $ffffff, 1)
	}*/
})

mode_title = new menu_mode(10, function() {
	menu_push.set(seconds(0.3))
	update_children()
}, function() {
	if menu_push.update() <= 0 {
		if global.io_pressed_yes
		or (!global.flag_is_mobile and mouse_check_button_pressed(mb_left))
		or (global.flag_is_mobile and mouse_check_button_released(mb_left)) {
			mode_change(mode_menu)
		} else if global.io_pressed_no {
		mode_change(mode_title_exit)
		} else {
			
		}
	}
}, function() {
	draw_sprite_ext(sTitle, 0, center_x, center_y, 0.7, 0.7, 0, $ffffff, 1)
})

mode_title_exit = new menu_mode(10, function() {
	menu_push.set(seconds(0.5))
	update_children()
}, function() {
	if menu_push.update() <= 0
		game_end()
}, function() {
	var alpha = lerp(1, 0, 1 - menu_push.get())
	if 0 < alpha
		draw_sprite_ext(sTitle, 0, center_x, center_y, 0.7, 0.7, 0, $ffffff, alpha)
})

mode_menu_enter = new menu_mode(10, function() {
	menu_push.set(seconds(0.3))
	update_children()
}, function() {
	menu_push.update()

	if global.io_pressed_yes
	or (!global.flag_is_mobile and mouse_check_button_pressed(mb_left))
	or (global.flag_is_mobile and mouse_check_button_released(mb_left)) {
		mode_change(mode_menu)
	}
}, function() {
	draw_sprite_ext(sTitle, 0, center_x, center_y, 0.7, 0.7, 0, $ffffff, 1)
})

mode_menu = new menu_mode(20, function() {
	menu_push.set(seconds(0.3))
}, function() {
	menu_push.update()
	key_tick.update()
	update_children()

	if global.io_pressed_yes {
		with global.menu_opened {
			if child_focused != -1
				select(child_focused)
		}
	} else if global.io_pressed_up {
		if key_pick != UP {
			menu_focus_up()
			key_tick.set(key_duration_pick)
			key_pick = UP
		} else {
			key_pick = NONE
		}
	} else if global.io_pressed_down {
		if key_pick != DOWN {
			menu_focus_down()
			key_tick.set(key_duration_pick)
			key_pick = DOWN
		} else {
			key_pick = NONE
		}
	} else if !global.io_left and !global.io_right {
		key_pick = NONE
		key_tick.finish()
	}

	// ** 좌우 입력은 따로 받는다. **
	var SIDEKEY_INPUT = global.io_pressed_right - global.io_pressed_left
	if SIDEKEY_INPUT != 0 {
		with global.menu_opened {
			if child_focused != -1 and child_focused.sidekey_predicate != -1 {
				child_focused.sidekey_predicate(SIDEKEY_INPUT)
			}
		}
	}

	if key_pick != NONE and key_tick.get() <= 0 {
		if key_pick == UP {
			menu_focus_up()
			key_tick.set(key_duration_continue)
		} else if key_pick == DOWN {
			menu_focus_down()
			key_tick.set(key_duration_continue)
		}
	}
}, function() {
	var alpha = 1 - menu_push.get()
	draw_set_alpha(alpha)
	if 0 < alpha
		draw(x, y)
})

mode_fadeout = new menu_mode(50, function() {
	
}, function() {
	menu_push.update()
}, function() {
	var alpha = menu_push.get()
	draw_set_alpha(alpha)
	if 0 < alpha
		draw(x, y)
})

mode_restart = new menu_mode(90, function() {
	menu_push.set(seconds(1))
}, function() {
	if menu_push.update() <= 0 {
		game_restart()
		exit
	}
}, function() {
	var alpha = menu_push.get()
	draw_set_alpha(alpha)
	if 0 < alpha
		draw(x, y)
})

mode_exit = new menu_mode(99, function() {
	menu_push.set(seconds(1.4))
}, function() {
	if menu_push.update() <= 0 {
		game_end()
		exit
	}
}, function() {
	var alpha = menu_push.get() * 0.5
	draw_set_alpha(alpha)
	if 0 < alpha
		draw(x, y)
})
