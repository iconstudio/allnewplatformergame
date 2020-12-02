/// @description Update Physics
if velocity_x != 0 {
	if 0 == slope_mount_max {
		horizontal_precedure(velocity_x)
	} else {
		horizontal_precedure(velocity_x, velocity_y, slope_mount_max)
	}

	try {
		friction_x = FRICTION_HORIZONTAL[grounded_state]
		if 0 != friction_x {
			if 0 < velocity_x {
				if friction_x < velocity_x
					velocity_x = max(velocity_x - friction_x, 0)
				else
					velocity_x = 0
			} else {
				if friction_x < abs(velocity_x)
					velocity_x = min(velocity_x + friction_x, 0)
				else
					velocity_x = 0
			}
		}
	} catch(e) {
		friction_x = 0
	}
}

var check_bottom = check_vertical(1)
if !check_bottom {
	if velocity_y < TERMINAL_SPEED_VERTICAL
		velocity_y = min(velocity_y + GRAVITY, TERMINAL_SPEED_VERTICAL)
}

if velocity_y != 0 {
	vertical_precedure(velocity_y)

	try {
		friction_y = FRICTION_VERTICAL[grounded_state]
		if 0 != friction_y {
			if 0 < velocity_y and GRAVITY <= velocity_y {
				if friction_y < velocity_y
					velocity_y = max(velocity_y - friction_y, 0)
				else
					velocity_y = 0
			} else if velocity_y < 0 {
				if friction_y < abs(velocity_y)
					velocity_y = min(velocity_y + friction_y, 0)
				else
					velocity_y = 0
			}
		}
	} catch(e) {
		friction_y = 0
	}
}
