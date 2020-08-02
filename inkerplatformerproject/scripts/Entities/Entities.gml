function entity_find_data(serial) {
	var result = ds_map_find_value(global.__entity_db, serial)
	if is_undefined(result)
		return global.__entity_db[? ""]
	else
		return result
}

function entity_find_serial(object) {
	var result = ds_map_find_value(global.__entity_db, object)
	if is_undefined(result)
		return ""
	else
		return result
}

function attributes_init() {
	version = GM_version

	sprite = -1 // 실제 스프라이트가 아님
	sprite_icon = -1 // 편집기 혹은 지도에 표시해 줄 아이콘
	name = ""
	title = ""

	category = mob_category.none // 엔티티의 종류
	intelligence = mob_intelligences.normal // 엔티티의 지능
	ai_move_type = mob_ai_move_types.nothing
	ai_track_type = mob_ai_track_types.stop
	ai_attack_type = mob_ai_attack_types.normal

	can_fly = false // 지금 날고있지 않더라도 날 수 있음
	can_move_through = false // 블록을 통과 가능 (날지 못하면 좌우로만 가능)
	can_swim_level = mob_swimming.water // -1: 물에 못 들어감, 0: 물에선 가라앉음, 1: 물에서 수영 가능, 2: 용암에서 수영 가능
	flying = false // 날고있는 상태

	hd = 0 // 레벨
	maxhp = 1 // 체력
	maxmp = 0 // 마력
	ac = 0 // 물리 방어
	er = 0 //array_create(element_number, 0) // 속성 저항 (0이면 전부 0이라는 뜻)
	mr = 0 // 상태 저항
	ev = 0 // 회피
	sh = 0 // 패링

	function toString() {
		return name
	}

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

	function set_category(value) {
		category = value
		return self
	}

	function set_intelligence(value) {
		intelligence = value
		return self
	}

	function set_ai_move_type(value) {
		ai_move_type = value
		return self
	}

	function set_ai_track_type(value) {
		ai_track_type = value
		return self
	}

	function set_ai_attack_type(value) {
		ai_attack_type = value
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

	function get_name() {
		return name
	}

	function get_title() {
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

	function get_ai_move_type() {
		return ai_move_type
	}

	function get_ai_track_type() {
		return ai_track_type
	}

	function get_ai_attack_type() {
		return ai_attack_type 
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
	#endregion
}

function property_load(serial) {
	if loaded
		exit
	else
		loaded = true

	var source = entity_find_data(serial)

	set_image(source.get_image())
	set_icon(source.get_icon())
	set_name(source.get_name())
	set_title(source.get_title())

	set_flyable(source.get_flyable())
	set_movable_through_blocks(source.get_movable_through_blocks())
	set_swimming_level(source.get_swimming_level())
	set_flying(source.get_flying())
	if get_flying()
		make_flyer()

	set_category(source.get_category())
	set_intelligence(source.get_intelligence())
	set_ai_move_type(source.get_ai_move_type())
	set_ai_track_type(source.get_ai_track_type())
	set_ai_attack_type(source.get_ai_attack_type())

	set_level(source.get_level())
	if is_array(source.er) {
		if !is_array(er) {
			er = array_create(element_number, 0)
		}
		array_copy(er, 0, source.er, 0, element_number)
	} else {
		er = 0
	}
	set_magic_resistance(source.get_magic_resistance())
	set_armour(source.get_armour())
	set_shield(source.get_shield())
	set_evasion(source.get_evasion())

	init_health(source.get_health_max())
	init_mana(source.get_mana_max())
	// ** 스킬 모음 복사 **
	var sks_org = source.get_skills_original()
	if sks_org != -1 {
		set_skills(sks_org.copy())
	}
}

function property_init() {
	if !loaded {
		var myself = entity_find_serial(object_index)
		property_load(myself)
	}
}

///@description 엔티티 데이터베이스
///@function RawEntity(serial)
function RawEntity(serial) constructor {
	attributes_init()
	sid = serial
	skills_original = -1

	function read(map_parsed) {
		
	}

	function register(object) {
		ds_list_add(global.__entity_list, self)
		ds_map_add(global.__entity_db, sid, self)
		ds_map_add(global.__entity_db, object, sid)

		show_debug_message(string(self))
	}

	function get_skills_original() {
		return skills_original
	}
}
