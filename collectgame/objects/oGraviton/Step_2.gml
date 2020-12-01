/// @description Physics
velocity_x = test * 3
if velocity_x != 0 {
	var vector_x = delta(velocity_x)

	var friction_x = 0
	try {
		friction_x = FRICTION_HORIZONTAL[grounded_state]
	} catch(e) {
		friction_x = 0
	}

	horizontal_precedure(vector_x)

	if 0 != friction_x {
		if 0 < velocity_x {
			if friction_x < vector_x
				velocity_x = max(velocity_x - friction_x, 0)
			else
				velocity_x = 0
		} else {
			if friction_x < abs(vector_x)
				velocity_x = min(velocity_x + friction_x, 0)
			else
				velocity_x = 0
		}
	}
}

var check_bottom = check_vertical(1)
if !check_bottom {
	velocity_y += GRAVITY
}

if velocity_y != 0 {
	var vector_y = delta(velocity_y)

	var friction_y = 0
	try {
		friction_y = FRICTION_VERTICAL[grounded_state]
	} catch(e) {
		friction_y = 0
	}

	vertical_precedure(vector_y)

	if 0 != friction_y {
		if 0 < velocity_y and GRAVITY <= velocity_y {
			if friction_y < vector_y
				velocity_y = max(velocity_y - friction_y, 0)
			else
				velocity_y = 0
		} else if velocity_y < 0 {
			if friction_y < abs(vector_y)
				velocity_y = min(velocity_y + friction_y, 0)
			else
				velocity_y = 0
		}
	}
}
