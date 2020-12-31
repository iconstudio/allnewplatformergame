/// @description Creating a grid surface
grid_surface = surface_create(PORT_WIDTH, PORT_HEIGHT)
surface_set_target(grid_surface)
draw_clear_alpha(0, 0)

var dx = 0, dy = 0
for (var i = 0; i < grid_w_count; ++i) {
	for (var j = 0; j < grid_h_count; ++j) {
		draw_sprite(sEditorGrid, 0, i * grid_size, j * grid_size)
	}
}
surface_reset_target()
