/// @description Setting up
switch configuration {
	case "Default":
	case "Desktop":
		window_center()
		window_set_position(window_get_x(), 40)
		audio_channel_num(128)
	break

	default:
	break
}

display_set_gui_maximize()

alarm[2] = 1
