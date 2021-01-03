/// @description Drawing the adjusted app surface
// TODO: minimap
//var bx = dx - 1
//var by = dy - 1
var ax = editor_port_x
var ay = editor_port_y

if !surface_exists(editor_surface)
	event_user(1)

surface_set_target(editor_surface)
draw_clear_alpha(0, 0)
var SCL = scale * 0.01
draw_surface_ext(application_surface, -x, -y, SCL, SCL, 0, $ffffff, 1)
surface_reset_target()

gpu_set_blendmode_ext(bm_one, bm_one)
draw_surface_ext(editor_surface, ax, ay, editor_port_scale, editor_port_scale, 0, $ffffff, 1)
gpu_set_blendmode(bm_normal)

draw_set_alpha(1)
draw_set_color($ffffff)
draw_rectangle(ax - 1, ay - 1, ax + editor_port_width + 1, ay + editor_port_height + 1, true)
