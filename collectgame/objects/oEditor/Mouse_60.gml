/// @description Scaling up
var increment = 10
if keyboard_check(vk_lcontrol) {
	increment = 30
}

if scale < scale_max {
	scale = min(scale + increment, scale_max)
	position_adjust()
}
