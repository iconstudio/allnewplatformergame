/// @description 입력 처리
global.io_left = keyboard_check(vk_left)
global.io_right = keyboard_check(vk_right)
global.io_up = keyboard_check(vk_up)
global.io_down = keyboard_check(vk_down)

global.io_pressed_left = keyboard_check_pressed(vk_left) or keyboard_check_pressed(vk_numpad4)
global.io_pressed_right = keyboard_check_pressed(vk_right) or keyboard_check_pressed(vk_numpad6)
global.io_pressed_up = keyboard_check_pressed(vk_up) or keyboard_check_pressed(vk_numpad8)
global.io_pressed_down = keyboard_check_pressed(vk_down) or keyboard_check_pressed(vk_numpad2)
if keyboard_check_pressed(vk_numpad1) {
	global.io_pressed_left = true
	global.io_pressed_down = true
} else if keyboard_check_pressed(vk_numpad3) {
	global.io_pressed_right = true
	global.io_pressed_down = true
} else if keyboard_check_pressed(vk_numpad7) {
	global.io_pressed_left = true
	global.io_pressed_up = true
} else if keyboard_check_pressed(vk_numpad9) {
	global.io_pressed_right = true
	global.io_pressed_up = true
}

global.io_pressed_jump = keyboard_check_pressed(vk_space)
global.io_released_jump = keyboard_check_released(vk_space)
global.io_pressed_skill_1 = keyboard_check_pressed(key_q)
global.io_pressed_skill_2 = keyboard_check_pressed(key_w)
global.io_pressed_skill_3 = keyboard_check_pressed(key_e)
global.io_pressed_skill_4 = keyboard_check_pressed(key_r)
global.io_pressed_status = false
global.io_pressed_inventory = false
for (var i = 0; i < 4; ++i)
	global.io_pressed_status |= keyboard_check_pressed(keys_status[i])
for (i = 0; i < 3; ++i)
	global.io_pressed_status |= keyboard_check_pressed(keys_inventory[i])

var check_comma = keyboard_check_pressed(key_comma)
var check_dot = keyboard_check_pressed(key_dot)
global.io_pressed_menu = keyboard_check_pressed(vk_escape) or keyboard_check_pressed(vk_backspace)
global.io_pressed_yes = keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space) or check_comma
global.io_pressed_no = keyboard_check_pressed(vk_escape) or keyboard_check_pressed(vk_backspace) or check_dot
global.io_pressed_back = global.io_pressed_no