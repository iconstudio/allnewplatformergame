/// @description 메뉴 상태 선언
mode_logo_fadein = new menu_mode(1, function() {
	menu_push.set(seconds(0.2))
}, function() {
	if menu_push.update() <= 0
		mode_change(mode_logo)
}, function() {
	var alpha = ease.in_quad(1 - menu_push.get())
	if 0 < alpha
		draw_sprite_ext(sLogo, 0, center_x, center_y, 1, 1, 0, $ffffff, alpha)
})

mode_logo = new menu_mode(1, function() {
	menu_push.set(seconds(2.8))
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

//
mode_title = new menu_mode(10, function() {
	menu_push.set(seconds(0.3))
	update_children()
}, function() {
	if menu_push.update() <= 0 {
		if global.io_pressed_yes
		or (!global.flag_is_mobile and mouse_check_button_pressed(mb_left))
		or (global.flag_is_mobile and mouse_check_button_released(mb_left)) {
			mode_change(mode_menu_enter)
		} else if global.io_pressed_no {
			mode_change(mode_title_exit)
		}
	}
}, function() {
	draw_sprite_ext(sTitle, 0, center_x, center_y, global.menu_title_scale, global.menu_title_scale, 0, $ffffff, 1)
})

//
mode_title_exit = new menu_mode(10, function() {
	menu_push.set(seconds(0.5))
}, function() {
	if menu_push.update() <= 0
		game_end()
}, function() {
	var alpha = ease.in_circ(lerp(1, 0, 1 - menu_push.get()))
	if 0 < alpha
		draw_sprite_ext(sTitle, 0, center_x, center_y, global.menu_title_scale, global.menu_title_scale, 0, $ffffff, alpha)
})

//
mode_menu_enter = new menu_mode(10, function() {
	menu_push.set(seconds(0.8))
	entry_title.visible = false
}, function() {
	if menu_push.update() <= 0 {
		mode_change(mode_menu)
		menu_push.finish()
		entry_title.visible = true
	}
	update_children()
}, function() {
	var alpha = 1 - menu_push.get()
	var dist = global.menu_title_y - center_y

	var ty = lerp(50, 0, ease.out_quart(alpha))
	draw_set_alpha(alpha)
	if 0 < alpha
		draw(x, y + ty)

	var ratio = ease.in_quad(alpha)
	ty = lerp(center_y, global.menu_title_y, ratio)
	var ts = lerp(global.menu_title_scale, global.menu_title_scale_main, ease.in_quad(alpha))
	draw_sprite_ext(sTitle, 0, center_x, ty, ts, ts, 0, $ffffff, 1)
})

//
mode_menu = new menu_mode(20, function() {
	menu_push.set(seconds(0.3))
}, function() {
	menu_push.update()
	entry_push.update()
	key_tick.update()
	update_children()

	if entry_push.get() < 0.8 {
		key_pick = NONE
		exit
	}

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
	} else if !global.io_up and !global.io_down {
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
		var entry = -1
		if key_pick == UP {
			entry = menu_focus_up()
		} else if key_pick == DOWN {
			entry = menu_focus_down()
		}

		if entry != -1 {
			if entry.pole {
				key_pick = NONE
				key_tick.finish()
			} else {
				key_tick.set(key_duration_continue)
			}
		} else {
			key_pick = NONE
			key_tick.finish()
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
	exit_fadeout_period = seconds(0.6)
	exit_period = seconds(1.4)
	exit_await_period = exit_period - exit_fadeout_period
	menu_push.set(exit_period)
}, function() {
	if menu_push.update() <= 0 {
		game_end()
		exit
	}
}, function() {
	var lim = menu_push.get_max()
	var time = lim - menu_push.get_time()

	if time < exit_fadeout_period {
		var alpha = (exit_fadeout_period - time) / (lim - exit_await_period)
		draw_set_alpha(ease.in_expo(alpha))
		if 0 < alpha
			draw(x, y)
	}
})
