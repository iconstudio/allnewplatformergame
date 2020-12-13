function Physics() {
	static set_mass = function(Mass) {
		mass = Mass
		mass_ratio = (Mass + 2) * 0.25
		slope_mountable = (Mass != PHYSICS_MASS.TINY)
	}

	mass = PHYSICS_MASS.NORMAL
	mass_ratio = 0.5
	slope_mountable = true
	velocity_x = 0
	velocity_y = 0
	friction_x = 0
	friction_y = 0
}

/// @function make_speed(speed)
function make_speed(Speed) { return Speed * PIXEL_PER_STEP }

/// @function check_solid_by(vector_x, vector_y)
function check_solid_by(Distance_x, Distance_y) {
	return place_meeting(x + Distance_x, y + Distance_y, oSolid)
}

/// @function check_block_by(vector_x, vector_y)
function check_block_by(Distance_x, Distance_y) {
	return place_meeting(x + Distance_x, y + Distance_y, oBlocks)
}

/// @function check_plate_by(vector_x, vector_y)
function check_plate_by(Distance_x, Distance_y) {
	return place_meeting(x + Distance_x, y + Distance_y, oPlatform)
}

/// @function check_solid_horizontal(vector)
function check_solid_horizontal(Distance) {
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

/// @function check_solid_box_horizontal(vector_x, vector_y)
function check_solid_box_horizontal(Vector_x, Vector_y) {
	var result = false
	if Vector_x < 0
		result = (noone != collision_rectangle(bbox_left + Vector_x, bbox_top + Vector_y, bbox_left, bbox_bottom + Vector_y, oSolid, true, true))
	else
		result = (noone != collision_rectangle(bbox_right, bbox_top + Vector_y, bbox_right + Vector_x, bbox_bottom + Vector_y, oSolid, true, true))
	return result
}

/// @function check_solid_box_vertical(vector_x, vector_y)
function check_solid_box_vertical(Vector_x, Vector_y) {
	var result = false
	if Vector_y < 0
		result = (noone != collision_rectangle(bbox_left + Vector_x, bbox_top + Vector_y, bbox_right + Vector_x, bbox_top, oSolid, true, true))
	else
		result = (noone != collision_rectangle(bbox_left + Vector_x, bbox_bottom, bbox_right + Vector_x, bbox_bottom + Vector_y, oSolid, true, true))
	return result
}

/// @function check_block_box_vertical(vector_x, vector_y)
function check_block_box_vertical(Vector_x, Vector_y) {
	var result = false
	if Vector_y < 0
		result = (noone != collision_rectangle(bbox_left + Vector_x, bbox_top + Vector_y, bbox_right + Vector_x, bbox_top, oBlocks, true, true))
	else
		result = (noone != collision_rectangle(bbox_left + Vector_x, bbox_bottom, bbox_right + Vector_x, bbox_bottom + Vector_y, oBlocks, true, true))
	return result
}

/// @function check_what_horizontal(vector)
function check_what_horizontal(Distance) {
	return instance_place(x + Distance, y, oSolid)
}

/// @function check_solid_line(vector_x, vector_y)
function check_solid_line(Distance_x, Distance_y) {
	return (noone != collision_line(x, y, x + Distance_x, y + Distance_y, oSolid, true, true))
}

/// @function move_x(vector_pixel)
function move_x(Vector) {
	if 0 == Vector
		return NONE

	var Distance = abs(Vector)
	var Part = floor(Distance)
	if 0 < Vector {
		if Part != 0
			move_contact_solid(0, Part)
		if check_solid_horizontal(1)
			return RIGHT

		Distance -= Part
		if Distance != 0 and !check_solid_horizontal(Distance)
			x += Distance
		move_outside_solid(180, 1)
	} else {
		if Part != 0
			move_contact_solid(180, Part)
		if check_solid_horizontal(-1)
			return LEFT

		Distance -= Part
		if Distance != 0 and !check_solid_horizontal(-Distance)
			x -= Distance
		move_outside_solid(0, 1)
	}
	return NONE
}

/// @function move_y(vector_pixel)
function move_y(Vector) {
	if 0 == Vector
		return NONE

	var Distance = abs(Vector)
	if 0 < Vector {
		if check_block_box_vertical(0, Vector) {
			for (; 1 < Distance; Distance--) {
				if check_vertical(1)
					return DOWN
				y++
			}
			Distance = frac(Distance)
			if !check_vertical(Distance)
				y += Distance
			return DOWN
		} else {
			y += Vector
			return NONE
		}
	} else {
		if check_solid_box_vertical(0, Vector) {
			move_contact_solid(90, Distance)
			return UP
		} else {
			y += Vector
			return NONE
		}
	}
}

/// @function accel_x(vector)
function accel_x(Vector) {
	return move_x(make_speed(Vector))
}

/// @function accel_y(vector)
function accel_y(Vector) {
	return move_y(make_speed(Vector))
}

/// @function accel_x_slope(vector_x, vector_y)
function accel_x_slope(Vector_x, Vector_y) {
	if 0 == Vector_x
		return NONE

	var Vector = make_speed(Vector_x), Identity = sign(Vector_x)
	var Distance = abs(Vector)
	var Result = NONE

	if !check_solid_horizontal(Vector) {
		Result = move_x(Vector)
		if 0 <= Vector_y
			move_y(SLOPE_MOUNT_VALUE)
	} else {
		var Cx = 0, Cy = -SLOPE_MOUNT_VALUE - (SLOPE_RATIO * Distance)
		for (var i = Distance; 0 < i; --i) {
			Cx = Identity * i
			if !check_solid_by(Cx, Cy) and !check_solid_line(Cx, Cy) {
				move_y(Cy)
				Result = move_x(Cx)
				move_y(-Cy)
				break
			}
			Cy += SLOPE_RATIO
		}
	}

	return Result
}

//TODO: complete y grapping
/// @function accel_y_slope(vector_x, vector_y)
function accel_y_slope(Vector_x, Vector_y) {
	var Distance = abs(make_speed(Vector_y))
	var Part = floor(Distance)
	var MoveDistance = Part
	var MountDistance = 3 // 30cm

	xprevious = x
	if 0 < Vector_x {
		if Part != 0 {
			move_contact_solid(0, Part)
			MoveDistance = x - xprevious
		}

		if check_solid_horizontal(1) {
			if MoveDistance < Part { // go up to slope
				move_contact_solid(90, MountDistance)
				//TODO: using add to coordinate x
				move_contact_solid(0, Part - MoveDistance)
				move_y(MountDistance)
			} else {
				return RIGHT
			}
		} else {
			if 0 <= Vector_y {
				move_y(Part * 2)
			} else {
				
			}
		}

		Distance -= Part
		if Distance != 0 and !check_solid_horizontal(Distance)
			x += Distance
		move_outside_solid(180, 1)
	} else {
		if Part != 0 {
			move_contact_solid(180, Part)
			MoveDistance = xprevious - x
		}

		if check_solid_horizontal(-1) {
			if MoveDistance < Part { // go up to slope
				move_y(-MountDistance)
				move_contact_solid(180, Part - MoveDistance)
				move_y(MountDistance)
			} else {
				return LEFT
			}
		} else {
			if 0 <= Vector_y {
				move_y(Part * 2)
			} else {
				
			}
		}

		Distance -= Part
		if Distance != 0 and !check_solid_horizontal(Distance)
			x -= Distance
		move_outside_solid(0, 1)
	}

	return NONE
}
