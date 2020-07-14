/// @description HUD 그리기
draw_set_color($ffffff)

draw_set_valign(0)
draw_line(0, y, global.client.width, y)
var health_string = "Lives: " + string(parent.property.get_health()) + " / " + string(parent.property.get_health_max())
draw_text(10, y_draw_begin, health_string)
