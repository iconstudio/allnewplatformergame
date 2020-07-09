event_inherited()

attack = new skill(seconds(0.3), function() {
	return global.io_skill_1
}, function() {
	effect_create_above(ef_smoke, x, y, 0, $ffffff)
})

runaway = new skill(seconds(10), function() {
	return global.io_pressed_skill_2
}, function() {
	move_spd = move_spd_fast
	show_debug_message("!")
}, function() {
	move_spd = move_spd_normal
})

defense = new skill(seconds(12), function() {
	return global.io_pressed_skill_3
}, function() {
	
}, -1)

ultimate = new skill(seconds(5), function() {
	return global.io_pressed_skill_4
}, function() {
	
}, -1)

skills = array_create(4, -1)
skills[0] = attack
skills[1] = runaway
skills[2] = defense
skills[3] = ultimate
