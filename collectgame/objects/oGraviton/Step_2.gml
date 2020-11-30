/// @description Physics
velocity_x = 1

if velocity_x != 0 {
	var abs_x = abs(velocity_x)
	var delta_x = delta(abs_x)

	var friction_x = 0
	try {
		friction_x = FRICTION_HORIZONTAL[grounded_state]
	}	catch(e) {
		friction_x = 0
	}

	if 0 < velocity_x {
		for (; 0 < delta_x and place_free(x + 1, y); x++) delta_x--
		if friction_x < abs_x
			velocity_x = max(velocity_x - friction_x, 0)
		else
			velocity_x = 0
	} else if velocity_x < 0 {
		for (; 0 < delta_x and place_free(x - 1, y); x--) delta_x--
		if friction_x < abs_x
			velocity_x = min(velocity_x + friction_x, 0)
		else
			velocity_x = 0
	}

	
}

if velocity_y != 0 {
	
}
