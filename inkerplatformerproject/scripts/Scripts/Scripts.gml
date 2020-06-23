function seconds(time) {
	return max(1, time * room_speed)
}

function color_get_random() {
	return make_color_rgb(irandom(255), irandom(255), irandom(255))
}

function struct_exists(struct) {
	return !is_undefined(instanceof(struct))
}

function io_check_ok() {
	return keyboard_check_pressed(vk_enter)
	or keyboard_check_pressed(vk_space)
}

function instance_create(obj, nx, ny, nlayer) {
	return instance_create_layer(2 < argument_count ? nx : 0, 2 < argument_count ? ny : 0, 3 < argument_count ? nlayer : layer, obj)
}
