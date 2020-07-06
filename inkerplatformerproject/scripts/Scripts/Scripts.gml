function select(condition, value_true, value_false) {
	return condition ? value_true : value_false
}

function argument_select(arg, def) {
	return select(is_undefined(arg), def, arg)
}

///@function timer(duration, [predicate], [destructor])
function timer(duration, proc, dest) constructor {
	parent = other.id
	time = 0
	period = duration
	predicate = argument_select(argument[1], -1)
	destructor = argument_select(argument[2], -1)

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

function skill(_name, _icon, _description, _tooltip, _cooltime, _upgrade_next) constructor {
	cooldown = new timer(cooltime)
	next = _upgrade_next
	predicate = -1

	//info = new skill_info(name, icon, description, tooltip)
	info = {
		name: _name
		icon: _icon
		description: _description
		tooltip: _tooltip
	}

	attach = function(predicate) {
		self.predicate = predicate
	}

	update = function() {
		cooldown.update()
	}
}

function skill_predicate(shortcut, condition, execute_once, procedure) constructor {
	self.shortcut = shortcut
	self.condition = select(condition != -1, condition, function() {
		return true
	})
	self.initializer = execute_once
	self.procedure = procedure

	cast = function() {
		if condition() {
			initializer()
		}
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
function instance_create(obj, nx, ny, nlayer) {
	return instance_create_layer(argument_select(argument[1], 0), argument_select(argument[2], 0), argument_select(argument[3], layer), obj)
}


