/// @description Drawing the adjusted app surface
var dx = editor_position[0]
var dy = editor_position[1]

// TODO: minimap
//var bx = dx - 1
//var by = dy - 1

//draw_set_alpha(1)
//draw_set_color($ffffff)
//draw_rectangle(bx, by, XELL_WIDTH + 1, XELL_HEIGHT + 1, true)

//draw_surface_ext(editor_surface, 0, 0, scale, scale, 0, $ffffff, 0.5)
var SCL = scale * 0.01
draw_surface_ext(application_surface, dx, dy, SCL, SCL, 0, $ffffff, 1)
