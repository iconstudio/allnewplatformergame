/// @description 물리 초기화
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

function wall_on_horizontal(distance) {
	var fx = x + distance + sign(distance)
	return solid_at(fx, y)
}

function wall_on_underneath(distance) {
	var fy
	if distance < 0
		return false
	else
		fy = y + distance

	return ground_at(x, fy)
}

function wall_on_top(distance) {
	var fy
	if 0 <= distance
		return false
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

update = function() {
	was_on_ground = false
	var on_ground = wall_on_underneath(yvel)
	update_friction(on_ground)

	if xvel != 0 {
		show_debug_message("xvel")
		var xresult = move_horizontal(xvel)
		if xresult != NONE {
			push()
		} else {
			if abs(xvel) <= fric {
				xvel = 0
			} else {
				if xvel < 0
					xvel += fric
				else
					xvel -= fric
			}
		}
	}

	if yvel != 0 {
		//show_debug_message("yvel")
		var yresult = move_vertical(yvel)
		if yresult != NONE {
			if yresult == UP
				pop()
			else if yresult == DOWN
				thud()
		}
	}

	now_on_ground = wall_on_underneath(yvel)
	if !now_on_ground and on_ground
		was_on_ground = true

	if !now_on_ground and !was_on_ground {
		//show_debug_message("grav: " + string(yvel))
		yvel += grav

		if global.yvel_max < yvel {
			//show_debug_message("limit")
			yvel = global.yvel_max
		}
	}
	can_jump = now_on_ground or was_on_ground
}

/* 좌우 부딫힘 */
push = function() {
	xvel = 0
}

/* 천장 부딫힘 */
pop = function() {
	move_outside_solid(270, 1)
}

/* 바닥 부딫힘 */
thud = function() {
	yvel = 0
	move_outside_solid(90, 1)
}
