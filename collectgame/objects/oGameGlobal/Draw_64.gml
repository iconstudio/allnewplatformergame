/// @description Test drawing
/*

draw_set_alpha(0.5)

var i, j, data, dx, dy
for (j = 0; j < GAME_BOARD_HEIGHT_MAX; ++j) {
	for (i = 0; i < GAME_BOARD_WIDTH_MAX; ++i) {
		data = board[# i, j]
		if data == 1
			draw_set_color($ff8000)
		else
			draw_set_color($ff)

		dx = 32 + i * 24
		dy = 32 + j * 24
		draw_rectangle(dx, dy, dx + 16, dy + 16, false)
	}
}

draw_set_alpha(1)
draw_set_color($ffffff)
