event_inherited()

global.skills = {
	database: ds_map_create()
}

function skill(name, icon, description, tooltip, cooltime) constructor {
	cooldown = new timer(cooltime)

	update = function() {
		cooldown.update()
	}
}

function skill_info(name, icon, description, tooltip) constructor {
	self.name = name
	self.icon = icon
	self.description = description
	self.tooltip = tooltip
}

function skill_predicate(shortcut, condition, execute_once, procedure) constructor {
	self.shortcut = shortcut
	self.condition = select(condition != -1, condition, function() {
		return true
	})
	self.initializer = execute_once
	self.procedure = procedure

	cast = function() {
		if condition() {
			initializer()
		}
	}
}

skill_attributes = array_create(4, -1)
