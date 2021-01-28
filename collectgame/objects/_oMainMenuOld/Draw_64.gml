/// @description 메뉴 그리기
if !surface_exists(menu_surface)
	event_user(1)

surface_set_target(menu_surface)
draw_clear_alpha(0, 0)
if 0 < main_alpha {
	draw_set_alpha(main_alpha)
	menu_draw(menu_drawn_x_default, menu_drawn_y + menu_drawn_y_push)
	draw_set_alpha(1)
}
surface_reset_target()
/*
for (var i = 0; i < menu_surface_count; ++i) {
	draw_surface_part_ext(menu_surface, 0, i, menu_surface_width, 1, 0, i, 1, 1, $ffffff, menu_surface_alpha * (i + 1))
}
draw_surface_part_ext(menu_surface, 0, menu_surface_middle_y, menu_surface_width, menu_surface_middle_height, 0, menu_surface_middle_y, 1, 1, $ffffff, 1)
for (i = 0; i < menu_surface_count; ++i) {
	draw_surface_part_ext(menu_surface, 0, menu_surface_bottom_y + i, menu_surface_width, 1, 0, menu_surface_bottom_y + i, 1, 1, $ffffff, 1 - menu_surface_alpha * (i + 1))
}
*/
draw_surface_ext(menu_surface, 0, 0, 1, 1, 0, $ffffff, 1)
