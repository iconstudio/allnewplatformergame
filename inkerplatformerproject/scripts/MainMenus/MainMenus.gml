function menu_init_basic() {
	push = new Timer(seconds(0.7))
	opened = false
	focusable = true
	openable = true

	children = []
	child_focused = -1
	child_first = -1
	child_last = -1
	pole = false // 선택할 수 있는 양 끝점 항목인가
	pole_first = -1 // 처음으로 선택할 수 있는 항목
	pole_last = -1 // 마지막으로 선택할 수 있는 항목
	children_arrays = VERTICAL
	number = 0
	next = -1
	before = -1

	sidekey_predicate = -1 // 좌우 메뉴 선택키 입력받기.

	function update_general() {
		push.update()
		if 0 < number {
			for (var i = 0; i < number; ++i)
				get(i).update()
		}
	}

	function update() {
		update_general()
	}

	function add_general(item) {
		child_last = item
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

	///@function add_entry(title, description, [predicate])
	function add_entry(title, description, predicate) {
		var result = new MenuEntry(title, description, predicate)
		return add_general(result)
	}

	///@function add_header(caption)
	function add_header(caption) {
		var result = new MenuHeader(caption)
		return add_general(result)
	}

	///@function add_text(caption)
	function add_text(caption) {
		var result = new MenuText(caption)
		return add_general(result)
	}

	///@function add_sprite(sprite)
	function add_sprite(spr) {
		var result = new MenuSprite(spr)
		return add_general(result)
	}

	///@function add_option(caption, variable_name, variable_predicate, predicate)
	function add_option(caption, var_name, var_pred, pred) {
		var result = new MenuOption(caption, var_name, var_pred, pred)
		return add_general(result)
	}

	///@function add_setting_option(caption, variable_name, variable_predicate, predicate)
	function add_setting_option(caption, var_name, var_pred, pred) {
		var result = new MenuSettingOption(caption, var_name, var_pred, pred)
		return add_general(result)
	}

	///@function add_space(width, height)
	function add_space(w, h) {
		var result = new MenuSpace(w, h)
		return add_general(result)
	}

	function focus(item) {
		if item != -1 {
			if item.focusable {
				child_focused = item
				return true
			} else if 1 < number {
				if item.next != -1
					focus(item.next)
			} else {
				return false
			}
		} else {
			return false
		}
	}

	///@function open([flag])
	function open(flag) {
		opened = select_argument(flag, true)
		if opened
			global.menu_opened = self
		else
			global.menu_opened = parent
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

	sprite = -1
	text = ""
	width = global.menu_caption_width
	height = global.menu_caption_height
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
		return [width, height]
	}

	///@function draw(x, y)
	function draw(dx, dy) {
		var oalpha = draw_get_alpha()
		var result = [0, 0]
		if global.menu_opened == self {
			if parent != -1 and parent.opened and !opened
				result = draw_me(dx, dy)
			else
				draw_children(global.main_menu.x, global.main_menu.y)
		} else if global.menu_opened == parent {
			if parent != -1 and parent.opened
				result = draw_me(dx, dy)
		}
		draw_set_alpha(oalpha)
		return result
	}

	function get_width() {
		return width
	}

	function get_height() {
		return height
	}
}

///@function MenuEntry(text, tooltip, predicate)
function MenuEntry(title, description, predicate): MenuItem() constructor {
	font = fontMainMenuEntry
	text = title
	tip = description
	self.predicate = select_argument(predicate, -1)
	aligns = [1, 1]

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
}

///@function MenuText(text)
function MenuText(caption): MenuEntry(caption, "", -1) constructor {
	font = fontMainMenuEntry
	text = caption
	focusable = false
	openable = false
	color = $cccccc
	
	///@function draw_me(x, y)
	function draw_me(dx, dy) {
		if text != "" {
			dx += ax
			dy += ay
			var ocolor = draw_get_color(), ofont = draw_get_font()
			draw_set_color(color)
			draw_set_font(font)
			draw_set_halign(aligns[0])
			draw_set_valign(aligns[1])
			draw_text(dx, dy, text)
			draw_set_color(ocolor)
			draw_set_font(ofont)
			return [0, height]
		} else {
			return [0, 0]
		}
	}
}

///@function MenuHeader(text)
function MenuHeader(caption): MenuText(caption) constructor {
	font = fontMainMenuHeader
	text = caption
	color = $ffade5
}

///@function MenuOption(text, variable_name, variable_predicate, predicate)
function MenuOption(caption, var_name, var_pred, pred): MenuEntry(caption, "", pred) constructor {
	variable_name = var_name
	variable_predicate = select_argument(var_pred, -1)
	aligns = [0, 1]

	function make_vars_string() {
		if variable_global_exists(variable_name) and variable_predicate != -1
			return ": " + variable_predicate(variable_global_get(variable_name))
		else
			return ": ERROR"
	}

	///@function draw_me(x, y)
	function draw_me(dx, dy) {
		dx += ax
		dy += ay
		var ocolor = draw_get_color(), ofont = draw_get_font()
		if focusable and parent.child_focused == self
			draw_set_color(c_orange)
		draw_set_font(font)
		draw_set_halign(aligns[0])
		draw_set_valign(aligns[1])
		var value_string = make_vars_string()

		var sw = string_width(text)
		var sx = floor(dx - sw)
		draw_text(sx, dy, text)
		draw_set_color($ffffff)
		draw_text(sx + sw, dy, value_string)

		draw_set_color(ocolor)
		draw_set_font(ofont)
		return [0, height]
	}
}

///@function MenuSettingOption(text, variable_name, variable_predicate, predicate)
function MenuSettingOption(caption, var_name, var_pred, pred): MenuOption(caption, var_name, var_pred, pred) constructor {
	function make_vars_string() {
		if variable_struct_exists(global.settings, variable_name) and variable_predicate != -1
			return ": " + variable_predicate(variable_struct_get(global.settings, variable_name))
		else
			return ": ERROR"
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
	openable = false

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

function MenuSpace(w, h): MenuItem() constructor {
	width = w
	height = h
	focusable = false
	openable = false
}

function menu_goto_back() {
	if parent != -1 {
		with parent
			open(false)
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

function callback_indicator(value) {
	return string(value)
}

function callback_indicator_off(value) {
	if value == 0
		return "Off"
	else
		return string(value)
}

function callback_indicator_flags(value) {
	if value
		return "On"
	else
		return "Off"
}
