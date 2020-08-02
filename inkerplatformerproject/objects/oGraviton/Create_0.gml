/// @description 기본 물리 초기화
xvel = 0
yvel = 0
grav = global.gravity_normal
xfric = get_friction_ground()
yfric = xfric // *

can_jump = false
was_on_ground = false
now_on_ground = false

// ** 일반적인 이동 함수 **
mover_x = move_horizontal_correction
updater_x_normal = function() {
	var xresult = mover_x(xvel)
	if xresult != NONE {
		push()
	} else if xfric != 0 {
		if abs(xvel) <= xfric {
			xvel = 0
		} else {
			if xvel < 0
				xvel += xfric
			else
				xvel -= xfric
		}
	}
}

updater_y_normal = function() {
	var yresult = move_vertical(yvel)
	if yresult != NONE {
		if yresult == UP
			pop()
		else if yresult == DOWN
			thud()
	}
}

// ** 충돌 검사 안하는 이동 함수 **
updater_x_flee = function() {
	x += xvel

	if xfric != 0 {
		if abs(xvel) <= xfric {
			xvel = 0
		} else {
			if xvel < 0
				xvel += xfric
			else
				xvel -= xfric
		}
	}
}

updater_y_flee = function() {
	y += yvel

	if yfric != 0 {
		if abs(yvel) <= yfric {
			yvel = 0
		} else {
			if yvel < 0
				yvel += yfric
			else
				yvel -= yfric
		}
	}
}

// ** 중력 갱신 함수 **
updater_yvel_normal = function() {
	if !now_on_ground and !was_on_ground {
		yvel += grav

		if global.yvel_max < yvel {
			yvel = global.yvel_max
		}
	}
}

updater_yvel_flee = FUNC_NULL

updater_yvel = updater_yvel_normal

// ** 사용자 정의 이동 함수를 위해 함수 분리 **
updater_x = updater_x_normal
updater_y = updater_y_normal

function set_friction_x(value) {
	xfric = value
	return self
}

function set_friction_y(value) {
	yfric = value
	return self
}

function update_friction(on_ground) {
	if on_ground
		set_friction_x(get_friction_ground())
	else
		set_friction_x(get_friction_air())
}

update_physics = function() {
	was_on_ground = false
	var on_ground = wall_on_underneath(yvel)
	update_friction(on_ground)

	if xvel != 0 {
		updater_x()
		show_debug_message(string(updater_x))
	}

	if yvel != 0 {
		updater_y()
		//show_debug_message(string(updater_y))
	}

	now_on_ground = wall_on_underneath(yvel)
	if !now_on_ground and on_ground
		was_on_ground = true

	// ** 중력 **
	updater_yvel()
	//show_debug_message(string(updater_yvel))
}

/* 좌우 부딫힘 */
push = function() {
	xvel = 0
}

/* 천장 부딫힘 */
pop = function() {
	if yvel < 0 {
		move_outside_solid(270, 1)
		yvel = 0
	}
}

/* 바닥 부딫힘 */
thud = function() {
	if 0 < yvel {
		move_outside_solid(90, 1)
		yvel = 0
	}
}
