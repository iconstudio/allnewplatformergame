event_inherited()
if !global.io_left and !global.io_right {
	move_key_peek = NONE
} else if (global.io_pressed_left and global.io_right and move_key_peek == RIGHT) or (global.io_left and !global.io_right) or (!global.io_pressed_right and global.io_left and move_key_peek == LEFT) {
	move_key_peek = LEFT
} else if (global.io_pressed_right and global.io_left and move_key_peek == LEFT) or (global.io_right and !global.io_left) or (!global.io_pressed_left and global.io_right and move_key_peek == RIGHT) {
	move_key_peek = RIGHT
} else {
	move_key_peek = NONE
}

var mover = (move_key_peek == RIGHT ? 1 : (move_key_peek == LEFT ? -1 : 0))
/*
if global.io_left xor global.io_right {
	move_dir = global.io_right - global.io_left
*/
if mover != 0 {
	move_dir = mover
	if move_dir == -1 { // 왼쪽
		if -move_spd < xvel {
			xvel -= move_acc
			if xvel < -move_spd
				xvel = -move_spd
		}
	} else { // 오른쪽
		if xvel < move_spd {
			xvel += move_acc
			if move_spd < xvel
				xvel = move_spd
		}
	}
	//xvel = move_dir * move_spd
} else {
	move_dir = 0
}

var check_top = wall_on_top(1)
if can_jump and !jumping and !check_top {
	if global.io_pressed_jump {
		jumping = true
		jump.set(0)
	}
}

if jumping {
	if check_top {
		jumping = false
		jump.finish()
	} else if jump.update() == 1 or global.io_released_jump {
		jumping = false
		jump.finish()
	}
}
