 /// @description Initialization
event_inherited()

action_status = PLAYER_ACTION_MODES.IDLE

ground_coyote_period = COYOTE_GROUND_PERIOD

Collection = ds_list_create()

move_key_anchor = RIGHT
move_dir = 0
move_speed = KILOMETER_PER_HOUR(40)
move_accel = KILOMETER_PER_HOUR(3)
jump_speed = KILOMETER_PER_HOUR(110)
jump_cooldown = seconds(0.05)

jump = function() {
	wall_coyote_duation = 0
	velocity_y = -jump_speed
	if move_key_anchor == NONE {
		if velocity_x != 0 {
			velocity_x += move_accel * sign(velocity_x)
		}
	} else { // add a little speed
		if velocity_x == 0 {
			velocity_x += move_accel * sign(move_key_anchor)
		} else { // add a little speed
			velocity_x += move_accel * sign(velocity_x)
		}
	}
}
