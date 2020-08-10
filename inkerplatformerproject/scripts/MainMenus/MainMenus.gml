function menu_init_basic() {
	push = new Timer(seconds(0.7))

	mdepth = 0
	children = []
	child_focused = -1
	child_first = -1
	child_last = -1
	number = 0
	next = -1
	before = -1
	pole = false
	poled_first = false
	poled_last = false

	function update() {
		push.update()
		if 0 < number {
			for (var i = 0; i < number; ++i)
				get(i).update()
		}
	}

	function add_general(item) {
		child_last = item
		item.mdepth = self.mdepth + 1
		if 0 < number {
			var cbefore = children[number - 1]
			item.before = cbefore
			cbefore.next = item
		} else {
			child_first = item
		}
		
		children[number++] = item
		return item
	}

	///@function add(title, description, [predicate])
	function add(title, description, predicate) {
		var result = new MenuItem()
		result.text = title
		result.tip = description
		result.predicate = select_argument(predicate, -1)
		return add_general(result)
	}

	function focus(item) {
		child_focused = item
	}

	///@function open([flag])
	function open(flag) {
		opened = select_argument(flag, true)
		if opened
			global.menu_opened = self
		else
			global.menu_opened = parent
		global.menu_depth = global.menu_opened.mdepth
		show_debug_message(global.menu_depth)
	}

	function select(item) {
		if item.openable and 0 < item.get_number() {
			with item {
				open()
				push.reset()
			}
		}
		if item.predicate != -1 {
			item.predicate()
		}
	}

	function get(index) {
		return children[index]
	}

	function get_number() {
		return number
	}
}

///@function MenuItem()
function MenuItem() constructor {
	menu_init_basic()
	parent = other
	predicate = -1
	opened = false
	focusable = true
	openable = true

	sprite = -1
	font = fontMainMenuEntry
	text = ""
	tip = ""
	width = global.menu_caption_width
	height = global.menu_caption_height
	aligns = [1, 1]
	ax = 0
	ay = 0

	///@function draw_children(x, y)
	function draw_children(dx, dy) {
		if 0 < number {
			var temp
			for (var i = 0; i < number; ++i) {
				temp = get(i).draw(dx, dy)
				dx += temp[0]
				dy += temp[1]
			}
		}
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
		var oalpha = draw_get_alpha()
		var result = [0, 0]
		if mdepth == global.menu_depth {
			if !opened
				result = draw_me(dx, dy)
		} else if mdepth == global.menu_depth + 1 {
			//if parent != -1 and parent.opened
				draw_children(global.main_menu.x, global.main_menu.y)
		}
		draw_set_alpha(oalpha)
		return result

		/*
		var oalpha = draw_get_alpha()
		var dalpha = oalpha * push.get()
		if mdepth == global.menu_depth { // 현재 펼쳐진 메뉴
			draw_set_alpha(dalpha)
			if opened
				draw_children(global.main_menu.x, global.main_menu.y)
			else
				result = draw_me(dx, dy)
		} else if mdepth < global.menu_depth { // 더 깊은 메뉴
			draw_set_alpha(1 - dalpha)
			if opened {
				draw_children(global.main_menu.x, global.main_menu.y)
			} else {
				result = draw_me(dx, dy)
			}
		}
		draw_set_alpha(oalpha)*/
	}

	function get_width() {
		return global.menu_caption_width
	}

	function get_height() {
		return global.menu_caption_height
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

function menu_find_up(item) {
	if item == -1 {
		return -1
	} else if item.focusable { // 인자는 이미 이전 항목을 받아옴.
		return item
	} else {
		var result = item.before
		while result != -1 {
			if result.focusable
				return result

			result = result.before
		}
		return -1
	}
}

function menu_find_down(item) {
	if item == -1 {
		return -1
	} else if item.focusable { // 인자는 이미 이전 항목을 받아옴.
		return item
	} else {
		var result = item.next
		while result != -1 {
			if result.focusable
				return result

			result = result.next
		}
		return -1
	}
}

function menu_focus_up() {
	with global.menu_opened {
		var target = menu_find_up(child_focused.before)
		if target != -1
			focus(target)
	}
}

function menu_focus_down() {
	with global.menu_opened {
		var target = menu_find_down(child_focused.next)
		if target != -1
			focus(target)
	}
}
