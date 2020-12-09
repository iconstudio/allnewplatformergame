/// @description Initialization
grounded_state = TERRAIN_TYPE.GROUND

Physics()
horizontal_precedure = accel_x_slope
vertical_precedure = accel_y

/// @function ceiling()
ceiling = function() {
	velocity_y = 0
	y = ceil(y)
	move_outside_solid(270, 1)
}

/// @function thud()
thud = function() {
	velocity_y = 0
	y = ceil(y)
	move_outside_solid(90, 1)
}

actions = []
