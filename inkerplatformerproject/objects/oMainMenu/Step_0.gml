/// @description 메뉴 선택 및 실행
var was_left = move_key_peek == LEFT, was_right = move_key_peek == RIGHT
var KEY_L = global.io_left or global.io_up
var KEY_R = global.io_right or global.io_down
var KEY_PL = global.io_pressed_left or global.io_pressed_up
var KEY_PR = global.io_pressed_right or global.io_pressed_down

if !KEY_L and !KEY_R {
	move_key_peek = NONE
}
else if (KEY_PL and KEY_R and was_right)
or (KEY_L and !KEY_R)
or (!KEY_PR and KEY_L and was_left) {
	move_key_peek = LEFT
}
else if (KEY_PR and KEY_L and was_left)
or (KEY_R and !KEY_L)
or (!KEY_PL and KEY_R and was_right) {
	move_key_peek = RIGHT
}
else {
	move_key_peek = NONE
}

var mover = select(move_key_peek == RIGHT, 1, select(move_key_peek == LEFT, -1, 0))
if mover != 0 {
	move_dir = mover
}
