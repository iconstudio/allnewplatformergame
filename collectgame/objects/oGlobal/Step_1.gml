/// @description Input Update
var cgx = device_mouse_x_to_gui(0)
var cgy = device_mouse_y_to_gui(0)

if global.qui_mx != cgx {
	global.qui_mx = cgx
	global.qui_io_last = QUI_IO_STATES.MOUSE
}
if global.qui_my != cgy {
	global.qui_my = cgy
	global.qui_io_last = QUI_IO_STATES.MOUSE
}

var check_prev = device_mouse_check_button(0, mb_left)
if global.io_mouse_left != check_prev {
	global.io_mouse_left = check_prev
	global.qui_io_last = QUI_IO_STATES.MOUSE
}

check_prev = device_mouse_check_button_pressed(0, mb_left)
if global.io_mouse_pressed_left != check_prev {
	global.io_mouse_pressed_left = check_prev
	global.qui_io_last = QUI_IO_STATES.MOUSE
}

check_prev = device_mouse_check_button_released(0, mb_left)
if global.io_mouse_released_left != check_prev {
	global.io_mouse_released_left = check_prev
	global.qui_io_last = QUI_IO_STATES.MOUSE
}

check_prev = keyboard_check(vk_left)
if global.io_left != check_prev {
	global.io_left = check_prev
	global.qui_io_last = QUI_IO_STATES.KEYBOARD
}

check_prev = keyboard_check(vk_right)
if global.io_right != check_prev {
	global.io_right = check_prev
	global.qui_io_last = QUI_IO_STATES.KEYBOARD
}

check_prev = keyboard_check(vk_up)
if global.io_up != check_prev {
	global.io_up = check_prev
	global.qui_io_last = QUI_IO_STATES.KEYBOARD
}

check_prev = keyboard_check(vk_down)
if global.io_down != check_prev {
	global.io_down = check_prev
	global.qui_io_last = QUI_IO_STATES.KEYBOARD
}

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

var check_comma = keyboard_check_pressed(key_comma)
var check_dot = keyboard_check_pressed(key_dot)

global.io_pressed_menu = keyboard_check_pressed(vk_escape) or keyboard_check_pressed(vk_backspace)
global.io_pressed_yes = keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space) or check_comma or global.io_pressed_x
global.io_pressed_no = keyboard_check_pressed(vk_escape) or keyboard_check_pressed(vk_backspace) or check_dot or global.io_pressed_c
global.io_pressed_back = global.io_pressed_no
