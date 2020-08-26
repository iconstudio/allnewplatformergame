///@function calculate_damage_resistedby_element(damage, damage_element, target)
function calculate_damage_resistedby_element(damage, element, target) {
	if damage == 0 {
		return 0
	} else if damage < 0 { // 회복
		return damage
	} else if element == elements.none {
		return damage
	}

	var er = target.get_element_resistance(element)
	var resist = element_get_resistance_ratios(element, er)
	damage -= damage * resist
	damage = floor(damage)
	if damage < 0
		damage = 0

	return damage
}

///@function calculate_damage_resistedby_armour(damage, type, target)
function calculate_damage_resistedby_armour(damage, type, target) {
	if damage == 0 {
		return 0
	} else if damage < 0 { // 회복
		return damage
	}

	var er = target.get_element_resistance(elements.none)
	var gdr = element_get_resistance_ratios(elements.none, er)
	var armour = target.get_armour()
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
		var damage_processed = calculate_damage_resistedby_element(damage, element, target)
		damage_processed = calculate_damage_resistedby_armour(damage_processed, type, target)

		target.do_hurt(damage_processed)
		return true
	}
}

///@function element_get_resistance_ratios(type, level)
function element_get_resistance_ratios(type, level) {
	if level < -3
		level = -3
	else if 4 < level
		level = 4

	switch type {
		case elements.none: // 최소 물리 방어율 (GDR)
			return level * 0.1

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

function element_get_name(element) {
	return global.__element_names[element]
}
