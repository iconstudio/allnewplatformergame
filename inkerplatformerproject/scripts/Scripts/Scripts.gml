function select(condition, value_true, value_false) {
	return condition ? value_true : value_false
}

///@function timer(duration, [predicate], [destructor])
function timer(duration, proc, dest) constructor {
	parent = other.id
	time = 0
	period = duration
	predicate = select(1 < argument_count, argument[1], -1)
	destructor = select(2 < argument_count, argument[2], -1)

	set = function(count) {
		time = count
		return get()
	}

	get = function() {
		return time / period
	}

	update = function() {
		if predicate != -1 and instance_exists(parent) {
			var proc = predicate
			with parent
				proc()
		}

		if time < period
			time++

		if period < time // debug
			time = period

		return get()
	}

	finish = function() {
		if destructor != -1 and instance_exists(parent) {
			var proc = destructor
			with parent
				proc()
		}

		set(period)
		return 1
	}
}

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

///@function instance_create(obj, [nx], [ny], [nlayer])
function instance_create(obj) {
	return instance_create_layer(select(1 < argument_count, argument[1], 0)
	, select(2 < argument_count, argument[2], 0)
	, select(3 < argument_count, argument[3], layer), obj)
}
