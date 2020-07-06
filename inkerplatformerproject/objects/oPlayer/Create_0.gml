event_inherited()

skill_attributes = array_create(4, -1)
var attack = new skill("Attack", -1, "", "", seconds(0.1), -1)
var attack_predicate = new skill_predicate(function() {
	return global.io_pressed_skill_1
}, function() {
	
}, function() {
	
}, function() {
	
})
