/// @description 주 메뉴 초기화
event_user(10)
event_user(11)
event_user(12)

mode_change(mode_menu)
//mode_change(mode_menu)

key_pick = NONE
key_duration_pick = seconds(0.4)
key_duration_continue = seconds(0.12)
key_tick = new Countdown();

function key_lockon(dir) {
	key_tick.set(key_duration_pick)
	key_pick = dir
}

function key_goon(dir) {
	key_tick.set(key_duration_continue)
}

function key_lockoff() {
	key_pick = NONE
	key_tick.finish()
}
