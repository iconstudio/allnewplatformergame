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

game_scene = (function() {
	state = SCENE_STATE.READY_1

	board = ds_grid_create(GAME_BOARD_WIDTH_MAX, GAME_BOARD_HEIGHT_MAX)

	player_index = 0
	player_index_previous = 0
})()
