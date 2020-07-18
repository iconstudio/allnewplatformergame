/// @description 기본 속성 초기화
// ** 물리 속성 상속 **
event_inherited()

img_xscale = 1
img_angle = 0
property = new attributes()
property.init_status(entity_states.normal)

function make_flyer() {
	property.set_flyable(true)
}

function make_ghost() {
	property.set_movable_through_blocks(true)
}

function levitation() {
	if property.get_flyable() and !property.get_flying() {
		property.set_flying(true)
		if property.get_movable_through_blocks() {
			update_x = update_x_flee
			update_y = update_y_flee
		}
		update_yvel = update_yvel_flee
	}
}

function land() {
	if property.get_flying() {
		property.set_flying(false)
		if property.get_movable_through_blocks() {
			update_x = update_x_normal
			update_y = update_y_normal
		}
		update_yvel = update_yvel_normal
	}
}

function jump() {
	yvel = -320 / seconds(1)
}

function stun(duration) {
	property.set_status(entity_states.stunned)
	prop_stun.set(duration)
}

///@function hurt(damage)
function hurt(damage) {
	var point = property.add_health(-damage)

	if point <= 0
		event_user(0)
}

function knockback(power) {
	
}

function is_awake() {
	return property.get_status() < entity_states.stunned
}

prop_invincible = new countdown()
prop_stun = new countdown(-1, function() {property.reprise_status()})
