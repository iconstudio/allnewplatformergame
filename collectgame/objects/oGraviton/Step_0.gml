/// @description Things Update
if velocity_x != 0 {
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

if velocity_y != 0 {
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
