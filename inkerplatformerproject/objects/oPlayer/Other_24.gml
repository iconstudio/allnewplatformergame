/// @description 스텝 이벤트
global.playerid = id
// ** 일반 공격 **
/*
if global.io_pressed_skill_1 {
	
}

// ** 특수 기술 **
if global.io_pressed_skill_2 {
	
} else if global.io_pressed_skill_3 {
	
} else if global.io_pressed_skill_4 {
	
}*/

var was_left = move_key_peek == LEFT, was_right = move_key_peek == RIGHT
if !global.io_left and !global.io_right {
	move_key_peek = NONE
}
else if (global.io_pressed_left and global.io_right and was_right)
or (global.io_left and !global.io_right)
or (!global.io_pressed_right and global.io_left and was_left) {
	move_key_peek = LEFT
}
else if (global.io_pressed_right and global.io_left and was_left)
or (global.io_right and !global.io_left)
or (!global.io_pressed_left and global.io_right and was_right) {
	move_key_peek = RIGHT
}
else {
	move_key_peek = NONE
}

var mover = integral(move_key_peek == RIGHT, 1, integral(move_key_peek == LEFT, -1, 0))
if mover != 0 {
	move_dir = mover
	if move_dir == -1 { // 왼쪽
		if -move_spd < xvel {
			xvel -= move_spd / move_acc_ratio
			if xvel < -move_spd
				xvel = -move_spd
		}
	} else { // 오른쪽
		if xvel < move_spd {
			xvel += move_spd / move_acc_ratio
			if move_spd < xvel
				xvel = move_spd
		}
	}
} else {
	move_dir = 0
}
if xvel != 0 and !instance_exists(attack_slash)
	img_xscale = sign(xvel)

jump_fore_predicate.update()
jump_cliffoff_predicate.update()

if !jumping {
	if global.io_pressed_jump {
		jump_fore_predicate.reset()
	}

	if was_on_ground {
		jump_cliffoff_predicate.reset() // 계속 초기화
		was_on_ground = false
	}
}

can_jump = now_on_ground or jump_cliffoff_predicate.get() < 1
var check_top = wall_on_top(1)
if can_jump and !jumping and !check_top {
	if jump_fore_predicate.get() < 1 {
		do_jump()
	}
}

if jumping {
	if check_top {
		jump_end()
	} else if jump_predicate.update() == 1 or global.io_released_jump {
		jump_end()
	}
}

global.playerpos[0] = x
global.playerpos[1] = y
global.playerpos_visible[0] = x
global.playerpos_visible[1] = y
