/// @description Initialization
board_data = function() constructor {
	seed = random_get_seed()
	category = BOARD_CELL_CATEGORY.NORMAL
	level = 0
	chunk = ""

	static toString = function() { // json
		return "{\n"
		+ "\tseed: " + string(seed) + ", "
		+ "\tcategory: " + string(category) + ", "
		+ "\tlevel: " + string(level) + ", "
		+ "\tchunk: " + string(chunk)
		+ "\n}"
	}
}

make_cell = function(xpos, ypos) {
	var data = board[# xpos, ypos]

	
}

board_clear = function() {
	ds_grid_clear(board, undefined)
	gc_collect()
}

board_meet = function(xpos, ypos) {
	if player_board_pos[0] == xpos and player_board_pos[1] == ypos
		return false

	player_board_pos_previous[0] = player_board_pos[0]
	player_board_pos_previous[1] = player_board_pos[1]
	player_board_pos[0] = xpos
	player_board_pos[1] = ypos

	// #surface
	
	// #creating

	return true
}

state = SCENE_STATE.READY_1
board = ds_grid_create(GAME_BOARD_W, GAME_BOARD_H)
player_board_pos = [5, 5]
player_board_pos_previous = [5, 5]

board_clear()

game_scene = id
