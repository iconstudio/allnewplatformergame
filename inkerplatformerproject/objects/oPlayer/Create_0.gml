event_inherited()

attack = new skill(seconds(0.3), function() {
	return global.io_pressed_skill_1
}, function() {
	effect_create_above(ef_smoke, x, y, 0, $ffffff)
}, -1)

skills = array_create(4, -1)
skills[0] = attack
