/// @description 초기화
event_user(15)

update = function() {
	was_on_ground = false
	var on_ground = wall_on_underneath(yvel)
	update_friction(on_ground)

	if xvel != 0 {
		update_x()
	}

	if yvel != 0 {
		update_y()
	}

	now_on_ground = wall_on_underneath(yvel)
	if !now_on_ground and on_ground
		was_on_ground = true

	// ** 중력 **
	update_yvel()

	// ** 스텝 **
	event_user(14)
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
