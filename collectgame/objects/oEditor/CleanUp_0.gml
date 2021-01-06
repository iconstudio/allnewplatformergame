delete tools
keyboard_set_map(vk_backspace, vk_backspace)
window_set_cursor(cr_none)

if surface_exists(grid_surface)
	surface_free(grid_surface)
if surface_exists(editor_surface)
	surface_free(editor_surface)
