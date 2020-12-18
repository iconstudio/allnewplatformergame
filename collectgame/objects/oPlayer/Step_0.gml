/// @description Controls
event_inherited()

var was_left = move_key_anchor == LEFT, was_right = move_key_anchor == RIGHT
move_key_anchor = NONE
if !global.io_left and !global.io_right {
}
else if (global.io_pressed_left and global.io_right and was_right)
or (global.io_left and !global.io_right)
or (!global.io_pressed_right and global.io_left and was_left) {
	move_key_anchor = LEFT
}
else if (global.io_pressed_right and global.io_left and was_left)
or (global.io_right and !global.io_left)
or (!global.io_pressed_left and global.io_right and was_right) {
	move_key_anchor = RIGHT
}

var mover = move_key_anchor//duet(move_key_anchor == RIGHT, 1, duet(move_key_anchor == LEFT, -1, 0))
if mover != 0 {
	if mover == LEFT {
		if 0 < velocity_x and velocity_x < move_speed {
			velocity_x = 0
		} else if -move_speed < velocity_x {
			velocity_x -= move_accel
			if velocity_x < -move_speed
				velocity_x = -move_speed
		}
	} else { // RIGHT
		if -move_speed < velocity_x and velocity_x < 0 {
			velocity_x = 0
		} else if velocity_x < move_speed {
			velocity_x += move_accel
			if move_speed < velocity_x
				velocity_x = move_speed
		}
	}
	move_dir = mover
	friction_x = 0
}

if velocity_x != 0
	img_xscale = move_dir

if global.io_pressed_jump
	velocity_y = -jump_speed

