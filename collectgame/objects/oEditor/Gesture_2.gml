/// @description Start dragging
if is_undefined(mode) or mode == TOOL_CURSOR
	event_perform(ev_mouse, ev_global_middle_press)
