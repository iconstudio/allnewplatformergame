/// @description Initialization
Editor()

TOOL_BRUSH = tool_add("Brush", sEditorToolBrush, function() {
	//mode = TOOL_BRUSH
}, function() {
	return keyboard_check_pressed(ord("1")) or keyboard_check_pressed(ord("B"))
})

TOOL_ERASER = tool_add("Eraser", sEditorToolBrush, function() {
	//mode = TOOL_ERASER
}, function() {
	return keyboard_check_pressed(ord("2")) or keyboard_check_pressed(ord("E"))
})

TOOL_FILL = tool_add("Fill", sEditorToolBrush, function() {
	//mode = TOOL_FILL
}, function() {
	return keyboard_check_pressed(ord("3")) or keyboard_check_pressed(ord("F"))
})

TOOL_SELECTR = tool_add("Select Region", sEditorToolBrush, function() {
	mode = TOOL_SELECTR
}, function() {
	return keyboard_check_pressed(ord("4")) or keyboard_check_pressed(ord("S"))
})

TOOL_CURSOR = tool_add("Cursor", sEditorToolBrush, function() {
	//mode = TOOL_CURSOR
}, function() {
	return keyboard_check_pressed(ord("5")) or keyboard_check_pressed(ord("C"))
})

tool_number = tools.get_size()
grid_on = true
grid_surface = -1
grid_size = 16
grid_w_count = ceil(PORT_WIDTH / grid_size)
grid_h_count = ceil(PORT_HEIGHT / grid_size)
event_user(0)

editor_surface = -1
//event_user(1)
