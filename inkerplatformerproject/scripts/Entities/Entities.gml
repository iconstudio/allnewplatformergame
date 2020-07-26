///@function attribute(name, [title])
function attributes(nname, ntitle): entity(nname, ntitle) constructor {
	status = entity_states.normal
	status_previous = status

	hp = 1
	mp = 0

#region 메서드
	function init_status(value) {
		status = value
		status_previous = value
		return self
	}

	function init_health(value) {
		set_health_max(value)
		set_health(value)
		return self
	}

	function init_mana(value) {
		set_mana_max(value)
		set_mana(value)
		return self
	}

	function set_status(value) {
		status_previous = status
		status = value
		//show_debug_message(status)
		return self
	}

	function set_movable_through_blocks(value) {
		can_move_through = value
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

	function get_status() {
		return status
	}

	function get_status_previous() {
		return status_previous
	}

	function get_health() {
		return hp
	}

	function get_mana() {
		return mp
	}

	function get_health_ratio() {
		return hp / maxhp
	}

	function get_mana_ratio() {
		return mp / maxmp
	}

	function add_health(value) {
		hp += value
		if maxhp < hp
			hp = maxhp
		return hp
	}

	function add_mana(value) {
		mp += value
		if maxmp < mp
			mp = maxmp
		return mp
	}

	function reprise_status() {
		set_status(get_status_previous())
	}
#endregion
}

///@function get_resistance_ratio(element_type, target_attribute)
function get_resistance_ratio(element, attr) {
	var er, result = 0
	try {
		er = attr.get_element_resistance(element) // 저항 수준
	} catch(_) {
		show_debug_message("저항 속성을 찾을 수 없습니다.")
		er = 0
	}
	result = element_get_resistance_ratios(element, er)

	return result
}

///@function calculate_damage_resistedby_element(damage, damage_element, target_attribute)
function calculate_damage_resistedby_element(damage, element, attr) {
	if damage == 0 {
		return 0
	} else if damage < 0 { // 회복
		return damage
	} else if element == elements.none {
		return damage
	}

	var resist = get_resistance_ratio(element, attr)
	damage -= damage * resist
	damage = floor(damage)
	if damage < 0
		damage = 0

	return damage
}

///@function calculate_damage_resistedby_armour(damage, type, target_attribute)
function calculate_damage_resistedby_armour(damage, type, attr) {
	if damage == 0 {
		return 0
	} else if damage < 0 { // 회복
		return damage
	}

	var gdr = get_resistance_ratio(elements.none, attr)
	var armour = attr.get_armour()
	if type == damage_types.physical {
		damage -= armour * gdr
	}
	damage -= irandom(armour)

	damage = floor(damage)
	if damage < 0
		damage = 0

	return damage
}

function hit_try(target, damage, type, element) {
	if target.is_invincible() {
		return false
	} else {
		var attr = target.property
		var damage_processed = calculate_damage_resistedby_element(damage, element, attr)
		damage_processed = calculate_damage_resistedby_armour(damage_processed, type, attr)

		target.do_hurt(damage_processed)
		return true
	}
}

function attributes_import(target, source) {
	target.set_image(source.get_image())
	target.set_icon(source.get_icon())
	target.set_name(source.get_name())
	target.set_title(source.get_title())

	target.set_flyable(source.get_flyable())
	target.set_movable_through_blocks(source.get_movable_through_blocks())
	target.set_swimming_level(source.get_swimming_level())
	target.set_flying(source.get_flying())
	target.set_category(source.get_category())
	target.set_intelligence(source.get_intelligence())

	target.init_status(entity_states.normal)
	target.set_level(source.get_level())
	target.init_health(source.get_health_max())
	target.init_mana(source.get_mana_max())
	if is_array(source.er)
		array_copy(target.er, 0, source.er, 10)
	else
		target.er = 0
	target.set_magic_resistance(source.get_magic_resistance())
	target.set_armour(source.get_armour())
	target.set_shield(source.get_shield())
	target.set_evasion(source.get_evasion())

	target.skills_original = source.get_skills_original()
	return target
}

function property_load(serial) {
	var original = entity_find(serial)
	var result = attributes_import(new attribute(), original)

	// ** 스킬 모음 복사 **
	self.skills = -1
	var sks_org = original.get_skills_original()
	if sks_org != -1 {
		skills = sks_org.copy()
	}
	//show_debug_message("Name:" + string(target.get_name()))
	//show_debug_message("Level:" + string(target.get_level()) + ", Max HP: " + string(target.get_health_max()) + ", HP: " + string(target.get_health()) + ", MP: " + string(target.get_mana()))
	return result
}

///@function skill_set([skill_0], [skill_1], ...)
function skill_set() constructor {
	skills = []
	number = 0

	function toString() {
		if 0 < number {
			var result = ""
			for (var i = 0; i < number; ++i) {
				result += string(skills[i])
				if i < number - 1
					result += ", "
			}

			return result
		} else {
			return "A empty set of skill"
		}
	}

	copy = function() {
		if 0 < number {
			var result = new skill_set()
			for (var i = 0; i < number; ++i) {
				result.add(skills[i].copy())
			}
			return result
		} else {
			return new skill_set() // 빈 스킬 모음 반환
		}
	}

	update = function() {
		if 0 < number {
			for (var i = 0; i < number; ++i) {
				skills[i].update() // 재귀 형태가 될 수 있다.
			}
		}
	}

	set = function(index, sk) {
		skills[index] = sk
		return self
	}

	add = function(sk) {
		set(number, sk)
		return number++
	}

	get = function(index) {
		if number <= index
			throw "능력의 정보 번호가 잘못됐습니다."
		return skills[index]
	}

	get_number = function() {
		return number
	}

	destroy = function() {
		skills = 0
	}

	if 0 < argument_count {
		for (var i = 0; i < argument_count; ++i)
			add(argument[i])
	}
}

function skill(info, abt) constructor {
	original = -1
	level = 0
	data = 0
	information = info
	procedure = abt

	toString = function() {
		return "Skill name: " + get_name() + select(get_description() != "", ", " + get_description(), "")
	}

	copy = function() {
		var copied = new skill(information, procedure.copy())
		copied.original = self
		return copied 
	}

	update = function() {
		procedure.update()
	}

	set_data = function(value) {
		data = value
		return self
	}

	get_data = function() {
		return data
	}

	get_name = function() {
		return information.name
	}

	get_description = function () {
		return information.description
	}

	get_tooltip = function() {
		return information.tooltip
	}
}

///@function skill_strings([name], [description], [tooltip])
function skill_strings(nname, ndescription, ntooltip) constructor { // 복사 불가
	name = argument_select(nname, "")
	description = argument_select(ndescription, "")
	tooltip = argument_select(ntooltip, "")

	toString = function() {
		return name
	}
}

///@function ability(cooltime, period, condition, [execute_once], [execute], [execute_end])
function ability(cooltime, period, condition, execute_once, execute, execute_end) constructor { // 복사 가능
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

	copy = function() {
		return new ability(cooldown.period, duration.period, shortcut, initializer, predicate, destructor)
	}

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
