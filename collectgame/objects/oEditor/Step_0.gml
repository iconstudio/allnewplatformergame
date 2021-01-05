/// @description Update and smooth scaling
mx = device_mouse_x_to_gui(0)
my = device_mouse_y_to_gui(0)

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

if v_check != 0 {
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

var tool_info, shortcut_check = false
for (var i = 0; i < tool_number; ++i) {
	tool_info = tools.at(i)
	if is_undefined(tool_info)
		throw "Editor error!: Cannot found the tool at index " + string(i)

	shortcut_check = tool_info.shortcut()
	if shortcut_check and tool_changable() {
		selected_tool_index = i
		tool_info.predicate()
		//tool_change(tool_info)
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
