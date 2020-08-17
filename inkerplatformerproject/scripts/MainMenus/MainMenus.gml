function menu_init_basic() {
	enable = true
	visible = true
	push = -1
	opened = false
	focusable = true
	openable = true

	children = []
	child_focused = -1
	child_first = -1
	child_last = -1
	index = -1
	pole = false // 선택할 수 있는 양 끝점 항목인가
	pole_first = -1 // 처음으로 선택할 수 있는 항목
	pole_last = -1 // 마지막으로 선택할 수 있는 항목
	children_arrays = VERTICAL
	child_count = 0
	next = -1
	before = -1

	sidekey_predicate = -1 // 좌우 메뉴 선택키 입력받기.

	function update_children() {
		if 0 < child_count {
			for (var i = 0; i < child_count; ++i)
				get_child(i).update()
		}
	}

	function update() {
		if enable
			update_children()
	}

	function add_general(item) {
		if item.focusable {
			if pole_first == -1 {
				pole_first = item
				item.pole = true
			} else if 0 < child_count {
				if pole_last != -1 {
					pole_last.pole = false
					pole_last = item
					item.pole = true
				} else {
					pole_last = item
					item.pole = true
				}
			} 
		}

		if 0 < child_count {
			item.before = child_last
			item.next = child_first
			child_first.before = item
			child_last.next = item
		} else {
			child_first = item
		}

		item.index = child_count
		child_last = item
		children[child_count++] = item
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

	///@function add_indicator(caption, variable_name, variable_predicate, predicate)
	function add_indicator(caption, var_name, var_pred, pred) {
		var result = new MenuIndicator(caption, var_name, var_pred, pred)
		return add_general(result)
	}

	///@function add_option(caption, variable_name, variable_predicate, predicate)
	function add_option(caption, var_name, var_pred, pred) {
		var result = new MenuOption(caption, var_name, var_pred, pred)
		return add_general(result)
	}

	///@function add_space(width, height)
	function add_space(w, h) {
		var result = new MenuSpace(w, h)
		return add_general(result)
	}

	///@function add_separator()
	function add_separator() {
		return add_space(0, global.menu_header_height - global.menu_caption_height)
	}

	function focus(item) {
		if item != -1 and child_focused != item {
			if item.focusable {
				child_focused = item
				return true
			} else if 1 < child_count {
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
		if enable {
			opened = select_argument(flag, true)
			global.menu_opened_prev = global.menu_opened
			if opened
				global.menu_opened = self
			else
				global.menu_opened = parent
			global.main_menu.entry_push.reset()
		}
	}

	function select(item) {
		if item.enable {
			if item.openable and 0 < item.get_items_count() {
				with item {
					open()
				}
			}
			if item.predicate != -1 {
				item.predicate()
			}
		}
	}

	function get_child(index) {
		return children[index]
	}

	function get_items_count() {
		return child_count
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

	function update() {
		if enable {
			update_children()
		}
	}

	///@function draw_children(x, y)
	function draw_children(dx, dy) {
		var temp
		for (var i = 0; i < get_items_count(); ++i) {
			temp = get_child(i).draw(dx, dy)
			dx += temp[0]
			dy += temp[1]
		}
	}

	///@function draw(x, y)
	function draw(dx, dy) {
		if !enable {
			return [0, 0]
			exit
		}

		return get_size()
	}

	function get_width() {
		return width
	}

	function get_height() {
		return height
	}

	///@function get_size()
	function get_size() {
		return [get_width(), get_height()]
	}
}

///@function MainEntryChapter(serial)
function MainEntryChapter(sn): MenuItem() constructor {
	index = 0
	
}

///@function MainEntryCampaign()
function MainEntryCampaign(): MenuItem() constructor {
	width = global.menu_width
	width_real = width
	height = global.menu_title_height + global.menu_caption_height
	height_real = global.menu_title_height
	focusable = true
	openable = true

	///@function draw(x, y)
	function draw(dx, dy) {
		var oalpha = draw_get_alpha()
		draw_set_alpha(oalpha * 0.2)
		//draw_set_color(0)
		draw_set_color($ffffff)
		draw_rectangle(0, dy, width_real, dy + height_real, false)
		draw_set_alpha(oalpha)
		if 0 < get_items_count() {
			var temp = []
			for (var i = 0; i < get_items_count(); ++i) {
				temp = get_child(i).draw(dx, dy)
				dx += temp[0]
				dy += temp[1]
			}
		}

		draw_set_alpha(oalpha)
		draw_set_color($ffffff)
		return get_size()
	}
}

///@function MenuEntry(text, tooltip, predicate)
function MenuEntry(title, description, pred): MenuItem() constructor {
	font = fontMainMenuEntry
	text = title
	tip = description
	width = 0
	predicate = select_argument(pred, -1)
	aligns = [1, 1]

	///@function draw(x, y)
	function draw(dx, dy) {
		if enable and text != "" {
			if visible {
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
			}
			return get_size()
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
	
	///@function draw(x, y)
	function draw(dx, dy) {
		if enable and text != "" {
			if visible {
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
			}
			return get_size()
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
	height = global.menu_header_height
}

///@function MenuIndicator(text, variable_name, variable_predicate, predicate)
function MenuIndicator(caption, var_name, var_pred, pred): MenuEntry(caption, "", pred) constructor {
	variable_name = var_name
	variable_predicate = select_argument(var_pred, -1)
	aligns = [0, 1]

	function make_vars_string() {
		if variable_global_exists(variable_name) and variable_predicate != -1
			return ": " + variable_predicate(variable_global_get(variable_name))
		else
			return ": ERROR"
	}

	///@function draw(x, y)
	function draw(dx, dy) {
		if enable {
			if visible {
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
			}
			return get_size()
		} else {
			return [0, 0]
		}
	}
}

///@function MenuOption(text, variable_name, variable_predicate, predicate)
function MenuOption(caption, var_name, var_pred, pred): MenuIndicator(caption, var_name, var_pred, pred) constructor {
	function make_vars_string() {
		if variable_struct_exists(global.settings, variable_name) and variable_predicate != -1
			return ": " + variable_predicate(variable_struct_get(global.settings, variable_name))
		else
			return ": ERROR"
	}
}

function MenuSprite(spr): MenuItem() constructor {
	sprite = spr
	scale = 1
	width_real = sprite_get_width(sprite)
	width = 0
	height_real = sprite_get_height(sprite)
	height = height_real
	ax = 0
	ay = height * 0.5
	docked_center = true
	focusable = false
	openable = false

	function make_docked(flag) {
		docked_center = flag
		if docked_center
			width = 0
		else
			width = width_real
	}

	///@function draw(x, y)
	function draw(dx, dy) {
		if enable {
			if visible and scale != 0 {
				dx += ax
				dy += ay
				draw_sprite_ext(sprite, 0, dx, dy, scale, scale, 0, draw_get_color(), draw_get_alpha())
			}

			return get_size()
		} else {
			return [0, 0]
		}
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
	} else {
		var found_prev = item
		var found = item.before
		while true {
			if found == -1
				return found_prev
			if found.focusable
				return found
			found_prev = found
			found = found.before
		}
	}
}

function menu_find_down(item) {
	if item == -1 {
		return -1
	} else {
		var found_prev = item
		var found = item.next
		while true {
			if found == -1
				return found_prev
			if found.focusable
				return found
			found_prev = found
			found = found.next
		}
	}
}

function menu_focus_up() {
	with global.menu_opened {
		var target = menu_find_up(child_focused)
		if target != -1
			focus(target)
		return target
	}
}

function menu_focus_down() {
	with global.menu_opened {
		var target = menu_find_down(child_focused)
		if target != -1
			focus(target)
		return target
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
