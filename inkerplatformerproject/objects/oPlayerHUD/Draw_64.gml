/// @description HUD 그리기
draw_set_color($ffffff)
draw_line(0, y - 1, global.client.width, y - 1)
draw_text(10, 0, "Lives: " + string(parent.property.get_health()))
