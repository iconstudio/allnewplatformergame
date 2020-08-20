
function chapter_info_add(sn, caption, desc) {
	var result = new chapter_info(sn, caption, desc)
	ds_map_add(global.__ch_db, sn, result)
	ds_list_add(global.__ch_infos, result)
}

function chapter_get(ind) {
	return ds_list_find_value(global.__ch_infos, ind)
}

function chapter_get_number() {
	return ds_list_size(global.__ch_infos)
}

function chapter_seek_serial(sn) {
	return ds_map_find_value(global.__ch_db, sn)
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
