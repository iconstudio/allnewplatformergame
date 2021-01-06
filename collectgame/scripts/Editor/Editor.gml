/// @function Editor()
function Editor() {
	/// @function scale_defactor(scale)
	scale_defactor = function(Scale) { return Scale * 0.01 }

	/// @function select_layer(index)
	select_layer = function(Index) {
		selected_layer_index = Index
		selected_layer = global.GAME_LAYERS[Index]
	}

	/// @function toolbar_add(tool)
	toolbar_add = function(Tool) {
		Tool.x = gui_x_begin
		Tool.y = gui_y_begin + tool_number * 90
		tools.push_back(Tool)
		tool_number++// = tools.get_size()
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

		view_w = (XELL_WIDTH / SCL)
		view_h = (XELL_HEIGHT / SCL)
		if SCL <= 1 {
			x_max = 0
			y_max = 0
		} else {
			x_max = XELL_WIDTH - view_w
			y_max = XELL_HEIGHT - view_h
		}
	}

	mx = -1
	my = -1
	mx_begin = -1
	my_begin = -1

	scaling = false
	scale_time = 0
	scale_period = seconds(0.5)
	scale_begin = 100
	scale_target = scale_begin
	scale = scale_begin
	scale_min = 100
	scale_max = 500
	var factor = scale_defactor(scale)
	width = XELL_WIDTH * factor
	height = XELL_HEIGHT * factor

	view_w = XELL_WIDTH / factor
	view_h = XELL_HEIGHT / factor
	view_scroll_manual = 160 / seconds(1)
	editor_port_scale = 2.5
	editor_port_width = XELL_WIDTH * editor_port_scale
	editor_port_height = XELL_HEIGHT * editor_port_scale
	editor_port_x = (APP_WIDTH - editor_port_width) * 0.5
	editor_port_y = (APP_HEIGHT - editor_port_height) * 0.25
	x = 0
	y = 0
	x_min = 0
	y_min = 0
	x_max = XELL_WIDTH * (1 - factor)
	y_max = XELL_HEIGHT * (1 - factor)

	ON_GUI = 1
	ON_BOARD = 2
	mouse_mode = NONE
	dragging = false
	drag_x = -1
	drag_y = -1

	mode = undefined
	tools = new List()
	tool_number = 0
	selected_tool_index = 0

	gui_x_begin = 8
	gui_y_begin = 8

	selected_layer_index = 0
	selected_layer = global.GAME_LAYERS[0]
	block_group_index = 0

	EditorTool = function(Name, Icon, Condition, InitExec, Predicate, Hotkey) constructor {
		x = 0
		y = 0
		title = Name
		icon = Icon
		kit_condition = Condition
		initializer = InitExec
		predicate = Predicate
		shortcut = Hotkey
		drawer = undefined
	}

	/// @function get_grid_mouse_x(scale)
	get_grid_mouse_x = function(Scale) {
		var FirstPos = mx - editor_port_x
		var Pos = FirstPos * editor_port_scale
		var Pos_ratio = max(0, min(1, Pos / editor_port_width))
		//var Pos_clp = clamp(Pos_ratio, )
		return floor((Pos) / grid_size) * grid_size
	}

	/// @function get_grid_mouse_y(scale)
	get_grid_mouse_y = function(Scale) {
		var FirstPos = my - editor_port_y
		var Pos = FirstPos * editor_port_scale
		return floor((Pos * Scale) / grid_size) * grid_size
	}

	/// @function tool_create(name, icon, exec_condition, exec_initializer, exec_predicate, [shortcut_method])
	tool_create = function(Name, Icon, Condition, InitExec, Predicate, Hotkey) {
		if !is_undefined(Condition)
			Condition = method(self, Condition)
		if !is_undefined(InitExec)
			InitExec = method(self, InitExec)
		if !is_undefined(Predicate)
			Predicate = method(self, Predicate)
		
		return new EditorTool(Name, Icon, Condition, InitExec, Predicate, Hotkey)
	}

	TOOL_BRUSH = tool_create("Brush", sEditorToolBrush, function() { return (mouse_mode == ON_BOARD) }, undefined,
	function() {
		
	}, function() {
		return keyboard_check_pressed(ord("B"))
	})
	TOOL_BRUSH.drawer = function() {
		draw_set_color($ff)
		draw_circle(grid_cursor_x + 8, grid_cursor_y + 8, 6, false)
	}

	TOOL_ERASER = tool_create("Eraser", sEditorToolBrush, function() { return (mouse_mode == ON_BOARD) }, undefined,
	function() {
		
	}, function() {
		return keyboard_check_pressed(ord("E"))
	})

	TOOL_FILL = tool_create("Fill", sEditorToolBrush, function() { return (mouse_mode == ON_BOARD) }, undefined,
	function() {
		
	}, function() {
		return keyboard_check_pressed(ord("F"))
	})

	TOOL_SELECTR = tool_create("Select Region", sEditorToolBrush, function() { return (mouse_mode == ON_BOARD) },
	function() {
		mx_begin = mx
		my_begin = my
	},
	function() {
		
	}, function() {
		return keyboard_check_pressed(ord("S"))
	})
	

	TOOL_CURSOR = tool_create("Cursor", sEditorToolBrush, function() { return (mouse_mode == ON_BOARD) }, undefined,
	function() {
		//mode = TOOL_CURSOR
	}, function() {
		return keyboard_check_pressed(vk_escape) or keyboard_check_pressed(ord("C"))
	})

	toolbar_add(TOOL_BRUSH)
	toolbar_add(TOOL_ERASER)
	toolbar_add(TOOL_FILL)
	toolbar_add(TOOL_SELECTR)
	toolbar_add(TOOL_CURSOR)
}
