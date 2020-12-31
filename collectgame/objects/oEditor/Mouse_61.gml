/// @description Scaling down
var increment = 10
if keyboard_check(vk_lcontrol) {
	increment = 30
}

if scale_min < scale {
	scale = max(scale - increment, scale_min)
	position_adjust()
}
