/// @description States update and smooth scaling
var last_mx = device_mouse_x_to_gui(0)
var last_my = device_mouse_y_to_gui(0)

var ax = editor_port_x
var ay = editor_port_y
if last_mx < 0 or last_my < 0 or APP_WIDTH <= last_mx or APP_HEIGHT <= last_my
	mouse_mode = NONE
else if point_in_rectangle(last_mx, last_my, ax, ay, ax + editor_port_width, ay + editor_port_height)
	mouse_mode = ON_BOARD
else
	mouse_mode = ON_GUI

if mouse_mode != NONE {
	mx = last_mx
	my = last_my
	var SCL = scale_defactor(scale_target)
	grid_cursor_x = ax + get_grid_mouse_x(SCL)
	grid_cursor_y = ay + get_grid_mouse_y(SCL)
}

var Changeable = tool_changable()
if mode != TOOL_FILL {
	var Ctrl = keyboard_check_pressed(vk_lcontrol) or keyboard_check(vk_rcontrol)
	var Subs = keyboard_check_pressed(vk_add) - keyboard_check_pressed(vk_subtract)
	
	var h_check = global.io_right - global.io_left
	var v_check = global.io_down - global.io_up

	if h_check != 0 {
		if h_check < 0 {
			if view_scroll_manual < x
				x -= view_scroll_manual
			else
				x = 0
		} else {
			if x < x_max - view_scroll_manual
				x += view_scroll_manual
			else
				x = x_max
		}
	}

	if Subs != 0 and ((v_check != 0 and !Ctrl) or (v_check == 0)) {
		if 0 < Subs
			event_perform(ev_mouse, ev_mouse_wheel_up)
		else if Subs < 0
			event_perform(ev_mouse, ev_mouse_wheel_down)
	} else if v_check != 0 {
		if Ctrl {
			if global.io_pressed_up
				event_perform(ev_mouse, ev_mouse_wheel_up)
			else if global.io_pressed_down
				event_perform(ev_mouse, ev_mouse_wheel_down)
		} else {
			if v_check < 0 {
				if view_scroll_manual < y
					y -= view_scroll_manual
				else
					y = 0
			} else {
				if y < y_max - view_scroll_manual
					y += view_scroll_manual
				else
					y = y_max
			}
		}
	}
}

if Changeable {
	var tool_info, tool_init, shortcut_check = false
	for (var i = 0; i < tool_number; ++i) {
		tool_info = tools.at(i)
		if is_undefined(tool_info)
			throw "Editor error!: Cannot found the tool at index " + string(i)

		shortcut_check = tool_info.shortcut()
		if shortcut_check {
			selected_tool_index = i
			tool_init = tool_info.initializer
			if !is_undefined(tool_init)
				tool_init()
		}
	}
}

if scaling {
	var zoom_ratio = scale_time / scale_period
	if zoom_ratio < 1 {
		scale = lerp(scale_begin, scale_target, ease.out_expo(zoom_ratio))
		scale_time++
	} else {
		scaling = false
		scale = scale_target
		scale_time = 0
	}
}
