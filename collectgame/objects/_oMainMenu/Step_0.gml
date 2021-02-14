/// @description state
if mode == QUI_STATES.OPENING {
	if mode_time < mode_open_period {
		mode_time++
	} else {
		mode = QUI_STATES.IDLE
		mode_time = 0
	}
} else if mode == QUI_STATES.CLOSING {
	if mode_time < mode_close_period {
		mode_time++
	} else {
		mode = QUI_STATES.STOP
		mode_time = 0
		Qui_close(global.qui_master)
	}
}
