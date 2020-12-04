/// @description Physics Update
if velocity_x != 0 {
	var CollideResult
	if 0 == slope_mount_max {
		CollideResult = horizontal_precedure(velocity_x)
	} else {
		CollideResult = horizontal_precedure(velocity_x, velocity_y, slope_mount_max)
	}

	
}

var check_bottom = check_vertical(1)
if !check_bottom {
	if velocity_y < TERMINAL_SPEED_VERTICAL
		velocity_y = min(velocity_y + GRAVITY, TERMINAL_SPEED_VERTICAL)
}

if velocity_y != 0 {
	var CollideResult = vertical_precedure(velocity_y)
	
}