function chapter_get_info(sn) {
	
}

///@function element_get_resistance_ratios(type, level)
function element_get_resistance_ratios(type, level) {
	if level < -3
		level = -3
	else if 4 < level
		level = 4

	switch type {
		case elements.none: // 최소 물리 방어율 (GDR)
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

function element_get_name(element) {
	return global.__element_names[element]
}
