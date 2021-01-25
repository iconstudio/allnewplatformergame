/// @description Drawing the interface
draw_set_alpha(1)
draw_set_color($ffffff)

var dx, dy, tool_info, spr, caption, tool_selected = false
for (var i = 0; i < tool_number; ++i) {
	tool_info = tools.at(i)
	if is_undefined(tool_info)
		throw "Editor error!: Cannot found the tool at index " + string(i)

	dx = tool_info.x
	dy = tool_info.y
	spr = tool_info.icon
	caption = tool_info.title

	if i == selected_tool_index {
		if tool_info == mode
			draw_sprite(spr, 0, dx, dy)
		else
			draw_sprite_ext(spr, 0, dx, dy, 1, 1, 0, c_gray, 1)
	} else {
		draw_sprite_ext(spr, 0, dx, dy, 1, 1, 0, c_gray, 0.5)
	}
}

draw_set_font(fontEditorSmall)
draw_set_halign(0)
draw_set_valign(2)
draw_text(8, APP_HEIGHT - 8, string(scale_target) + "%")

draw_set_halign(2)
//draw_text(APP_WIDTH - 8, APP_HEIGHT - 8, "Mode: " + string(mode))

draw_set_alpha(1)
draw_set_halign(1)
draw_set_valign(1)
dx = editor_port_x
dy = editor_port_y
tool_info = test_maze.maze
var i, j, Cell
for (j = 0; j < GAME_BOARD_NUMBER_S; ++j) {
	for (i = 0; i < GAME_BOARD_NUMBER_S; ++i) {
		Cell = tool_info[j, i]
		caption = string(Cell.level)
		draw_set_color(Cell.color)
		draw_rectangle(dx, dy, dx + 20, dy + 20, false)
		draw_set_color(0)
		//draw_text(dx + 10, dy + 10, caption)
		dx += 20
	}
	dx = editor_port_x
	dy += 20
}
