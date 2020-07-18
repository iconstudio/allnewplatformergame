/// @description 초기화
sid = ""

function set_serial_number(caption) {
	sid = caption
	return self
}

function get_serial_number(caption) {
	return sid
}

event_inherited()
