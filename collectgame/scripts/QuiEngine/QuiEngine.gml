#macro QUI_TR_PERIOD 20 // 0.2 second
#macro QUI_TILE_MARGIN 20
#macro QUI_BUTTON_HEIGHT 50
#macro QUI_TEXT_MARGIN 6
#macro QUI_TITLEBAR_MARGIN 8
#macro QUI_TITLEBAR_HEIGHT 40
#macro QUI_WINDOW_SHRINK 5
enum QUI_STATES { STOP = -1, OPENING, IDLE, CLOSING }
	
enum QUI_IO_STATES { NOTHING = -1, KEYBOARD, MOUSE }

/// @function QuiEntry(expandable, interactible)
function QuiEntry(CanExpand, CanInteract) constructor {
	static toString = function() { return "QuiObject" }

	tr_state = QUI_STATES.OPENING
	tr_count = 0

	// logic
	expandable = CanExpand
	children_list = CanExpand ? new List() : undefined
	focus_level = 0
	phase = 0

	// flags
	enabled = true
	paused = false
	visible = true
	interactive = CanInteract

	// visuality
	size_x = 0
	size_y = 0
	x = 0 // initial coordinates in the parent
	y = 0
	drawn_x = 0 // actual drawn coordinates in the parent
	drawn_y = 0
	anchor_x = 0
	anchor_y = 0

	// predicates
	static close = undefined
	static control = undefined
	static destroy = undefined
	static update = undefined
	static draw = undefined

	// families
	parent = undefined
	child_focused = undefined
	child_first = undefined
	child_last = undefined
	brother_before = undefined
	brother_next = undefined

	/// @function add_entry(items, ...)
	static add_entry = CanExpand ? function() {
		if 0 == argument_count
			throw "No argument in add_entry."

		var Last_entry
		if 1 < argument_count {
			for (var i = 0; i < argument_count; ++i) {
				Last_entry = argument[i]
				if Last_entry.interactive {
					if is_undefined(child_first) {
						child_first = Last_entry
					} else {
						child_first.brother_before = Last_entry
						child_last.brother_next = Last_entry
						Last_entry.brother_before = child_last
						Last_entry.brother_next = child_first
					}
					child_last = Last_entry

					if is_undefined(child_focused)
						child_focused = Last_entry
				}
				Last_entry.parent = self
				children_list.push_back(Last_entry)
			}
		} else {
			Last_entry = argument[0]
			if Last_entry.interactive {
				if is_undefined(child_first) {
					child_first = Last_entry
				} else {
					child_first.brother_before = Last_entry
					child_last.brother_next = Last_entry
					Last_entry.brother_before = child_last
					Last_entry.brother_next = child_first
				}
				child_last = Last_entry

				if is_undefined(child_focused)
					child_focused = Last_entry
			}
			Last_entry.parent = self
			children_list.push_back(Last_entry)
		}
		return self
	}: undefined

	/// @function make_then(other)
	static make_then = add_entry

	/// @function focus()
	static focus = function() {
		with parent
			child_focused = other
	}

	/// @function set_position(x, y)
	static set_position = function(X, Y) {
		x = X
		y = Y
		return self
	}

	/// @function set_x(pos)
	static set_x = function(X) {
		x = X
		return self
	}

	/// @function set_y(pos)
	static set_y = function(Y) {
		y = Y
		return self
	}

	/// @function set_size(width, height)
	static set_size = function(Width, Height) {
		size_x = Width
		size_y = Height
		return self
	}

	/// @function set_width(value)
	static set_width = function(Value) {
		size_x = Value
		return self
	}

	/// @function set_height(value)
	static set_height = function(Value) {
		size_y = Value
		return self
	}

	/// @function set_anchor(anchor_horizontal, anchor_vertical)
	static set_anchor = function(Anchx, Anchy) {
		anchor_x = Anchx
		anchor_y = Anchy
		return self
	}

	/// @function clear_itself()
	static clear_itself = function() {
		if !is_undefined(destroy)
			destroy()
		if expandable {
			with children_list
				foreach(0, get_size(), function(Child) { Child.clear_children() })
		}
		return self
	}
}

/// @function QuiContainer(x, y, width, height)
function QuiContainer(X, Y, Width, Height): QuiEntry(true, false) constructor {
	static toString = function() { return "Container" }

	x = X
	y = Y
	size_x = Width
	size_y = Height
}

/// @function show_qui_popup(title, content_label, [width=default], [height=default])
function show_qui_popup(Title, Description) {
	var Panel = new QuiWindow(GUI_WIDTH * 0.5, GUI_HEIGHT * 0.5, GUI_WIDTH * 0.6, GUI_HEIGHT * 0.8)
	Panel.anchor_x = 0.5
	Panel.anchor_y = 0.5
	if 2 < argument_count {
		Panel.size_x = argument[2]
		if 3 < argument_count
			Panel.sisze_y = argument[3]
	}

	var MaxWidth = Panel.size_x
	var Content = new QuiLabel(Description, 0, QUI_TITLEBAR_HEIGHT, 0, 0, MaxWidth - QUI_TEXT_MARGIN * 2)
	var OkButton = new QuiButton("Ok", MaxWidth * 0.5, Panel.size_y - QUI_BUTTON_HEIGHT - QUI_TITLEBAR_HEIGHT - QUI_TEXT_MARGIN, undefined, 0.5, 0.5)
	OkButton.predicate = method(OkButton, function() { Qui_close(parent) })
	var Titlebar = new QuiTitlebar(Title, Panel, MaxWidth)
	Panel.make_then(OkButton, Content, Titlebar)
	Qui_awake(global.qui_master, Panel)
	Panel.focus()

	return Panel
}

/// @function QuiTitlebar(title, window, width)
function QuiTitlebar(Caption, Panel, Width): QuiEntry(false, false) constructor {
	static toString = function() { return "Titlebar: " + string(caption) }

	image_alpha = 1
	image_blend = $ffffff//$E0801A

	pressed = false
	caption = Caption
	bind = Panel

	size_x = Width
	size_y = QUI_TITLEBAR_HEIGHT
	start_x = 0
	start_y = 0

	static update = function() {
		if self == global.qui_cursor {
			if global.io_mouse_pressed_left {
				pressed = true
				start_x = global.qui_mx
				start_y = global.qui_my
			}
		}
		if !global.io_mouse_left or global.io_mouse_released_left {
			pressed = false
		}

		if pressed and 0 <= global.qui_my and global.qui_my < GUI_HEIGHT {
			var x_bonus = global.qui_mx - start_x
			var y_bonus = global.qui_my - start_y
			bind.x += x_bonus
			bind.y += y_bonus
			start_x = global.qui_mx
			start_y = global.qui_my
		}
	}

	static draw = function() {
		draw_set_alpha(draw_get_alpha() * image_alpha)
		//draw_set_color(image_blend)
		//draw_rectangle(0, 0, size_x, size_y, false)
		draw_set_color(image_blend)
		draw_set_font(fontQuiTitle)
		draw_set_halign(1)
		draw_set_valign(1)
		draw_text(size_x * 0.5, size_y * 0.5, caption)
	}
}

/// @function QuiWindow(x, y, width, height)
function QuiWindow(X, Y, Width, Height): QuiEntry(true, false) constructor {
	static toString = function() { return "Window (" + string(size_x) + ", " + string(size_y) + ")" }

	image_alpha = 1
	image_blend = $ffffff

	x = X
	y = Y
	size_x = Width
	size_y = Height

	static draw = function() {
		draw_set_alpha(draw_get_alpha() * image_alpha)
		draw_set_color(image_blend)
		draw_splice(sWindowSplices, 5, 0, -QUI_WINDOW_SHRINK, -QUI_WINDOW_SHRINK, size_x + QUI_WINDOW_SHRINK * 2, size_y + QUI_WINDOW_SHRINK * 2)
	}
}

/// @function QuiLabel(caption, x, y, [align_x=0], [align_y=0], [seperate_width=default])
function QuiLabel(Caption, X, Y): QuiEntry(false, false) constructor {
	static toString = function() { return "Label: " + string(caption) }

	caption = Caption 
	image_alpha = 1
	image_blend = $ffffff

	x = X
	y = Y
	draw_set_font(fontQuiText)
	align_x = 0
	align_y = 0
	sep_size = size_x + 1
	if 3 < argument_count {
		align_x = argument[3]
		if 4 < argument_count {
			align_y = argument[4]
			if 5 < argument_count
				sep_size = argument[5]
		}
	}
	size_x = string_width_ext(Caption, -1, sep_size) + QUI_TEXT_MARGIN * 2
	size_y = string_height_ext(Caption, -1, sep_size) + QUI_TEXT_MARGIN * 2

	static draw = function() {
		draw_set_alpha(draw_get_alpha() * image_alpha)
		draw_set_color(image_blend)
		draw_set_font(fontQuiText)
		draw_set_halign(align_x)
		draw_set_valign(align_y)
		draw_text_ext(QUI_TEXT_MARGIN, QUI_TEXT_MARGIN, caption, -1, sep_size)
	}
}

/// @function QuiButton(caption, x, y, [predicate], [ax=0], [ay=0])
function QuiButton(Caption, X, Y): QuiEntry(false, true) constructor {
	static toString = function() { return "Button of " + sprite_get_name(sprite_index) + ": " + string(caption) }

	pressed = false
	caption = Caption

	sprite_index = sButtonSplices
	edge = 5
	image_alpha = 1
	image_blend = $ffffff

	x = X
	y = Y
	draw_set_font(fontQuiText)
	size_x = string_width(Caption) + QUI_TILE_MARGIN * 2
	size_y = QUI_BUTTON_HEIGHT //string_height(Caption) + QUI_TILE_MARGIN * 2

	predicate = undefined
	if 3 < argument_count {
		predicate = argument[3]
		if 4 < argument_count {
			anchor_x = argument[4]
			if 5 < argument_count
				anchor_y = argument[5]
		}
	}

	static update = function() {
		if global.qui_io_last == QUI_IO_STATES.MOUSE {
			if self == global.qui_cursor {
				if !pressed {
					if global.io_mouse_pressed_left {
						pressed = true
						focus()
					}
				} else { // pressed
					if global.io_mouse_released_left {
						if !is_undefined(predicate)
							predicate()
						pressed = false
					}
				}
				if global.io_pressed_back
					pressed = false
				if pressed
					phase = 2
				else
					phase = 1
			} else {
				if global.io_pressed_back
					pressed = false
				if pressed and ((!global.io_mouse_left and configuration == "Mobile") or global.io_mouse_released_left)
					pressed = false

				if pressed
					phase = 3
				else
					phase = 0
			}
		} else if global.qui_focused == self {
			var check = (global.io_pressed_right or global.io_pressed_down) - (global.io_pressed_left or global.io_pressed_up)
			if check == 1 {
				if !is_undefined(brother_next)
					brother_next.focus()
				pressed = false
				phase = 0
			} else if check == -1 {
				if !is_undefined(brother_before)
					brother_before.focus()
				pressed = false
				phase = 0
			} else {
				phase = 1
				if global.io_pressed_yes {
					if !is_undefined(predicate)
						predicate()
					phase = 2
				}
			}
		} else {
			phase = 0
		}
	}

	static draw = function() {
		var Alpha = draw_get_alpha() * image_alpha
		draw_set_alpha(Alpha)
		draw_set_color(image_blend)
		switch phase {
			case 0:
				draw_sprite_stretched_ext(sprite_index, 0, 0, 0, size_x, size_y, image_blend, Alpha)
		        break

			case 1:
				draw_splice(sprite_index, edge, 1, 0, 0, size_x, size_y)
		        break

			case 2:
				draw_sprite_stretched_ext(sprite_index, 2, 0, 0, size_x, size_y, image_blend, Alpha)
		        break

			case 3:
				draw_splice(sprite_index, edge, 3, 0, 0, size_x, size_y)
		        break

			default:
				break
		}

		draw_set_color(0)
		draw_set_font(fontQuiText)
		draw_set_halign(1)
		draw_set_valign(1)
		draw_text(size_x * 0.5, size_y * 0.5, caption)
	}
}

/// @function Qui_control(child)
function Qui_control(Item) {
	with Item {
		if !enabled or paused or !visible or size_x == 0 or size_y == 0
			return undefined

		if expandable {
			var i, Child, Seek = Item.child_focused
			with children_list {
				for (i = 0; i  < get_size(); ++i) {
					Child = at(i)
					if Seek == Child {
						return Qui_control(Child)
					}
				}
			}
		}
		return self
	}
}

/// @function Qui_prefix(child, x, y, focus_level)
function Qui_prefix(Item, X, Y, FcLvl) {
	if is_undefined(Item)
		return undefined

	with Item {
		if !enabled or !visible or size_x == 0 or size_y == 0
			return undefined

		var Sx, Sy, Lx, Ly
		Sx = drawn_x
		Sy = drawn_y
		Lx = Sx + size_x
		Ly = Sy + size_y
		focus_level = FcLvl
		if tr_state != QUI_STATES.IDLE
			return undefined

		if point_in_rectangle(global.qui_mx, global.qui_my, Sx, Sy, Lx, Ly) {
			var Picked = undefined, Result = undefined
			if expandable {
				var i, Child
				with children_list {
					for (i = get_size(); 0 < i; --i) {
						Child = at(i - 1)
						Result = Qui_prefix(Child, Sx, Sy, FcLvl + 1)
						if !is_undefined(Result) and is_undefined(Picked) {
							Picked = Result
						}
					}
				}
			}

			if is_undefined(Picked)
				return self
			else
				return Picked
		}
	}
	return undefined
}

/// @function Qui_update(child, x, y)
function Qui_update(Item, X, Y) {
	if is_undefined(Item)
		exit

	with Item {
		if !enabled or !visible // does not interact, but interrupts the cursor
			exit

		var Sx = X + x - size_x * anchor_x
		var Sy = Y + y - size_y * anchor_y
		drawn_x = Sx
		drawn_y = Sy
		focus_level = 0

		if paused
			exit

		if tr_state == QUI_STATES.OPENING {
			if tr_count < QUI_TR_PERIOD {
				tr_count++
			} else {
				tr_state = QUI_STATES.IDLE
			}
		} else if tr_state == QUI_STATES.CLOSING {
			if tr_count < QUI_TR_PERIOD {
				tr_count--
			} else {
				tr_count = 0
				if is_undefined(close)
					Qui_destroy(self)
				else
					close()
			}
		}

		if expandable {
			var i, Child
			with children_list {
				for (i = 0; i < get_size(); ++i) {
					Child = at(i)
					Qui_update(Child, Sx, Sy)
				}
			}
		}

		if !is_undefined(update)
			update()
	}
}

/// @function Qui_draw(child)
function Qui_draw(Item) {
	with Item {
		if !enabled or !visible
			exit

		var Alpha = draw_get_alpha(), Color = draw_get_color()
		if !is_undefined(draw) {
			draw_transform_stack_push()
			draw_transform_set_translation(drawn_x, drawn_y, 0)
			draw()
			draw_transform_stack_pop()
		}

		if expandable {
			with children_list {
				foreach(0, get_size(), Qui_draw)
			}
		}
		draw_set_alpha(Alpha)
		draw_set_color(Color)
	}
}

/// @function Qui_awake(host, item)
function Qui_awake(Host, Item) {
	with Host {
		add_entry(Item)
	}
	return Item
}

/// @function Qui_open(item)
function Qui_open(Item) {
	with Item {
		tr_state = QUI_STATES.OPENING
		tr_count = 0
	}
}

/// @function Qui_close(item)
function Qui_close(Item) {
	Item.tr_state = QUI_STATES.CLOSING
}

/// @function Qui_destroy(item)
function Qui_destroy(Item) {
	with Item {
		tr_state = QUI_STATES.STOP
		enabled = false
		expandable = false
		clear_itself()
		delete children_list

		if !is_undefined(parent) {
			with parent.children_list {
				remove(0, get_size(), Item)
			}
		}
	}

	delete Item
}
