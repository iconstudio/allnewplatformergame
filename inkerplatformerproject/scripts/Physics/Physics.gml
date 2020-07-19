function solid_at(position_x, position_y) {
	return !place_free(position_x, position_y)
}

function ground_at(position_x, position_y) {
	return solid_at(position_x, position_y) or instance_place(position_x, position_y, oPlatform)
}

function ground_at_precise(position_x, position_y) {
	var condition = solid_at(position_x, position_y)

	var in_platform = instance_place(x, y, oPlatform)
	if in_platform == noone {
		var on_platform = instance_place(position_x, position_y, oPlatform)
		if on_platform != noone
			condition = true
	} else {
		var under_platform = collision_line(bbox_left, bbox_bottom + 1, bbox_right - 1, bbox_bottom + 1, oPlatform, true, true)
		if under_platform != noone and in_platform != under_platform
			condition = true
	}

	return condition
}

function wall_on_horizontal(distance) {
	var fx = x + distance + sign(distance)
	return solid_at(fx, y)
}

function wall_on_position(x_distance, y_distance) {
	var fx = x + x_distance + sign(x_distance)
	var fy = y + y_distance + sign(y_distance)
	if y <= fy
		return ground_at(fx, fy)
	else
		return solid_at(fx, fy)
}

function wall_on_underneath(distance) {
	var fy
	if distance < 0
		return false
	else if distance == 0
		fy = y + 1 
	else
		fy = y + distance

	return ground_at_precise(x, fy)
}

function wall_on_top(distance) {
	var fy
	if distance < 0
		return false
	else if distance == 0
		fy = y - 1 
	else
		fy = y - distance

	return solid_at(x, fy)
}

function move_horizontal(range) {
	if wall_on_horizontal(range) {
		if range < 0 {
			move_contact_solid(180, abs(range) + 1)
			return LEFT
		} else if 0 < range {
			move_contact_solid(0, abs(range) + 1)
			return RIGHT
		}
	} else {
		x += range
	}
	return NONE
}

function move_horizontal_correction(range) {
	if wall_on_horizontal(range) {
		if !wall_on_position(range, 1) {
			y += 1
		} else if !wall_on_position(range, -1) {
			if !wall_on_position(range, -2) {
				y -= 2
			} else {
				y -= 1
			}
		} else {
			if range < 0 {
				move_contact_solid(180, abs(range) + 1)
				return LEFT
			} else if 0 < range {
				move_contact_solid(0, abs(range) + 1)
				return RIGHT
			}
		}
	} else {
		x += range
	}
	return NONE
}

function move_vertical(range) {
	var distance = floor(abs(range))
	var surplus = frac(abs(range))
	if range == 0 {
		return NONE
	}

	var result = NONE
	if range < 0 {
		for (;0 < distance; distance--) {
			if wall_on_top(1) {
				move_contact_solid(90, 1)
				result = UP
				break
			} else {
				y--
			}
		}

		if surplus != 0 {
			if wall_on_top(surplus) {
				move_contact_solid(90, 1)
				result = UP
			} else {
				y -= surplus
			}
		}
	} else if 0 < range {
		for (;0 < distance; distance--) {
			if wall_on_underneath(1) {
				result = DOWN
				break
			} else {
				y++
			}
		}

		if surplus != 0 {
			if wall_on_underneath(surplus) {
				result = DOWN
			} else {
				y += surplus
			}
		}
	}

	if ground_at(x, y) {
		for (var i = 1; i <= 2; ++i) {
			if ground_at(x, y -	1) {
				break
			} else {
				y--
			}
		}
	}

	return result
}

function get_friction_ground() {
	return global.friction_ground
}

function get_friction_air() {
	return global.friction_air
}
