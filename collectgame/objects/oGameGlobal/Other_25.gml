/// @description Initialization
emplace_xell = function(prio_data, xpos, ypos) {
	board[# xpos, ypos] = make_xell(xpos, ypos)
}

emplace_special_xell = function(prio_data, xpos, ypos) {
	board[# xpos, ypos] = make_special_xell(prio_data, xpos, ypos)
}

get_ratio_from_diestance = function(xpos, ypos) {
	var calu = sqr(xpos - board_center_ind_coord_x)
	var calv = sqr(ypos - board_center_ind_coord_y)
	var distance = sqrt(calu + calv)
	return (distance / GAME_BOARD_NUMBER_H)
}

/// @function try_new_xell()
///@description trying to change to a new cell.
try_new_xell = function() {
	ds_grid_copy(board, global.board_default)
}

/// @function transition_to(x_index, y_index)
transition_to = function(xpos, ypos) {
	if player_board_pos[0] == xpos and player_board_pos[1] == ypos
		return false

	player_board_pos_previous[0] = player_board_pos[0]
	player_board_pos_previous[1] = player_board_pos[1]

	var thexell = board[# xpos, ypos]
	if is_struct(thexell) {
		// already there is a cell, screen transition with a surface
	} else if is_string(thexell) {
		// create a special cell
		emplace_special_xell(thexell, xpos, ypos)
	} else if is_real(thexell) {
		// create a cell
		emplace_xell(thexell, xpos, ypos)
	} else {
		throw "An error is occured when creating a cell!\nvalue: " + string(thexell)
	}
	board_transitioning = true
	board_transition_value = 0

	player_board_pos[0] = xpos
	player_board_pos[1] = ypos
	return true
}

///@description copy the default game board.
board_init = function() {
	
}

READY = function() {
	
}

IN_GAME = 10
TRANSITION = 11
PAUSED = 30
SCORE = 50
END = 80
CLEAN = 90
EXIT_TO_MENU = 99
