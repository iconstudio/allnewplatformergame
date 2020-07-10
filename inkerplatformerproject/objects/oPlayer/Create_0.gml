event_inherited()

attack = new skill(seconds(0.3), function() {
	return global.io_skill_1
}, function() {
	effect_create_above(ef_smoke, x, y, 0, $ffffff)
	show_debug_message("1")
}, -1)

teleport = new skill(seconds(8), function() {
	return global.io_pressed_skill_2
}, function() {
	if img_xscale == 1 {
		move_contact_solid(0, teleport_distance)
	} else {
		move_contact_solid(180, teleport_distance)
	}
	show_debug_message("2")
}, -1)
teleport_distance = 48

runaway = new skill(seconds(4), function() {
	return global.io_pressed_skill_3
}, function() {
	move_spd = move_spd_fast * 3
	show_debug_message("3")
}, function() {
	move_spd = move_spd_normal
})

ultimate = new skill(seconds(5), function() {
	return global.io_pressed_skill_4
}, function() {
	
}, -1)

skills = array_create(4, -1)
skills[0] = attack
skills[1] = runaway
skills[2] = teleport
skills[3] = ultimate
