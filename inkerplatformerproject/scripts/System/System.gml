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
