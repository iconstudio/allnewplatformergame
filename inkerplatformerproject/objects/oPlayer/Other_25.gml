/// @description 속성 초기화
event_inherited()

property.set_name("Character")
property.set_title("UNBREAKABLE")
property.init_status(entity_states.normal)
property.init_health(10)
property.init_mana(3)

attack_slash = noone
attack = new skill(seconds(0.3), -1, function() {
	return global.io_skill_1
}, function() {
	attack_slash = instance_create(oSlash, x, y)
	attack_slash.parent = id
}, -1)

teleport = new skill(seconds(8), -1, function() {
	return global.io_pressed_skill_2
}, function() {
	effect_create_below(ef_smoke, x, y, 0, $ffffff)
	if img_xscale == 1 {
		move_contact_solid(0, teleport_distance)
	} else {
		move_contact_solid(180, teleport_distance)
	}
	effect_create_below(ef_smoke, x, y, 0, $ffffff)
	//show_debug_message("2")
}, -1)
teleport_distance = 48

runaway = new skill(seconds(6), seconds(2), function() {
	return global.io_pressed_skill_3
}, function() {
	move_spd = move_spd_fast
	//show_debug_message("3s")
}, -1, function() {
	move_spd = move_spd_normal
	//show_debug_message("3e")
})

ultimate = new skill(seconds(5), 0, function() {
	return global.io_pressed_skill_4
}, function() {
	
}, -1)

skills = array_create(4, -1)
skills[0] = attack
skills[1] = runaway
skills[2] = teleport
skills[3] = ultimate

move_key_peek = RIGHT
move_dir = 0
move_spd_normal = 130 / seconds(1)
move_spd_fast = 160 / seconds(1)
move_spd = move_spd_normal
move_acc_ratio = seconds(0.05)

jumping = false
jump_predicate = new timer(seconds(0.2), function() { // 2.5칸까지 점프
	yvel = -220 / seconds(1)
	//show_debug_message("js")
}, function() {
	yvel = -100 / seconds(1)
	//show_debug_message("je")
})

// ** 점프를 이르거나 늦게 눌렀을 때도 가능하게 **
jump_fore_predicate = new timer(seconds(0.05))
jump_fore_predicate.finish()

// ** 점프를 땅 위에서 내려가면서 눌렀을 때도 가능하게 **
jump_cliffoff_predicate = new timer(seconds(0.09))
jump_cliffoff_predicate.finish()

function do_jump() {
	jumping = true
	jump_predicate.reset()
	jump_fore_predicate.finish()
	jump_cliffoff_predicate.finish()
}

function jump_end() {
	jumping = false
	jump_predicate.finish()
	jump_fore_predicate.finish()
	jump_cliffoff_predicate.finish()
}

function update_friction(on_ground) {
	if on_ground {
		if move_dir != 0
			set_friction_x(0)
		else
			set_friction_x(get_friction_ground())
	} else {
		set_friction_x(get_friction_air())
	}
}
