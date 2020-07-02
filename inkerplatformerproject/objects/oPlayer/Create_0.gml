event_inherited()

function skill(cooltime, shortcut, condition, execute, predicate) constructor {
	cooldown = new timer(cooltime, predicate)
	self.shortcut = shortcut
	self.condition = select(condition != -1, condition, function() {
		return true
	})
	self.execute = execute
	self.predicate = predicate

	cast = function() {
		if condition() {
			execute()
		}
	}

	update = function() {
		cooldown.update()
	}
}

skill_attributes = array_create(4, -1)
