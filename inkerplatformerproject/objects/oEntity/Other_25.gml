/// @description 기본 속성 초기화
// ** 물리 속성 상속 **
event_inherited()

img_xscale = 1
img_angle = 0
property = new attributes()
skills = -1
property_load(property, get_serial_number())

attacking = false

function make_flyer() {
	property.set_flyable(true)
}

function make_ghost() {
	property.set_movable_through_blocks(true)
}

function do_levitation() {
	if property.get_flyable() and !property.get_flying() {
		property.set_flying(true)
		if property.get_movable_through_blocks() {
			update_x = update_x_flee
			update_y = update_y_flee
		}
		update_yvel = update_yvel_flee
	}
}

function do_land() {
	if property.get_flying() {
		property.set_flying(false)
		if property.get_movable_through_blocks() {
			update_x = update_x_normal
			update_y = update_y_normal
		}
		update_yvel = update_yvel_normal
	}
}

function do_jump() {
	yvel = -320 / seconds(1)
}

function do_stun(duration) {
	property.set_status(entity_states.stunned)
	prop_stun.set(duration)
}

///@function do_hurt(damage)
function do_hurt(damage) {
	var point = property.add_health(-damage)

	if point <= 0
		event_user(0)
}

function do_knockback(power) {
	var timed = 0
	if xvel == 0
		timed = seconds(0.1 + abs(power) * 0.3)
	else
		timed = seconds(0.2 + abs(power) / xvel * 0.5)
	//show_debug_message(timed)
	do_stun(timed)
	xvel = power
	yvel = -abs(xvel * 0.75)
}

function do_invincible(duration) {
	if 0 < duration
		prop_invincible.set(duration)
}

function is_invincible() {
	return 0 < prop_invincible.get()
}

function is_awake() {
	return property.get_status() < entity_states.stunned
}

prop_invincible = new countdown(-1, function() {
	invincible_alpha = 0
	show_debug_message("invincible end")
})
invincible_alpha = 0
prop_stun = new countdown(-1, function() {
	//property.reprise_status()
	property.set_status(entity_states.normal)
	show_debug_message("stun end")
})
