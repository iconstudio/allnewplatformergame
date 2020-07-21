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

	skills_original = -1

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

	// ** 스킬 모음 상속 **
	if properties.skills_original != -1 {
		skills = make_skillset_owned(properties.skills_original)
	}

	show_debug_message("Name:" + string(target.get_name()))
	show_debug_message("Level:" + string(target.get_level()) + ", Max HP: " + string(target.get_health_max()) + ", HP: " + string(target.get_health()) + ", MP: " + string(target.get_mana()))
}

///@function make_skillset_owned(skill_original)
function make_skillset_owned(skset_org) {
	return skset_org.copy()
}

///@function skill_set([skill_0], [skill_1], ...)
function skill_set(args) constructor {
	skills = []
	number = 0

	copy = function() {
		//show_debug_message("A skillset is copied: " + string(self))
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
	datas = []
	information = info
	procedure = abt

	copy = function() {
		return new skill(information, procedure.copy())
	}

	update = function() {
		procedure.update()
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

function skill_strings() constructor { // 복사 불가
	name = ""
	description = ""
	tooltip = ""
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
		return new ability(cooldown, duration, shortcut, initializer, predicate, destructor)
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
