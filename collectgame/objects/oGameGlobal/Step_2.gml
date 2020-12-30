/// @description Update
if state == SCENE_STATE.GAME {
	var player_dir_x = 0, player_dir_y = 0
	if global.player_x < view_x
		player_dir_x = -1
	else if view_x + XELL_WIDTH <= global.player_x
		player_dir_x = 1

	if global.player_y < view_y
		player_dir_y = -1
	else if view_y + XELL_HEIGHT <= global.player_y
		player_dir_y = 1

	if player_dir_x == 0 or player_dir_y == 0 {
		board_meet(player_board_pos[0] + player_dir_x, player_board_pos[1] + player_dir_y)

		//var trans_x = view_x + player_dir_x * XELL_WIDTH
		//var trans_y = view_y + player_dir_y * XELL_HEIGHT
		
	}

	//var player_in_view = point_in_rectangle(global.player_x, global.player_y, view_x, view_y, view_x + XELL_WIDTH, view_y + XELL_HEIGHT)
}
