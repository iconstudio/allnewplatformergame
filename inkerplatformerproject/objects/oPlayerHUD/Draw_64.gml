/// @description HUD 그리기
draw_set_alpha(1)
draw_set_color($ffffff)
//draw_line(0, y, global.client.width, y)
draw_rectangle(panel_bezel_pos_begin[0], panel_bezel_pos_begin[1], panel_bezel_pos_end[0], panel_bezel_pos_end[1], true)

draw_set_valign(0)
var health_string = make_percent_caption("Lives", property.get_health(), property.get_health_max())
draw_text(10, y_draw_begin, health_string)
