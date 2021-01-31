/// @description Update interfaces
global.qui_mx = device_mouse_x_to_gui(0)
global.qui_my = device_mouse_y_to_gui(0)

Qui_update(global.qui_master, 0, 0)
global.qui_cursor = Qui_prefix(global.qui_master, 0, 0)
