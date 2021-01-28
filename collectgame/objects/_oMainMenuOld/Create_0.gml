/// @description 메뉴 초기화
lock = false

// 메뉴 장면
TITLE_APPEAR = 0
TITLE_IDLE = 1
MAIN_ENTER = 2
MAIN_IDLE = 4
MAIN_BACK_TO_TITLE = 20
TITLE_EXIT = 90
MAIN_EXIT = 91

appear_time = 0 
appear_period = seconds(0.9)
idle_await_time = 0
idle_await_period = seconds(0.6)
disappear_time = 0 
disappear_period = seconds(0.4)
title_y = global.resolutions_gui[1] * 0.5
title_disappear_y = global.resolutions_gui[1] * 0.43
x = global.resolutions_gui[0] * 0.5
y = title_disappear_y
image_alpha = 0
//image_xscale = 0
//image_yscale = 0
main_alpha = 0
menu_appear_time = 0 
menu_appear_period = seconds(0.7)
reappear_time = 0 
reappear_period = seconds(1)
input_delay_time = 0
input_delay_period = seconds(0.2)
exit_time = 0 
exit_period = seconds(0.4)
scene = TITLE_APPEAR//MAIN_IDLE

// 메뉴 그리기 속성
menu_surface = -1
menu_texture = pointer_null
menu_drawn_x_default = 8
menu_drawn_y_default = 8
menu_drawn_y_target = menu_drawn_y_default
menu_drawn_y_begin = menu_drawn_y_target
menu_drawn_y = menu_drawn_y_target
menu_drawn_y_period = seconds(0.46)
menu_drawn_y_time = menu_drawn_y_period
menu_drawn_y_push = 0

menu_surface_count = floor(menu_drawn_y_default * 1.2)
menu_surface_alpha = 1 / menu_surface_count
menu_surface_width = global.resolutions_gui[0]
menu_surface_middle_y = menu_surface_count
menu_surface_middle_height = global.resolutions_gui[1] - menu_surface_count * 2
menu_surface_bottom_y = menu_surface_count + menu_surface_middle_height

menu_entry_color_selected = $b507fe
menu_entry_width_addition = 8
menu_entry_font_scale = 22 / 20

// 메뉴 항목
opened = true // 주 메뉴는 무조건 true지만 디버그 용으로 남겨둔다.
open_time = 1
open_period = 1
back_delegate = -1
entry_list = ds_list_create()
entry_current_opened = id // 현재 가장 하위에 있는 열린 메뉴
entry_last = noone // 종류를 막론하고 마지막으로 선택된 메뉴 항목
entry_choice = noone
entry_choice_index = 0

// 메뉴 항목 열거
event_user(0)

// 배경
// 서피스 두개 써서 구현할 것. 서피스 투명도 더하는 예제 찾아볼 것. 
bg_theme = chapter_get_first()
SHOW = 0
OPENING = 10
FADEOUT = 90
bg_scene = SHOW
rainy_time = 0
rainy_duration = seconds(0.06)
rainy_counts_min = 6
rainy_counts_random_max = 3

global.application_texels = [texture_get_texel_width(global.application_texture), texture_get_texel_height(global.application_texture)]
shader_set(shaderOutline)
//shader_set_uniform_f(global.shaderOutline_resolution, global.application_sizes[0], global.application_sizes[1])
shader_set_uniform_f(global.shaderOutline_resolution, 640, 540)
shader_reset()
shader_set(shaderBlur)
shader_set_uniform_f(global.shaderBlur_resolution, global.application_sizes[0], global.application_sizes[1])
shader_reset()
shader_set(shaderBlurCentral)
shader_set_uniform_f(global.shaderBlurCentral_resolution, global.application_sizes[0], global.application_sizes[1])
shader_reset()
