/// @description Controls
event_inherited()

var was_left = move_key_peek == LEFT, was_right = move_key_peek == RIGHT
move_key_peek = NONE
if !global.io_left and !global.io_right {
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

var mover = move_key_peek//duet(move_key_peek == RIGHT, 1, duet(move_key_peek == LEFT, -1, 0))
if mover != 0 {
	if mover == -1 { // 왼쪽
		if -move_speed < velocity_x {
			velocity_x -= move_accel
			if velocity_x < -move_speed
				velocity_x = -move_speed
		}
	} else { // 오른쪽
		if velocity_x < move_speed {
			velocity_x += move_accel
			if move_speed < velocity_x
				velocity_x = move_speed
		}
	}
	move_dir = mover
}

if velocity_x != 0
	img_xscale = move_dir

if global.io_pressed_jump
	velocity_y = -190
// 120
