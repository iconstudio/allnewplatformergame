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
	
}

cell_activate = function(xpos, ypos) {
	var bx = xpos * GAME_WIDTH
	var by = ypos * GAME_HEIGHT

	instance_activate_region(bx, by, bx + GAME_WIDTH, by + GAME_HEIGHT, true)
}

cell_deactivate = function(xpos, ypos) {
	var bx = xpos * GAME_WIDTH
	var by = ypos * GAME_HEIGHT

	instance_deactivate_region(bx, by, bx + GAME_WIDTH, by + GAME_HEIGHT, true, false)
	instance_activate_object(oPlayer)
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

	var data = board[# xpos, ypos]
	if is_undefined(data) {
		// creating
		make_cell(xpos, ypos)
	} else {
		// surface
		
	}

	cell_deactivate(player_board_pos[0], player_board_pos[1])
	cell_activate(xpos, ypos)

	player_board_pos[0] = xpos
	player_board_pos[1] = ypos
	return true
}

state = SCENE_STATE.READY_1
board = ds_grid_create(GAME_BOARD_NUMBER_W, GAME_BOARD_NUMBER_H)
player_board_pos = [5, 5]
player_board_pos_previous = [5, 5]
cell_temp = new List()
board_clear()

game_scene = id
