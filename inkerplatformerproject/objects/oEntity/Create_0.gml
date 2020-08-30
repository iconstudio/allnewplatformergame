/// @description 초기화
event_inherited()

attributes_init()
sid = ""
loaded = false

function make_flyer() {
	if get_flyable() {
		set_flying(true)
		if get_movable_through_blocks() {
			updater_x = updater_x_flee
			updater_y = updater_y_flee
		}
		updater_yvel = updater_yvel_flee
	}
}

function make_dweller() {
	if get_flying() {
		set_flying(false)
		if get_movable_through_blocks() {
			updater_x = updater_x_normal
			updater_y = updater_y_normal
		}
		updater_yvel = updater_yvel_normal
	}
}

function do_jump() {
	yvel = -320 / seconds(1)
}

function make_stunned(duration) {
	set_status(mob_status.stunned)
	prop_stun.set(duration)
}

function make_awake() {
	if get_status() == mob_status.stunned {
		set_status(mob_status.normal)
		prop_stun.finish()
	}
}

///@function do_hurt(damage)
function do_hurt(damage) {
	var point = add_health(-damage)

	if point <= 0
		event_user(0)
}

function do_knockback(power) {
	var timed = 0
	if xvel == 0
		timed = 0.1 + abs(power) * 0.3
	else
		timed = 0.2 + abs(power) / xvel * 0.5

	make_stunned(seconds(min(2, timed)))
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
	return get_status() < mob_status.stunned
}

function set_serial_number(caption) {
	sid = caption
	return self
}

function get_serial_number() {
	return sid
}

function set_status(value) {
	status_previous = status
	status = value
	return self
}

function set_health(value) {
	hp = value
	return self
}

function set_mana(value) {
	mp = value
	return self
}

function init_health(value) {
	set_health_max(value)
	set_health(value)
	return self
}

function init_mana(value) {
	set_mana_max(value)
	set_mana(value)
	return self
}

function get_status() {
	return status
}

function get_status_previous() {
	return status_previous
}

function get_health() {
	return hp
}

function get_mana() {
	return mp
}

function get_health_ratio() {
	return hp / maxhp
}

function get_mana_ratio() {
	return mp / maxmp
}

function set_skills(value) {
	skills = value
	return self
}

function get_skills() {
	return skills
}

function add_health(value) {
	hp += value
	if maxhp < hp
		hp = maxhp
	return hp
}

function add_mana(value) {
	mp += value
	if maxmp < mp
		mp = maxmp
	return mp
}

function reprise_status() {
	set_status(get_status_previous())
}

event_user(15)

img_xscale = 1
img_angle = 0
