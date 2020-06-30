/// @description 물리 초기화
xvel = 0
yvel = 0
grav = global.gravity_normal
fric = global.friction_ground

was_on_ground = false
now_on_ground = false

function solid_at(position_x, position_y) {
	return !place_free(position_x, position_y)
}

function ground_at(position_x, position_y) {
	return solid_at(position_x, position_y) or instance_place(position_x, position_y, oPlatform)
}

function ground_on_horizontal(distance) {
	var fx = floor(x + distance) + sign(distance)
	return ground_at(fx, y)
}

function ground_on_underneath(distance) {
	var fy
	if distance < 0
		return false
	else
		fy = y + distance

	return ground_at(x, fy)
}

function ground_on_top(distance) {
	var fy
	if 0 <= distance
		return false
	else
		fy = y - distance

	return solid_at(x, fy)
}

function move_horizontal(range) {
	if range == 0
		return NONE

	xprevious = x
	if range < 0 {
		move_contact_solid(180, abs(range))
		if xprevious - x < range
			return LEFT
	} else if 0 < range {
		move_contact_solid(0, abs(range))
		if x - xprevious < range
			return RIGHT
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
			if ground_on_top(1) {
				return UP
			} else {
				y--
			}
		}

		if surplus != 0 {
			if ground_on_top(surplus)
				return UP
			else
				y -= surplus
		}
	} else if 0 < range {
		for (;0 < distance; distance--) {
			if ground_on_underneath(1) {
				return DOWN
			} else {
				y++
			}
		}

		if surplus != 0 {
			if ground_on_underneath(surplus)
				return DOWN
			else
				y += surplus
		}
	}
	return NONE
}

update = function() {
	was_on_ground = false
	var on_ground = ground_on_underneath(yvel)
	if on_ground
		fric = global.friction_ground
	else
		fric = global.friction_air

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
		show_debug_message("yvel")
		var yresult = move_vertical(yvel)
		if yresult != NONE {
			if yresult == UP
				pop()
			else if yresult == DOWN
				thud()
		}
	}

	now_on_ground = ground_on_underneath(yvel)
	if !now_on_ground and on_ground
		was_on_ground = true

	if !now_on_ground and !was_on_ground {
		show_debug_message("grav: " + string(yvel))
		yvel += grav

		if global.yvel_max < yvel {
			show_debug_message("limit")
			yvel = global.yvel_max
		}
	}
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
