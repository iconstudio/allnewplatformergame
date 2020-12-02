/// @description 
if keyboard_check_pressed(vk_space)
	velocity_y = -500

var xstate = keyboard_check(vk_right) - keyboard_check(vk_left)
if xstate != 0
	velocity_x = xstate * 70
