function attribute() constructor {
	status = entity_state.normal
	status_previous = status
	can_fly = false // 지금 날고있지 않더라도 날 수 있음
	flying = false // 날아 다님
	move_through = false // 블록을 통과 가능 (날지 못하면 좌우로만 가능)

	maxhp = 1 // 체력
	hp = 1
	maxmp = 0 // 마력
	mp = 0

	ac = 0 // 방어
	ev = 0 // 회피
	sh = 0 // 패링

	function init_status(value) {
		status = value
		status_previous = value
		return self
	}

	function init_health(value) {
		maxhp = value
		hp = value
		return self
	}

	function init_mana(value) {
		maxmp = value
		mp = value
		return self
	}

	function set_status(value) {
		status_previous = status
		status = value
		return self
	}

	function set_flyable(value) {
		can_fly = value
		return self
	}

	function set_flying(value) {
		flying = value
		return self
	}

	function set_move_through_blocks(value) {
		move_through = value
		return self
	}

	function set_health(value) {
		hp = value
		return self
	}

	function set_mana(value) {
		mp = value
		return self
	}

	function set_armour(value) {
		ac = value
		return self
	}

	function set_evasion(value) {
		ev = value
		return self
	}

	function set_shield(value) {
		sh = value
		return self
	}

	function get_status() {
		return status
	}

	function get_status_previous() {
		return status_previous
	}

	function get_flyable() {
		return can_fly
	}

	function get_flying() {
		return flying
	}

	function get_move_through_blocks() {
		return move_through
	}

	function get_health() {
		return hp
	}

	function get_mana() {
		return mp
	}

	function get_health_max() {
		return maxhp
	}

	function get_mana_max() {
		return maxmp
	}

	function get_health_ratio() {
		return hp / maxhp
	}

	function get_mana_ratio() {
		return mp / maxmp
	}

	function get_armour() {
		return ac
	}

	function get_evasion() {
		return ev
	}

	function get_shield() {
		return sh
	}
}

///@function skill(ooltime, period, condition, [execute_once], [execute], [execute_end])
function skill(cooltime, period, condition, execute_once, execute, execute_end) constructor {
	parent = other
	running = false
	if cooltime <= 0
		throw "재사용 대기시간은 0 이하일 수 없습니다."
	cooldown = new timer(cooltime).finish()
	duration = new timer(period).finish()
	shortcut = condition
	initializer = argument_select(execute_once, -1)
	predicate = argument_select(execute, -1) 
	destructor = argument_select(execute_end, -1)

	get_cooldown = function() {
		return cooldown.get()
	}

	get_duration = function() {
		return duration.get()
	}

	cast = function() {
		if !running and get_cooldown() == 1 {
			cooldown.reset()
			duration.reset()
			running = true

			if initializer != -1 {
				with parent
					other.initializer()
			}
		}
	}

	update = function() {
		cooldown.update()

		if shortcut != -1 and shortcut() {
			cast()
		}

		if running {
			duration.update()
			if predicate != -1 {
				with parent
					other.predicate()
			}

			if get_duration() == 1 {
				running = false

				if destructor != -1 {
					var proc = destructor
					with parent
						proc()
				}
			}
		}
	}
}

function solid_at(position_x, position_y) {
	return !place_free(position_x, position_y)
}

function ground_at(position_x, position_y) {
	return solid_at(position_x, position_y) or instance_place(position_x, position_y, oPlatform)
}

function ground_at_precise(position_x, position_y) {
	var condition = solid_at(position_x, position_y)

	var in_platform = instance_place(x, y, oPlatform)
	if in_platform == noone {
		var on_platform = instance_place(position_x, position_y, oPlatform)
		if on_platform != noone
			condition = true
	} else {
		var under_platform = collision_line(bbox_left, bbox_bottom + 1, bbox_right - 1, bbox_bottom + 1, oPlatform, true, true)
		if under_platform != noone and in_platform != under_platform
			condition = true
	}

	return condition
}

function wall_on_horizontal(distance) {
	var fx = x + distance + sign(distance)
	return solid_at(fx, y)
}

function wall_on_position(x_distance, y_distance) {
	var fx = x + x_distance + sign(x_distance)
	var fy = y + y_distance + sign(y_distance)
	if y <= fy
		return ground_at(fx, fy)
	else
		return solid_at(fx, fy)
}

function wall_on_underneath(distance) {
	var fy
	if distance < 0
		return false
	else if distance == 0
		fy = y + 1 
	else
		fy = y + distance

	return ground_at_precise(x, fy)
}

function wall_on_top(distance) {
	var fy
	if distance < 0
		return false
	else if distance == 0
		fy = y - 1 
	else
		fy = y - distance

	return solid_at(x, fy)
}

function move_horizontal(range) {
	if wall_on_horizontal(range) {
		if range < 0 {
			move_contact_solid(180, abs(range) + 1)
			return LEFT
		} else if 0 < range {
			move_contact_solid(0, abs(range) + 1)
			return RIGHT
		}
	} else {
		x += range
	}
	return NONE
}

function move_horizontal_correction(range) {
	if wall_on_horizontal(range) {
		if !wall_on_position(range, 1) {
			y += 1
		} else if !wall_on_position(range, -1) {
			if !wall_on_position(range, -2) {
				y -= 2
			} else {
				y -= 1
			}
		} else {
			if range < 0 {
				move_contact_solid(180, abs(range) + 1)
				return LEFT
			} else if 0 < range {
				move_contact_solid(0, abs(range) + 1)
				return RIGHT
			}
		}
	} else {
		x += range
	}
	return NONE
}

function move_vertical(range) {
	var distance = floor(abs(range))
	var surplus = frac(abs(range))
	if range == 0 {
		return NONE
	} else {
		
	}

	if range < 0 {
		for (;0 < distance; distance--) {
			if wall_on_top(1) {
				move_contact_solid(90, 1)
				return UP
			} else {
				y--
			}
		}

		if surplus != 0 {
			if wall_on_top(surplus) {
				move_contact_solid(90, 1)
				return UP
			} else {
				y -= surplus
			}
		}
	} else if 0 < range {
		for (;0 < distance; distance--) {
			if wall_on_underneath(1) {
				return DOWN
			} else {
				y++
			}
		}

		if surplus != 0 {
			if wall_on_underneath(surplus)
				return DOWN
			else
				y += surplus
		}
	}
	return NONE
}
