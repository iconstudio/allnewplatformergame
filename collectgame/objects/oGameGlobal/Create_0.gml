/// @description Initialization
event_user(15)

mode = GAME_MANAGER_MODES.READY
game_state = READY

test_maze = new MazeGenerator(GAME_BOARD_NUMBER_S, GAME_BOARD_NUMBER_S)
//test_maze.generate()

initial_seed = random_get_seed()
maze = array_create(GAME_BOARD_NUMBER_S)
for (var i = 0; i < GAME_BOARD_NUMBER_S; ++i)
	maze[i] = array_create(GAME_BOARD_NUMBER_S, 0)

board = ds_grid_create(GAME_BOARD_NUMBER_S, GAME_BOARD_NUMBER_S)
board_transitioning = false
board_transition_value = 1.0

board_center_ind_coord_x = GAME_BOARD_NUMBER_H// + 0.5
board_center_ind_coord_y = GAME_BOARD_NUMBER_H// + 0.5
player_board_pos = [GAME_BOARD_NUMBER_H, GAME_BOARD_NUMBER_H]
player_board_pos_previous = [GAME_BOARD_NUMBER_H, GAME_BOARD_NUMBER_H]
xell_temp = new List()

emplace_xell(0, player_board_pos[0], player_board_pos[1])

game_scene = id

alarm[0] = 1
