/// @description Initialization
Physics()
horizontal_precedure = accel_x_slope
vertical_precedure = accel_y

/// @function push()
push = function() {
	
}

/// @function ceiling()
ceiling = function() {
	if velocity_y < -POP_SPEED_VERTICAL
		velocity_y = -POP_SPEED_VERTICAL
	else
		velocity_y *= 0.85
	y = floor(y)
	move_outside_solid(270, -1)
}

/// @function thud()
thud = function() {
	velocity_y = 0
	y = floor(y)
	move_outside_solid(90, -1)
}

actions = []
