event_inherited()

function skill_info(name, icon, cooltime) constructor {
	self.name = name
	self.icon = icon
	cooldown = cooltime
}

function skill(info, shortcut, condition, execute, predicate) constructor {
	cooldown = new timer(info.cooldown, predicate)
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
