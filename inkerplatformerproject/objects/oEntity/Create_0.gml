/// @description 초기화
sid = ""

function set_serial_number(caption) {
	sid = caption
	return self
}

function get_serial_number() {
	return sid
}

event_inherited()
