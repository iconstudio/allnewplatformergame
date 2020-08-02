display_set_gui_maximize()

if global.flag_is_mobile {
	window_set_fullscreen(true)
	os_powersave_enable(false)
} else {
	window_center()
}

instance_create(oGlobal)

alarm[1] = 10
