function Physics() {}

/// @function check_horizontal(vector)
function check_horizontal(Distance) {
	return place_meeting(x + Distance, y, oSolid)
}

/// @function check_vertical(vector)
function check_vertical(Distance) {
	if 0 < Distance
		return place_meeting(x, y + Distance, oObstacle)
	else
		return place_meeting(x, y + Distance, oSolid)
}

/// @function move_x(vector)
function move_x(Vector) {
	var Distance = abs(Vector)

	if 0 < Vector {
		for (; 1 < Distance; Distance--) {
			if check_horizontal(1)
				exit
			x++
		}
		if !check_horizontal(Distance)
			x += Distance
	} else {
		for (; 1 < Distance; Distance--) {
			if check_horizontal(-1)
				exit
			x--
		}
		if !check_horizontal(Distance)
			x -= Distance
	}
}

/// @function move_y(vector)
function move_y(Vector) {
	var Distance = abs(Vector)

	if 0 < Vector {
		for (; 1 < Distance; Distance--) {
			if check_vertical(1)
				exit
			y++
		}
		if !check_vertical(Distance)
			y += Distance
	} else {
		for (; 1 < Distance; Distance--) {
			if check_vertical(-1)
				exit
			y--
		}
		if !check_vertical(Distance)
			y -= Distance
	}
}

/// @function move_x_slope(vector_x, vector_y)
function move_x(Vector) {
	var Distance = abs(Vector)

	if 0 < Vector {
		for (; 1 < Distance; Distance--) {
			if check_horizontal(1)
				exit
			x++
		}
		if !check_horizontal(Distance)
			x += Distance
	} else {
		for (; 1 < Distance; Distance--) {
			if check_horizontal(-1)
				exit
			x--
		}
		if !check_horizontal(Distance)
			x -= Distance
	}
}

