/// @description Scaling down
var increment = 10
if keyboard_check(vk_lcontrol) or keyboard_check(vk_rcontrol) {
	increment = 30
}

if scale_min < scale_target {
	scale_target = max(scale_target - increment, scale_min)
	if scale < scale_target 
		scale_begin = scale_target
	else
		scale_begin = scale
	scaling = true
	scale_time = 0
}
