/// @description Initialization
enum SCENE_STATE {
	READY_1 = 0,
	READY_2 = 1,
	GAME = 10,
	SCORE = 50,
	END = 80,
	CLEAN = 90,
	EXIT_TO_MENU = 99
}

board_data = function() constructor {
	seed = random_get_seed()
	category = BOARD_CELL_CATEGORY.NORMAL
	level = 0
}

board_clear = function() {
	ds_grid_clear(board, 0)
	ds_grid_set(board, player_board_pos[0], player_board_pos[1], 1)
}

state = SCENE_STATE.READY_1
board = ds_grid_create(GAME_BOARD_WIDTH_MAX, GAME_BOARD_HEIGHT_MAX)
player_board_pos = [5, 5]
player_board_pos_previous = [5, 5]

board_clear()

game_scene = id
