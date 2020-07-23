/// @description 속성 초기화
set_serial_number("player-default")

event_inherited()

attack_slash = noone
attack_info = new skill_strings("칼질")
attack = new skill(attack_info, new ability(seconds(0.3), -1, function() {
	return global.io_skill_1
}, function() {
	attack_slash = instance_create(oSlash, x, y)
	attack_slash.parent = id
}))

blink_distance = 48
blink_info = new skill_strings("점멸")
blink = new skill(blink_info, new ability(seconds(8), -1, function() {
	return global.io_pressed_skill_2
}, function() {
	effect_create_below(ef_smoke, x, y, 0, $ffffff)
	move_horizontal_correction(blink_distance * img_xscale)
	effect_create_below(ef_smoke, x, y, 0, $ffffff)
}))

runaway_info = new skill_strings("신속")
runaway = new skill(runaway_info, new ability(seconds(6), seconds(2), function() {
	return global.io_pressed_skill_3
}, function() {
	move_spd = move_spd_fast
}, -1, function() {
	move_spd = move_spd_normal
}))

ultimate_info = new skill_strings("궁극")
ultimate = new skill(ultimate_info, new ability(seconds(5), 0, function() {
	return global.io_pressed_skill_4
}, function() {
	
}))

skills_test = new skill_set(attack, blink)

skills = make_skillset_owned(skills_test)
//show_debug_message("Data of skill set: " + string(skills))

move_key_peek = RIGHT
move_dir = 0
move_spd_normal = 130 / seconds(1)
move_spd_fast = 160 / seconds(1)
move_spd = move_spd_normal
move_acc_ratio = seconds(0.12)

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
