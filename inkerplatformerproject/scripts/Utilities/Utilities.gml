function select(condition, value_true, value_false) {
	return condition ? value_true : value_false
}

function argument_select(arg, def) {
	return select(is_undefined(arg), def, arg)
}

///@function timer(duration, [predicate], [destructor])
function timer(duration, proc, dest) constructor {
	parent = other
	running = false
	time = 0
	period = duration
	predicate = argument_select(proc, -1)
	destructor = argument_select(dest, -1)

	set =	function(count) {
		running = false
		time = count
		return self
	}

	get =	function() {
		if period <= 0
			return 1
		return time / period
	}

	update = function() {
		if predicate != -1 and instance_exists(parent) {
			var proc = predicate
			with parent
				proc()
		}

		if period <= 0 {
			finish()
		} else if time < period {
			running = true
			time++
			if period <= time
				finish()
		} else {
			time = period
		}

		return get()
	}

	reset =	function() {
		set(0)
		return self
	}

	finish = function() {
		if running or period <= 0 {
			//show_debug_message("te")
			if destructor != -1 and instance_exists(parent) {
				var proc = destructor
				with parent
					proc()
			}
		}

		set(period)
		return self
	}
}

///@function countdown([predicate], [destructor])
function countdown(proc, dest) constructor {
	parent = other
	time = -1
	predicate = argument_select(proc, -1)
	destructor = argument_select(dest, -1)

	set =	function(count) {
		time = count
		return self
	}

	get =	function() {
		return time
	}

	update = function() {
		if 0 < time {
			if predicate != -1 and instance_exists(parent) {
				var proc = predicate
				with parent
					proc()
			}

			time--
		} else {
			if time != -1 {
				finish()
			}
		}

		return get()
	}

	reset =	function() {
		set(-1)
		return self
	}

	finish = function() {
		if destructor != -1 and instance_exists(parent) {
			var proc = destructor
			with parent
				proc()
		}

		set(-1)
		return self
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

///@function lx(angle, [length])
function lx(angle, length) {
	while angle < 0
		angle += 360
	if 360 <= angle
		angle = angle mod 360
	return global.__lengthdir_cashed[angle][0] * argument_select(length, 1)
}

///@function ly(angle, [length])
function ly(angle, length) {
	while angle < 0
		angle += 360
	if 360 <= angle
		angle = angle mod 360
	return global.__lengthdir_cashed[angle][1] * argument_select(length, 1)
}

///@function instance_create(obj, [x], [y], [layer])
function instance_create(obj, nx, ny, nlayer) {
	return instance_create_layer(argument_select(nx, 0), argument_select(ny, 0), argument_select(nlayer, layer), obj)
}

function make_percent_caption(title, value, value_max) {
	return title + ": " + string(value) + " / " + string(value_max)
}
