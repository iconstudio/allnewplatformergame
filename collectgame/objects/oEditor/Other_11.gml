/// @description Creating the workspace surface
if !surface_exists(application_surface)
	exit

editor_surface = surface_create(XELL_WIDTH + 2, XELL_HEIGHT + 2)
surface_set_target(editor_surface)
draw_clear_alpha(0, 0)
surface_reset_target()
