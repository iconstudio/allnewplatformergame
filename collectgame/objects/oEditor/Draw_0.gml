/// @description Drawing a grid
if grid_on {
	if !surface_exists(grid_surface)
		event_user(0)
	else
		draw_surface_ext(grid_surface, 0, 0, 1, 1, 0, $ffffff, 0.5)
}
