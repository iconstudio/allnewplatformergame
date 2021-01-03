/// @function Editor()
function Editor() {
	keyboard_set_map(vk_backspace, vk_escape)
	window_set_cursor(cr_default)

	scaling = false
	scale_time = 0
	scale_period = seconds(0.5)
	scale_begin = 200
	scale_target = 200
	scale = 200
	scale_min = 50
	scale_max = 500
	width = XELL_WIDTH * 2
	height = XELL_HEIGHT * 2

	view_w = XELL_WIDTH * 0.5
	view_h = XELL_HEIGHT * 0.5
	view_scroll_manual = 160 / seconds(1)
	view_x = global.app_position[0]
	view_y = 128
	editor_port_scale = 2.5
	editor_port_width = XELL_WIDTH * editor_port_scale
	editor_port_height = XELL_HEIGHT * editor_port_scale
	editor_port_x = (APP_WIDTH - editor_port_width) * 0.5
	editor_port_y = (APP_HEIGHT - editor_port_height) * 0.25
	x = 0
	y = 0
	x_min = 0
	y_min = 0
	x_max = XELL_WIDTH * 0.5
	y_max = XELL_HEIGHT * 0.5

	dragging = false
	drag_x = -1
	drag_y = -1

	mode = undefined
	tools = new List()
	tool_number = 0
	selected_tool_index = 0

	selected_layer_index = 0
	selected_layer = global.GAME_LAYERS[0]
	block_group_index = 0

	/// @function select_layer(index)
	select_layer = function(Index) {
		selected_layer_index = Index
		selected_layer = global.GAME_LAYERS[Index]
	}

	/// @function tool_add(name, icon, predicate, [shortcut_method])
	tool_add = function(Name, Icon, Predicate, Hotkey) {
		var one = new EditorTool(Name, Icon, method(self, Predicate), Hotkey)
		tools.push_back(one)
		return one
	}

	/// @function tool_changable()
	tool_changable = function() {
		return is_undefined(mode)
	}

	/// @function tool_change(new_tool)
	tool_change = function(NewTool) {
		
	}

	/// @function position_adjust()
	position_adjust = function() {
		var SCL = scale * 0.01
		width = XELL_WIDTH * SCL
		height = XELL_HEIGHT * SCL

		view_w = ceil(XELL_WIDTH / SCL)
		view_h = ceil(XELL_HEIGHT / SCL)
		if SCL <= 1 {
			x_min = 0
			y_min = 0
			x_max = 0
			y_max = 0
		} else {
			x_min = 0
			y_min = 0
			x_max = XELL_WIDTH - view_w
			y_max = XELL_HEIGHT - view_h
		}
	}

	EditorTool = function(Name, Icon, Predicate, Hotkey) constructor {
		title = Name
		icon = Icon
		predicate = Predicate
		shortcut = Hotkey
	}
}
