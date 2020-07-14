/// @description 기본 물리 초기화
xvel = 0
yvel = 0
grav = global.gravity_normal
fric = global.friction_ground

can_jump = false
was_on_ground = false
now_on_ground = false

// ** 일반적인 이동 함수 **
mover_x = move_horizontal_correction
update_x_normal = function() {
	var xresult = mover_x(xvel)
	if xresult != NONE {
		push()
	} else if fric != 0 {
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

update_y_normal = function() {
	var yresult = move_vertical(yvel)
	if yresult != NONE {
		if yresult == UP
			pop()
		else if yresult == DOWN
			thud()
	}
}

// ** 충돌 검사 안하는 이동 함수 **
update_x_flee = function() {
	x += xvel

	if fric != 0 {
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

update_y_flee = function() {
	y += yvel
}

// ** 중력 갱신 함수 **
update_yvel_normal = function() {
	if !now_on_ground and !was_on_ground {
		yvel += grav

		if global.yvel_max < yvel {
			yvel = global.yvel_max
		}
	}
}

update_yvel_flee = function() {}

update_yvel = update_yvel_normal

// ** 사용자 정의 이동 함수를 위해 함수 분리 **
update_x = update_x_normal
update_y = update_y_normal

function update_friction(on_ground) {
	if on_ground
		fric = global.friction_ground
	else
		fric = global.friction_air
}
