/// @description 주 메뉴 초기화
draw_set_font(fontMainMenuEntry)
center_x = global.client.width * 0.5
center_y = global.client.height * 0.5
global.menu_start_y = global.client.height * 0.14
global.menu_title_height = global.client.height * 0.4
global.menu_caption_height = 52

key_peek = RIGHT
key_dir = 0
key_tick = new Countdown()

event_user(10)
