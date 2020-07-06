event_inherited()

global.skills = {
	database: ds_map_create()
}

function skill(_name, _icon, _description, _tooltip, _cooltime, _upgrade_next) constructor {
	cooldown = new timer(cooltime)
	next = _upgrade_next

	//info = new skill_info(name, icon, description, tooltip)
	info = {
		name: _name
		icon: _icon
		description: _description
		tooltip: _tooltip
	}

	

	update = function() {
		cooldown.update()
	}
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
