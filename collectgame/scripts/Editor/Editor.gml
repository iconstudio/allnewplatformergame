/// @function Editor()
function Editor() {
	x = global.app_position[0]
	y = global.app_position[1]
	keyboard_set_map(vk_backspace, vk_escape)
	window_set_cursor(cr_default)

	scale = 200
	scale_min = 50
	scale_max = 500

	tools = new List()
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
		tools.push_back(new EditorTool(Name, Icon, Predicate, Hotkey))
	}

	/// @function position_adjust()
	position_adjust = function() {
		editor_position = [
			floor((APP_WIDTH - XELL_WIDTH * scale * 0.01) * 0.5),
			floor((APP_HEIGHT - XELL_HEIGHT * scale * 0.01) * 0.25)
		]
	}

	EditorTool = function(Name, Icon, Predicate, Hotkey) constructor {
		title = Name
		icon = Icon
		predicate = Predicate
		shortcut = Hotkey
	}
}
