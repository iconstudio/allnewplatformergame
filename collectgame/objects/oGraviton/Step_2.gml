/// @description Physics Update
var CollideResult_x = NONE, Sign_x = sign(velocity_x)
if velocity_x != 0 {
	if !slope_mountable {
		CollideResult_x = horizontal_precedure(velocity_x)
	} else {
		CollideResult_x = horizontal_precedure(velocity_x, velocity_y)
	}

	if CollideResult_x != NONE {
		push()
	}
}

var check_bottom = check_vertical(1)
if !check_bottom {
	if grounded_state != TERRAIN_TYPE.AIR {
		if 0 < ground_coyote_period {
			if ground_coyote_time < ground_coyote_period {
				ground_coyote_time++
			} else {
				ground_coyote_time = 0
				grounded_state = TERRAIN_TYPE.AIR
			}
			
		} else {
			grounded_state = TERRAIN_TYPE.AIR
		}
	}
} else {
	grounded_state = TERRAIN_TYPE.GROUND
}
if grounded_state == TERRAIN_TYPE.AIR {
	if velocity_y < TERMINAL_SPEED_VERTICAL
		velocity_y = min(velocity_y + GRAVITY, TERMINAL_SPEED_VERTICAL)
}

if velocity_y != 0 {
	var CollideResult = vertical_precedure(velocity_y)

	if CollideResult == NONE {
		
	} else {
		if velocity_y < 0 {
			ceiling()
		} else {
			thud()
		}
	}
}
