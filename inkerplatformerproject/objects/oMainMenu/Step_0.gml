/// @description 메뉴 선택 및 실행
var was_left = key_peek == LEFT, was_right = key_peek == RIGHT
var KEY_L = global.io_left or global.io_up
var KEY_R = global.io_right or global.io_down
var KEY_PL = global.io_pressed_left or global.io_pressed_up
var KEY_PR = global.io_pressed_right or global.io_pressed_down

if !KEY_L and !KEY_R {
	key_peek = NONE
}
else if (KEY_PL and KEY_R and was_right)
or (KEY_L and !KEY_R)
or (!KEY_PR and KEY_L and was_left) {
	key_peek = LEFT
}
else if (KEY_PR and KEY_L and was_left)
or (KEY_R and !KEY_L)
or (!KEY_PL and KEY_R and was_right) {
	key_peek = RIGHT
}
else {
	key_peek = NONE
}

var mover = integral(key_peek == RIGHT, 1, integral(key_peek == LEFT, -1, 0))
if mover != 0 {
	key_dir = mover
}

update()


