/// @description 초기화
event_user(15)

update = function() {
	was_on_ground = false
	var on_ground = wall_on_underneath(yvel)
	update_friction(on_ground)

	if xvel != 0 {
		//show_debug_message("xvel")
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
