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
///@function entity(name, [title])
function entity(nname, ntitle) constructor {
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
	er = 0//array_create(10, 0) // 속성 저항 (0이면 전부 0이라는 뜻)
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
			er = array_create(10, 0)
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

///@function element_get_resistance_ratios(type, level)
function element_get_resistance_ratios(type, level) {
	if level < -3
		level = -3
	else if 4 < level
		level = 4

	switch type {
		case elements.none:
			return level * 0.2

		case elements.fire:
		case elements.cold:
		case elements.air:

		case elements.electricity:
		case elements.poison:
		case elements.acid:

		case elements.warp:

		case elements.negative:
		case elements.positive:
				return global.__element_resist[type][level + 3]

	  default:
			throw "알 수 없는 속성이 전달되었습니다."
	}
}

function element_get_name(item_enumerator) {
	return global.__element_names[item_enumerator]
}
