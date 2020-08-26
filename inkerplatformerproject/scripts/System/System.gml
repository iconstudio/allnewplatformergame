///@function chapter_info_add(serial, title, description)
function chapter_info_add(sn, caption, desc) {
	var result = new chapter_info(sn, caption, desc)
	ds_map_add(global.__ch_db, sn, result)
	ds_list_add(global.__ch_infos, result)
}

///@function chapter_get(chapter_index)
function chapter_get(ind) {
	return ds_list_find_value(global.__ch_infos, ind)
}

function chapter_get_number() {
	return ds_list_size(global.__ch_infos)
}

///@function chapter_seek_serial(serial)
function chapter_seek_serial(sn) {
	return ds_map_find_value(global.__ch_db, sn)
}

