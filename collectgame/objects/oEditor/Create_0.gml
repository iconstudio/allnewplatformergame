/// @description Initialization
Editor()

tool_add("Brush", sEditorToolBrush, function() {
	
}, function() {
	return keyboard_check_pressed(ord("1")) or keyboard_check_pressed(ord("B"))
})

tool_add("Eraser", sEditorToolBrush, function() {
	
}, function() {
	return keyboard_check_pressed(ord("2")) or keyboard_check_pressed(ord("E"))
})

tool_add("Fill", sEditorToolBrush, function() {
	
}, function() {
	return keyboard_check_pressed(ord("3")) or keyboard_check_pressed(ord("F"))
})

tool_add("Select Region", sEditorToolBrush, function() {
	
}, function() {
	return keyboard_check_pressed(ord("4")) or keyboard_check_pressed(ord("S"))
})

tool_add("Cursor", sEditorToolBrush, function() {
	
}, function() {
	return keyboard_check_pressed(ord("5")) or keyboard_check_pressed(ord("C"))
})

grid_on = true
grid_surface = -1
grid_size = 16
grid_w_count = ceil(PORT_WIDTH / grid_size)
grid_h_count = ceil(PORT_HEIGHT / grid_size)
event_user(0)

editor_surface = -1
editor_position = [
	(APP_WIDTH - XELL_WIDTH * 2) * 0.5,
	(APP_HEIGHT - XELL_HEIGHT * 2) * 0.25
]
event_user(1)
