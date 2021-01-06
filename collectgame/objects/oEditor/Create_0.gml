/// @description Initialization
Editor()

keyboard_set_map(vk_backspace, vk_escape)
window_set_cursor(cr_default)

grid_cursor_x = 0
grid_cursor_y = 0
grid_on = true
grid_surface = -1
grid_size = 16
grid_w_count = floor(PORT_WIDTH / grid_size)
grid_h_count = floor(PORT_HEIGHT / grid_size)
event_user(0)

key_plus = ord("+")
key_minus = ord("-")

editor_surface = -1
event_user(1)
