/// @description Setting up window
switch configuration {
	case "Default":
	case "Desktop":
		window_center()
		window_set_position(window_get_x(), 40)
	break

	default:
	break
}

instance_create_layer(0, 0, layer, oGlobal)
instance_create_layer(0, 0, layer, oGamepad)

alarm[2] = 1
