/// @description Initialization
emplace_xell = function(prio_data, xpos, ypos) {
	board[# xpos, ypos] = make_xell(xpos, ypos)
}

get_ratio_from_diestance = function(xpos, ypos) {
	var calu = sqr(xpos - board_center_ind_coord_x)
	var calv = sqr(ypos - board_center_ind_coord_y)
	var distance = sqrt(calu + calv)
	return (distance / GAME_BOARD_NUMBER_H)
}

board_meet = function(xpos, ypos) {
	if player_board_pos[0] == xpos and player_board_pos[1] == ypos
		return false

	player_board_pos_previous[0] = player_board_pos[0]
	player_board_pos_previous[1] = player_board_pos[1]

	var thexell = board[# xpos, ypos]
	if is_struct(thexell) {
		// already there is a cell, screen transition with a surface
	} else if is_string(thexell) {
		// create a special cell
		thexell = make_special_xell(thexell, xpos, ypos)
		board[# xpos, ypos] = thexell
	} else if is_real(thexell) {
		// create a cell
		emplace_xell(thexell, xpos, ypos)
	} else {
		throw "An error is occured when creating a cell!\nvalue: " + string(thexell)
	}
	board_transitioning = true
	board_transition_value = 0

	//cell_deactivate(player_board_pos[0], player_board_pos[1])
	//cell_activate(xpos, ypos)

	player_board_pos[0] = xpos
	player_board_pos[1] = ypos
	return true
}

///@description clear the board and fill it with diff indicators.
board_init = function() {
	var range = GAME_BOARD_NUMBER_H + 3
	ds_grid_clear(board, DIFFICULTY_MAX) // 10

	var idiff = DIFFICULTY_MAX - 1, i
	for (i = 0; 0 < idiff and i < DIFFICULTY_MAX and 0 < range; ++i) {
		ds_grid_add_disk(board, GAME_BOARD_NUMBER_H, GAME_BOARD_NUMBER_H, range, -1)
		range -= global.diff_board_distribution[idiff]
		idiff--
	}
	ds_grid_set(board, GAME_BOARD_NUMBER_H, GAME_BOARD_NUMBER_H, 0)
}

state = SCENE_STATE.READY_1
initial_seed = random_get_seed()
board = ds_grid_create(GAME_BOARD_NUMBER_S, GAME_BOARD_NUMBER_S)
board_transitioning = false
board_transition_value = 1.0

board_center_ind_coord_x = GAME_BOARD_NUMBER_H// + 0.5
board_center_ind_coord_y = GAME_BOARD_NUMBER_H// + 0.5
player_board_pos = [GAME_BOARD_NUMBER_H, GAME_BOARD_NUMBER_H]
player_board_pos_previous = [GAME_BOARD_NUMBER_H, GAME_BOARD_NUMBER_H]
xell_temp = new List()

board_init()
emplace_xell(0, player_board_pos[0], player_board_pos[1])

game_scene = id
