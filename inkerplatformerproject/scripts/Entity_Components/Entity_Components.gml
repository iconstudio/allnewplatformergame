///@function skill_set([skill_0], [skill_1], ...)
function skill_set() constructor {
	skills = []
	number = 0

	function toString() {
		if 0 < number {
			var result = ""
			for (var i = 0; i < number; ++i) {
				result += string(skills[i])
				if i < number - 1
					result += ", "
			}

			return result
		} else {
			return "A empty set of skill"
		}
	}

	function copy() {
		if 0 < number {
			var result = new skill_set()
			for (var i = 0; i < number; ++i) {
				result.add(skills[i].copy())
			}
			return result
		} else {
			return new skill_set() // 빈 스킬 모음 반환
		}
	}

	function update() {
		if 0 < number {
			for (var i = 0; i < number; ++i) {
				skills[i].update() // 재귀 형태가 될 수 있다.
			}
		}
	}

	set = function(index, sk) {
		skills[index] = sk
		return self
	}

	add = function(sk) {
		set(number, sk)
		return number++
	}

	get = function(index) {
		if number <= index
			throw "능력의 정보 번호가 잘못됐습니다."
		return skills[index]
	}

	get_number = function() {
		return number
	}

	destroy = function() {
		skills = 0
	}

	if 0 < argument_count {
		for (var i = 0; i < argument_count; ++i)
			add(argument[i])
	}
}

function skill(info, abt) constructor {
	original = -1
	level = 0
	data = 0
	information = info
	procedure = abt

	toString = function() {
		return "Skill name: " + get_name() + integral(get_description() != "", ", " + get_description(), "")
	}

	function copy() {
		var copied = new skill(information, procedure.copy())
		copied.original = self
		return copied 
	}

	function update() {
		procedure.update()
	}

	set_data = function(value) {
		data = value
		return self
	}

	get_data = function() {
		return data
	}

	get_name = function() {
		return information.name
	}

	get_description = function () {
		return information.description
	}

	get_tooltip = function() {
		return information.tooltip
	}
}

///@function skill_strings([name], [description], [tooltip])
function skill_strings(nname, ndescription, ntooltip) constructor { // 복사 불가
	name = select_argument(nname, "")
	description = select_argument(ndescription, "")
	tooltip = select_argument(ntooltip, "")

	toString = function() {
		return name
	}
}

///@function ability(cooltime, period, condition, [execute_once], [execute], [execute_end])
function ability(cooltime, period, condition, execute_once, execute, execute_end) constructor { // 복사 가능
	parent = other
	running = false
	if cooltime <= 0
		throw "재사용 대기시간은 0 이하일 수 없습니다."
	cooldown = new Timer(cooltime).finish()
	duration = new Timer(period).finish()
	shortcut = condition
	initializer = select_argument(execute_once, -1)
	predicate = select_argument(execute, -1) 
	destructor = select_argument(execute_end, -1)

	function copy() {
		return new ability(cooldown.period, duration.period, shortcut, initializer, predicate, destructor)
	}

	get_cooldown = function() {
		return cooldown.get()
	}

	get_duration = function() {
		return duration.get()
	}

	cast = function() {
		if !running and get_cooldown() == 1 {
			cooldown.reset()
			duration.reset()
			running = true

			if initializer != -1 {
				with parent
					other.initializer()
			}
		}
	}

	update = function() {
		cooldown.update()

		if shortcut != -1 and shortcut() {
			cast()
		}

		if running {
			duration.update()
			if predicate != -1 {
				with parent
					other.predicate()
			}

			if get_duration() == 1 {
				running = false

				if destructor != -1 {
					var proc = destructor
					with parent
						proc()
				}
			}
		}
	}
}
