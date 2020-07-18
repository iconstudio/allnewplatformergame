// ** 데이터베이스 용 속성 **
///@function entity(name, [title])
function entity(nname, ntitle) constructor {
	version = GM_version

	sprite = -1
	sprite_icon = -1
	name = nname
	title = argument_select(ntitle, "")

	can_fly = false // 지금 날고있지 않더라도 날 수 있음
	can_move_through = false // 블록을 통과 가능 (날지 못하면 좌우로만 가능)
	can_swim_level = swimming.water // -1: 물에 못 들어감, 0: 물에선 가라앉음, 1: 물에서 수영 가능, 2: 용암에서 수영 가능
	flying = false // 날고있는 상태

	hd = 0 // 레벨
	maxhp = 1 // 체력
	maxmp = 0 // 마력
	ac = 0 // 물리 방어
	er = array_create(10, 0) // 속성 저항
	mr = 0 // 상태 저항
	ev = 0 // 회피
	sh = 0 // 패링

	skill_number = 0
	skills = []

#region 메서드
	function set_image(value) {
		sprite = value
		return self
	}

	function set_icon(value) {
		sprite_icon = value
		return self
	}

	function set_name(caption) {
		name = caption
		return self
	}

	function set_title(caption) {
		title = caption
		return self
	}

	function set_flyable(value) {
		can_fly = value
		return self
	}

	function set_movable_through_blocks(value) {
		can_move_through = value
		return self
	}

	function set_swimming_level(value) {
		can_swim_level = value
		return self
	}

	function set_flying(value) {
		flying = value
		return self
	}

	function set_level(value) {
		hd = value
		return self
	}

	function set_health_max(value) {
		maxhp = value
		return self
	}

	function set_mana_max(value) {
		maxmp = value
		return self
	}

	function set_armour(value) {
		ac = value
		return self
	}

	function set_element_resistance(type, value) {
		er[type] = value
		return self
	}

	function set_magic_resistance(value) {
		mr = value
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

	function get_version() {
		return version
	}

	function get_image() {
		return sprite
	}

	function get_icon() {
		return sprite_icon
	}

	function get_name(caption) {
		return name
	}

	function get_title(caption) {
		return title
	}

	function get_flyable() {
		return can_fly
	}

	function get_movable_through_blocks() {
		return can_move_through
	}

	function get_swimming_level() {
		return can_swim_level
	}

	function get_flying() {
		return flying
	}

	function get_level() {
		return hd
	}

	function get_health_max() {
		return maxhp
	}

	function get_mana_max() {
		return maxmp
	}

	function get_armour() {
		return ac
	}

	function get_element_resistance(type) {
		return er[type]
	}

	function get_magic_resistance() {
		return mr
	}

	function get_evasion() {
		return ev
	}

	function get_shield() {
		return sh
	}
#endregion
}

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

///@function calculate_damage(damage, damage_element, target_attribute)
function calculate_damage(damage, element, attr) {
	if damage == 0 {
		return 0
	} else if damage < 0 { // 회복
		return damage
	}

	var result = damage
	var resist = get_resistance_ratio(element, attr)
	result -= result * resist
	result = floor(result)
	if result < 0
		result = 0

	return result
}

function attack_try(target) {
	
}

function attack_process(target) {
	var type = 0, damage = 0
	if type == damage_types.physical
		property.add_health(-damage)
	else if type == damage_types.magical
		property.add_health(-damage)
}

function attributes_load(target, serial) {
	var properties = entity_find(serial)
	target.set_image(properties.get_image())
	target.set_icon(properties.get_icon())
	target.set_name(properties.get_name())
	target.set_title(properties.get_title())
	target.set_flyable(properties.get_flyable())
	target.set_movable_through_blocks(properties.get_movable_through_blocks())
	target.set_swimming_level(properties.get_swimming_level())
	target.set_flying(properties.get_flying())

	target.set_level(properties.get_level())
	target.init_health(properties.get_health_max())
	target.init_mana(properties.get_mana_max())
	target.set_magic_resistance(properties.get_magic_resistance())
	target.set_armour(properties.get_armour())
	target.set_shield(properties.get_shield())
	target.set_evasion(properties.get_evasion())
	show_debug_message("Name:" + string(target.get_name()))
	show_debug_message("Level:" + string(target.get_level()) + ", Max HP: " + string(target.get_health_max()) + ", HP: " + string(target.get_health()) + ", MP: " + string(target.get_mana()))
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
