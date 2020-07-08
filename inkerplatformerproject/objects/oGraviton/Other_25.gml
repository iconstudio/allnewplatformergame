/// @description 기본 물리 초기화
xvel = 0
yvel = 0
grav = global.gravity_normal
fric = global.friction_ground

can_jump = false
was_on_ground = false
now_on_ground = false

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

function move_vertical(range) {
	var distance = floor(abs(range))
	var surplus = frac(abs(range))
	if range == 0 {
		return NONE
	} else {
		
	}

	if range < 0 {
		for (;0 < distance; distance--) {
			if wall_on_top(1) {
				move_contact_solid(90, 1)
				return UP
			} else {
				y--
			}
		}

		if surplus != 0 {
			if wall_on_top(surplus) {
				move_contact_solid(90, 1)
				return UP
			} else {
				y -= surplus
			}
		}
	} else if 0 < range {
		for (;0 < distance; distance--) {
			if wall_on_underneath(1) {
				return DOWN
			} else {
				y++
			}
		}

		if surplus != 0 {
			if wall_on_underneath(surplus)
				return DOWN
			else
				y += surplus
		}
	}
	return NONE
}

function update_friction(on_ground) {
	if on_ground
		fric = global.friction_ground
	else
		fric = global.friction_air
}
