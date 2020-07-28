function entity_register(serial, item) {
	ds_list_add(global.__entity_list, item)
	ds_map_add(global.__entity_db, serial, item)

	show_debug_message(string(item))
}

function entity_find(serial) {
	var result = ds_map_find_value(global.__entity_db, serial)
	if is_undefined(result)
		return global.__entity_db[? ""]
	else
		return result
}

function entity_read(map_parsed) {
	
}

// ** 데이터베이스 용 속성 **
///@function Entity(name, [title])
function Entity(nname, ntitle) constructor {
	version = GM_version

	sprite = -1 // 실제 스프라이트가 아님
	sprite_icon = -1 // 편집기 혹은 지도에 표시해 줄 아이콘
	name = nname
	title = argument_select(ntitle, "")

	can_fly = false // 지금 날고있지 않더라도 날 수 있음
	can_move_through = false // 블록을 통과 가능 (날지 못하면 좌우로만 가능)
	can_swim_level = swimming.water // -1: 물에 못 들어감, 0: 물에선 가라앉음, 1: 물에서 수영 가능, 2: 용암에서 수영 가능
	flying = false // 날고있는 상태

	category = 0 // 엔티티의 종류
	intelligence = 0 // 엔티티의 지능

	hd = 0 // 레벨
	maxhp = 1 // 체력
	maxmp = 0 // 마력
	ac = 0 // 물리 방어
	er = 0//array_create(element_number, 0) // 속성 저항 (0이면 전부 0이라는 뜻)
	mr = 0 // 상태 저항
	ev = 0 // 회피
	sh = 0 // 패링

	skills_original = -1

#region 메서드
	function toString() {
		return name
	}

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

	function set_category(value) {
		category = value
		return self
	}

	function set_intelligence(value) {
		intelligence = value
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
		if !is_array(er)
			er = array_create(element_number, 0)
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

	function get_category() {
		return category
	}

	function get_intelligence() {
		return intelligence
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
		if !is_array(er)
			return 0

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

	function get_skills_original() {
		return skills_original
	}
#endregion
}

///@function Attribute(name, [title])
function Attribute(nname, ntitle): Entity(nname, ntitle) constructor {
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
