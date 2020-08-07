/// @description 메뉴 그리기
draw_set_color($ffffff)

draw_set_halign(1)
draw_set_valign(0)

var ratio = push.get() / push.get_max()
var alpha = ratio
draw_set_alpha(alpha)


draw_set_alpha(1 - alpha)
var dx = center_x, dy = global.menu_start_y, temp = 0
with menu_current {
	if 0 < size {
		for (var i = 0; i < size; ++i) {
			entries[i].x = dx
			entries[i].y = dy
			temp = entries[i].draw()
			dy += temp
		}
	}
}

draw_set_font(fontMainMenu)
