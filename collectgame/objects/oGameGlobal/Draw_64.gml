/// @description Test drawing
draw_set_halign(1)
draw_set_valign(1)

var i, j, data, dx, dy, color, dist = 0
for (j = 0; j < GAME_BOARD_NUMBER_S; ++j) {
	for (i = 0; i < GAME_BOARD_NUMBER_S; ++i) {
		data = board[# i, j]
		dx = floor(32 + i * 24)
		dy = floor(32 + j * 24)

		if is_real(data) {
			draw_set_alpha((data / DIFFICULTY_MAX))
			draw_set_color(c_fuchsia)
			draw_rectangle(dx, dy, dx + 16, dy + 16, false)
			draw_set_alpha(1)
			draw_set_color(0)
			draw_text(dx + 8, dy + 8, string(data))
		} else {
			draw_set_alpha(1)
			draw_set_color($0070aa)
			draw_rectangle(dx, dy, dx + 16, dy + 16, false)
		}
	}
}

draw_set_alpha(1)
draw_set_color($ffffff)
