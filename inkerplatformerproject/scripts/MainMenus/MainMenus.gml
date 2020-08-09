///@function MenuItem()
function MenuItem() constructor {
	parent = other
	
	sprite = -1
	font = fontMainMenuEntry
	text = ""
	tip = ""
	width = global.menu_caption_width
	height = global.menu_caption_height
	aligns = [1, 1]
	ax = 0
	ay = 0

	predicate = -1
	opened = false
	focusable = true
	openable = true
	pole = false
	push = new Timer(seconds(0.7))
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
			dx += ax
			dy += ay
			var ocolor = draw_get_color()
			if focusable and parent.child_focused == self
				draw_set_color(c_orange)

			draw_set_font(font)
			draw_set_halign(aligns[0])
			draw_set_valign(aligns[1])
			draw_text(dx, dy, text)
			draw_set_color(ocolor)
			return [0, height]
		} else {
			return [0, 0]
		}
	}

	///@function draw(x, y)
	function draw(dx, dy) {
		var result = [0, 0]
		var oalpha = draw_get_alpha()
		var dalpha = oalpha * push.get()
		if opened {
			draw_set_alpha(1 - dalpha)
			result = draw_children(dx, dy)
		} else {
			draw_set_alpha(dalpha)
			result = draw_me(dx, dy)
		}
		// 이 주석을 해제하면 한번에 페이드 인아웃함.
		//draw_set_alpha(oalpha)
		return result
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
		if item.focusable {
			if item.openable and 0 < item.get_number() {
				with item {
					open()
					push.reset()
					global.menu_focused = self
				}
			}
			if item.predicate != -1 {
				item.predicate()
			}
		}
	}
}

function MenuSprite(spr): MenuItem() constructor {
	sprite = spr
	width = sprite_get_width(sprite)
	height = sprite_get_height(sprite)
	ax = 0
	ay = height * 0.5
	docked_center = true
	focusable = false

	///@function draw_me(x, y)
	function draw_me(dx, dy) {
		dx += ax
		dy += ay
		draw_sprite_ext(sprite, 0, dx, dy, 1, 1, 0, draw_get_color(), draw_get_alpha())

		if docked_center
			return [0, height]
		else
			return [width, height]
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
