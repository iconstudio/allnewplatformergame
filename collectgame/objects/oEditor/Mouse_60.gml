/// @description Scaling up
var increment = 10
if keyboard_check(vk_lcontrol) or keyboard_check(vk_rcontrol) {
	increment = 30
}

if scale_target < scale_max {
	scale_target = min(scale_target + increment, scale_max)
	if scale_target < scale
		scale_begin = scale_target
	else
		scale_begin = scale
	scaling = true
	scale_time = 0
}
