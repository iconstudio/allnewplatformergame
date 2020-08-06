function MenuEntry() constructor {
	type = menu_types.none
	parent = other.id
	enabled = true

	x = -1
	y = -1
	width = 0
	height = 0

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
	type = menu_types.text
	caption = title
	tip = description
	width = string_width(title)
	height = string_height(title)

	function draw() {
		draw_text(x, y, caption)
		return height
	}
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
			last.pole = false
			last.set_next(entry)
			entry.set_before(last)
			entry.pole = true
		}
		if first == -1 {
			first = entry
			first.pole = true
		}
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
