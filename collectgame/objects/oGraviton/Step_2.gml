/// @description Physics Update
var CollideResult_x = NONE
if velocity_x != 0 {
	if !slope_mountable {
		CollideResult_x = horizontal_precedure(velocity_x)
	} else {
		CollideResult_x = horizontal_precedure(velocity_x, velocity_y)
	}

	if CollideResult_x != NONE { // push
		velocity_x = 0
	}
}

var check_bottom = check_vertical(1)
if !check_bottom {
	grounded_state = TERRAIN_TYPE.AIR
	if velocity_y < TERMINAL_SPEED_VERTICAL
		velocity_y = min(velocity_y + GRAVITY, TERMINAL_SPEED_VERTICAL)
} else {
	grounded_state = TERRAIN_TYPE.GROUND
}

if velocity_y != 0 {
	var CollideResult = vertical_precedure(velocity_y)

	if CollideResult != NONE {
		if velocity_y < 0 { // pop
			if CollideResult_x == NONE {
				var repulse_y = max(1, velocity_x * mass_ratio)
				velocity_y = max(0, velocity_y - repulse_y)
			} else {
				velocity_y *= 0.9
			}
		} else { // thud
			velocity_y = 0
		}
	}
}
