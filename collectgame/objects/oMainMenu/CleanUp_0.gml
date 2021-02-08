/// @description Clean up
if surface_exists(Page_surface)
	surface_free(Page_surface)

keyboard_set_map(vk_space, vk_space)
keyboard_set_map(ord(","), ord(","))
keyboard_set_map(ord("X"), ord("X"))
keyboard_set_map(ord("."), ord("."))
keyboard_set_map(ord("C"), ord("C"))

keyboard_set_map(ord("J"), ord("J"))
keyboard_set_map(ord("L"), ord("L"))
keyboard_set_map(ord("I"), ord("I"))
keyboard_set_map(ord("K"), ord("K"))
