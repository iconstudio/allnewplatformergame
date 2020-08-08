///@function MenuItem()
function MenuItem() constructor {
	parent = other
	font = fontMainMenuEntry
	aligns = [1, 1]
	text = ""
	tip = ""

	predicate = -1
	opened = false
	focusable = true
	pole = false
	push = new Timer(seconds(0.4))
	children = []
	child_focused = -1
	number = 0
	next = -1
	before = -1

	///@function draw_children(x, y)
	function draw_children(dx, dy) {
		var result = [0, 0]
		if 0 < number {
			var temp
			for (var i = 0; i < number; ++i) {
				temp = get(i).draw(dx, dy)
				dx += temp[0]
				dy += temp[1]
				result[0] += temp[0]
				result[1] += temp[1]
			}
		}
		return result
	}

	///@function draw_me(x, y)
	function draw_me(dx, dy) {
		if text != "" {
			draw_set_font(font)
			draw_set_halign(aligns[0])
			draw_set_valign(aligns[1])
			draw_text(dx, dy, text)
			return [0, global.menu_caption_height]
		} else {
			return [0, 0]
		}
	}

	///@function draw(x, y)
	function draw(dx, dy) {
		if opened {
			return draw_children(dx, dy)
		} else {
			return draw_me(dx, dy)
		}
	}

	function update() {
		push.update()
		if 0 < number {
			for (var i = 0; i < number; ++i)
				get(i).update()
		}
	}

	function add_general(item) {
		children[number++] = item
		return item
	}

	function add(title, description, predicate) {
		var result = new MainMenuEntry()
		result.text = title
		result.tip = description
		result.predicate = predicate
		return add_general(result)
	}

	function focus(item) {
		child_focused = item
	}

	///@function open([flag])
	function open(flag) {
		opened = select_argument(flag, true)
	}

	function get(index) {
		return children[index]
	}

	function get_number() {
		return number
	}

	function get_width() {
		return global.menu_caption_width
	}

	function get_height() {
		return global.menu_caption_height
	}

	function select(item) {
		if item.focusable and item.predicate != -1 {
			item.predicate()
		}
	}
}

/*
function MenuItem() constructor {
	type = menu_types.none
	parent = other
	enabled = true

	width = 0
	height = 0

	focusable = true
	can_select = true
	pole = false

	proceed_select = -1
	predicate = -1
	next = -1
	before = -1

	///@function draw(x, y)
	draw = FUNC_NULL

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

	function set_predicate(func) {
		predicate = func
		return self
	}
}

///@function MenuCaption(title, description, predicate)
function MenuCaption(title, description, pred): MenuItem() constructor {
	type = menu_types.text
	caption = title
	tip = description
	predicate = pred
	width = string_width(title)
	//height = string_height(title)

	///@function draw(x, y)
	function draw(dx, dy) {
		draw_set_font(fontMainMenuEntry)
		draw_text(dx, dy, caption)
		return global.menu_caption_height
	}
}

///@function MenuGroup([parent])
function MenuGroup(up) constructor {
	parent = select_argument(up, -1)
	first = -1
	first_poled = false
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

		if first != -1 {
			if !first.pole {
				if !first_poled {
					entry.pole = true
					first_poled = true
				}
			}
		}
		if last != -1 {
			last.pole = false
			last.set_next(entry)
			entry.set_before(last)
			entry.pole = true
		}
		if first == -1 {
			first = entry
			if first.focusable and !first_poled {
				first.pole = true
				first_poled = true
			}
		} else {
			
		}

		last = entry
		entry.set_parent(self)
		entries[size++] = entry
		return self
	}

	function get(index) {
		try {
			return entries[index]
		} catch(_) {
			return undefined
		}
	}

	function add_caption(title, description, pred) {
		return add(new MenuCaption(title, description, pred))
	}

	draw = FUNC_NULL
}
