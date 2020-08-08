/// @description 주 메뉴 초기화
global.main_menu = id
center_x = global.client.width * 0.5
center_y = global.client.height * 0.5
global.menu_title_height = global.client.height * 0.4
global.menu_caption_width = global.client.width * 0.3
global.menu_caption_height = 52
x = center_x
y = global.client.height * 0.14

key_peek = RIGHT
key_dir = 0
key_tick = new Countdown()

event_user(10)

title = new MenuItem()
with title {
	focusable = false

	function draw_me(dx, dy) {
		return [0, global.menu_title_height]
	}
}

add_general(title)
focus(add("Start", "aa", function() {
	
}))
add("Log", "aa")
add("Setting", "aa")
add("Exit", "aa")
