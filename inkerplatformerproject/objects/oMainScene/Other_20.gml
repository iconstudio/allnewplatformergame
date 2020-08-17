/// @description 메뉴 속성 선언
global.main_menu = id
global.menu_begin_y = global.client.height * 0.135
global.menu_width = global.client.width
global.menu_title_height = global.client.height * 0.4 // 대략 150 ~ 200
global.menu_title_y = global.menu_begin_y + global.menu_title_height * 0.5
global.menu_caption_width = global.client.width * 0.3
global.menu_title_scale = 1
global.menu_title_scale_main = 0.7
global.menu_header_height = 48
global.menu_caption_height = 42
center_x = global.client.width * 0.5
center_y = global.client.height * 0.5
x = center_x
y = global.menu_begin_y
scrolling = false

menu_push = new Countdown()
entry_push = new Timer(seconds(0.2))
entry_push.finish()
global.menu_opened_prev = -1
global.menu_opened = id

menu_init_basic()
opened = true

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
	var oalpha = draw_get_alpha()
	var push = entry_push.get()
	var alpha = oalpha * (1 - push)
	
	if 0 < alpha and global.menu_opened_prev != -1 {
		with global.menu_opened_prev {
			if 0 < get_items_count() {
				draw_set_alpha(alpha)
				draw_children(dx, dy)
			}
		}
	}

	alpha = oalpha * push
	if 0 < alpha {
		with global.menu_opened {
			if 0 < get_items_count() {
				draw_set_alpha(alpha)
				draw_children(dx, dy)
			}
		}
	}
	draw_set_alpha(1)
}

function init() {
	for (var i = 0; i < get_items_count(); ++i) {
		with get_child(i) {
			parent = other.id
		}
	}
}

function menu_mode(order, create, step, drawer) constructor {
	index = order
	on_create = method(global.main_menu, create)
	on_step = method(global.main_menu, step)
	on_draw = method(global.main_menu, drawer)

	function init() {
		on_create()
	}

	function update() {
		on_step()
	}

	function draw() {
		on_draw()
	}
}

mode = -1
function mode_change(target) {
	if mode != target {
		mode = target
		mode.init()
	}
	return mode
}
