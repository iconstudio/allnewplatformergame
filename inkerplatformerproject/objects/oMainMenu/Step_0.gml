/// @description 메뉴 선택 및 실행
update()
key_tick.update()

var KEY_PL = global.io_pressed_left
var KEY_PU = global.io_pressed_up
var KEY_PR = global.io_pressed_right
var KEY_PD = global.io_pressed_down
var KEY_U = global.io_up
var KEY_D = global.io_down
var KEY_CONFIRM = global.io_pressed_yes

if KEY_CONFIRM {
	with global.menu_opened {
		if child_focused != -1
			select(child_focused)
	}
} else if KEY_PU {
	if key_pick != UP {
		menu_focus_up()
		key_tick.set(key_duration_pick)
		key_pick = UP
	} else {
		key_pick = NONE
	}
} else if KEY_PD {
	if key_pick != DOWN {
		menu_focus_down()
		key_tick.set(key_duration_pick)
		key_pick = DOWN
	} else {
		key_pick = NONE
	}
} else if !KEY_U and !KEY_D {
	key_pick = NONE
}

// ** 좌우 입력은 따로 받는다. **
var SIDEKEY_INPUT = KEY_PR - KEY_PL
if SIDEKEY_INPUT != 0 {
	with global.menu_opened {
		if child_focused != -1 and child_focused.sidekey_predicate != -1 {
			child_focused.sidekey_predicate(SIDEKEY_INPUT)
		}
	}
}

if key_pick != NONE and key_tick.get() == 0 {
	if key_pick == UP {
		menu_focus_up()
		key_tick.set(key_duration_continue)
	} else if key_pick == DOWN {
		menu_focus_down()
		key_tick.set(key_duration_continue)
	}
}
