/// @description HUD 그리기
draw_set_color($ffffff)
draw_line(0, y, global.client.width, y)
draw_text(10, y_draw_begin, "Lives: " + string(parent.property.get_health()))
