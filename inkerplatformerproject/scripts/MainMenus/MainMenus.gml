function MenuEntry() constructor {
	x = -1
	y = -1
	parent = other.id
	enabled = true

	focusable = true
	can_select = true
	pole = false

	proceed_select = -1
	predicate = -1
	next = -1
	before = -1

	function draw() {
		
	}

	function choice() {
		if can_select {
			if predicate != -1
				predicate()
			return true
		} else {
			return false
		}
	}

	function set_parent(value) {
		parent = value
		return self
	}

	function set_next(entry) {
		next = entry
		return self
	}

	function set_before(entry) {
		before = entry
		return self
	}
}

function MenuCaption(title, description): MenuEntry() constructor {
	caption = title
	tip = description
}

///@function MenuGroup([parent])
function MenuGroup(up) constructor {
	parent = argument_select(up, -1)
	first = -1
	last = -1
	entries = []
	size = 0
	focus_before = -1
	focus = -1

	function focus_item(entry) {
		if entry.focusable {
			focus_before = focus
			focus = entry
			return true
		} else {
			return false
		}
	}

	function select_item(entry) {
		return entry.choice()
	}

	function set_parent(group) {
		parent = group
		return self
	}

	function add(entry) {
		if !struct_exists(entry)
			throw "No struct exists!"

		if last != -1 {
			last.set_next(entry)
			entry.set_before(last)
		}
		if first == -1
			first = entry
		entry.set_parent(self)
		entries[size++] = entry
		last = entry

		return self
	}

	function add_caption(title, description) {
		return add(new MenuCaption(title, description))
	}

	draw = FUNC_NULL
}
