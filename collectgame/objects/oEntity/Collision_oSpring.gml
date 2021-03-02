/// @description Sprung
var Dir = other.image_angle
switch Dir {
	case 0:
		velocity_x = SPRUNG_SPEED_X
		velocity_y = SPRUNG_SPEED_Y
	break

	case 90:
		velocity_x = 0
		velocity_y = -SPRUNG_SPEED_X
	break

	case 180:
		velocity_x = -SPRUNG_SPEED_X
		velocity_y = SPRUNG_SPEED_Y
	break

	case 270:
		velocity_x = 0
		velocity_y = SPRUNG_SPEED_X
	break

	default:
		velocity_x = lengthdir_x(SPRUNG_SPEED_X, Dir)
		velocity_y = -abs(lengthdir_y(SPRUNG_SPEED_Y, Dir + 90))
	break
}

other.image_speed = 1
