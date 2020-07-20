/// @description HUD 그리기
if !instance_exists(parent)
	exit

draw_set_alpha(1)
draw_set_color($ffffff)
//draw_line(0, y, global.client.width, y)
for (var i = 0; i < 3; ++i)
	draw_rectangle(panel_bezel_pos_begin[0] - i, panel_bezel_pos_begin[1] - i
	, panel_bezel_pos_end[0] + i, panel_bezel_pos_end[1] + i, true)

draw_set_font(fontUI)
draw_set_halign(0)
draw_set_valign(0)
var health_string = make_percent_caption("Lives", property.get_health(), property.get_health_max())
draw_text(10, y_draw_begin, health_string)

for (var i = 0; i < 4; ++i) {
	skill_icons[i].draw()
}
