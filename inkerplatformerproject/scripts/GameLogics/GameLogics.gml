///@function calculate_damage_resistedby_element(damage, damage_element, target_attribute)
function calculate_damage_resistedby_element(damage, element, attr) {
	if damage == 0 {
		return 0
	} else if damage < 0 { // 회복
		return damage
	} else if element == elements.none {
		return damage
	}

	var er = attr.get_element_resistance(element)
	var resist = element_get_resistance_ratios(element, er)
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

	var er = attr.get_element_resistance(elements.none)
	var gdr = element_get_resistance_ratios(elements.none, er)
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

///@function Property(serial_number)
function Property(serial): Attribute() constructor {
	source = entity_find(serial)
	set_image(source.get_image())
	set_icon(source.get_icon())
	set_name(source.get_name())
	set_title(source.get_title())

	set_flyable(source.get_flyable())
	set_movable_through_blocks(source.get_movable_through_blocks())
	set_swimming_level(source.get_swimming_level())
	set_flying(source.get_flying())

	set_category(source.get_category())
	set_intelligence(source.get_intelligence())

	init_status(entity_states.normal)
	set_level(source.get_level())
	init_health(source.get_health_max())
	init_mana(source.get_mana_max())
	if is_array(source.er) {
		if is_array(er) or er != 0 {
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

	// ** 스킬 모음 복사 **
	var sks_org = source.get_skills_original()
	if sks_org != -1 {
		other.set_skills(sks_org.copy())
	}
}
