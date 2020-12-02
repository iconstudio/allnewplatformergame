function Physics() {
	static set_mass = function(Mass) {
		mass = Mass
		slope_mount_max = dsin(sqr(3 - Mass) * 15) * 3
	}

	mass = PHYSICS_MASS.NORMAL
	velocity_x = 0
	velocity_y = 0
	friction_x = 0
	friction_y = 0
	slope_mount_max = dsin(45) * 3

	horizontal_precedure = accel_x
	vertical_precedure = accel_y
}
/// @function make_speed(speed)
function make_speed(Speed) { return Speed * PIXEL_PER_STEP }

/// @function check_block_by(vector_x, vector_y)
function check_block_by(Distance_x, Distance_y) {
	return place_meeting(x + Distance_x, y + Distance_y, oObstacle)
}

/// @function check_solid_by(vector_x, vector_y)
function check_solid_by(Distance_x, Distance_y) {
	return place_meeting(x + Distance_x, y + Distance_y, oSolid)
}

/// @function check_plate_by(vector_x, vector_y)
function check_plate_by(Distance_x, Distance_y) {
	return place_meeting(x + Distance_x, y + Distance_y, oPlatform)
}

/// @function check_horizontal(vector)
function check_horizontal(Distance) {
	return place_meeting(x + Distance, y, oSolid)
}

/// @function check_vertical(vector)
function check_vertical(Distance) {
	if 0 < Distance {
		if place_meeting(x, y + Distance, oSolid) {
			return true
		} else {
			var condition = false
			var in_platform = instance_place(x, y, oPlatform)
			if in_platform == noone {
				if place_meeting(x, y + Distance, oPlatform)
					condition = true
			} else {
				var under_platform = collision_line(bbox_left, bbox_bottom + 1, bbox_right - 1, bbox_bottom + 1, oPlatform, true, true)
				if under_platform != noone and in_platform != under_platform
					condition = true
			}
		
			return condition
		}
	} else {
		return place_meeting(x, y + Distance, oSolid)
	}
}

/// @function move_x(vector)
function move_x(Vector) {
	var Distance = abs(Vector)
	if 0 < Vector {
		for (; 1 < Distance; Distance--) {
			if check_horizontal(1) {
				move_contact_solid(0, -1)
				return Distance
			}
			x++
		}
		if !check_horizontal(Distance)
			x += Distance
	} else {
		for (; 1 < Distance; Distance--) {
			if check_horizontal(-1) {
				move_contact_solid(180, -1)
				return Distance
			}
			x--
		}
		if !check_horizontal(-Distance)
			x -= Distance
	}
	return abs(Vector)
}

/// @function move_y(vector)
function move_y(Vector) {
	var Distance = abs(Vector)
	if 0 < Vector {
		for (; 1 < Distance; Distance--) {
			if check_vertical(1)
				return Distance
			y++
		}
		if !check_vertical(Distance)
			y += Distance
	} else {
		for (; 1 < Distance; Distance--) {
			if check_vertical(-1)
				return Distance
			y--
		}
		if !check_vertical(-Distance)
			y -= Distance
	}
	return abs(Vector)
}

/// @function accel_x(vector)
function accel_x(Vector) {
	return move_x(make_speed(Vector))
}

/// @function accel_y(vector)
function accel_y(Vector) {
	return move_y(make_speed(Vector))
}

/// @function accel_x_slope(vector_x, vector_y, mount)
function accel_x_slope(Vector_x, Vector_y, Mount) {
	var Distance = abs(make_speed(Vector_x))
	var CanMount = (0 < Mount)
	var MountDistance = Mount * 2//Mount + Mount * Distance

	if 0 < Vector_x {
		for (; 1 < Distance; Distance--) {
			if check_horizontal(1) {
				if CanMount {
					move_y(-MountDistance)
					if !check_horizontal(1)
						x++

					if Vector_y <= 0 {
						move_y(MountDistance)
					}
				} else {
					return Distance
				}
			} else {
				x++
				if 0 <= Vector_y {
					move_y(MountDistance)
				}
			}
		}
		if !check_horizontal(Distance)
			x += Distance
	} else {
		for (; 1 < Distance; Distance--) {
			if check_horizontal(-1) {
				if CanMount {
					move_y(-MountDistance)
					if !check_horizontal(-1)
						x--

					if Vector_y <= 0 {
						move_y(MountDistance)
					}
				} else {
					return Distance
				}
			} else {
				x--
				if 0 <= Vector_y {
					move_y(MountDistance)
				}
			}
		}
		if !check_horizontal(Distance)
			x -= Distance
	}
	return abs(Vector)
}

