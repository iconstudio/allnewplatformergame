/// @description 기본 속성 초기화
// ** 물리 속성 상속 **
event_inherited()

property = new attribute()

function make_flyer() {
	property.set_flyable(true)
}

function levitation() {
	if property.get_flyable() and !property.get_flying() {
		property.set_flying(true)
		if property.get_move_through_blocks() {
			update_x = update_x_flee
			update_y = update_y_flee
		}
		update_yvel = update_yvel_flee
	}
}

function land() {
	if property.get_flying() {
		property.set_flying(false)
		if property.get_move_through_blocks() {
			update_x = update_x_normal
			update_y = update_y_normal
		}
		update_yvel = update_yvel_normal
	}
}


function jump() {
	yvel = -320 / seconds(1)
}

img_xscale = 1
img_angle = 0
