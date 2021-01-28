/// @description 메뉴 항목 열거
draw_set_font(fontMenu)
with menu_add_entry_caption("Campaign", callback_select_campaign_fixed) {
	menu_entry_set_delegate_back(callback_menu_back)
	menu_add_other(oMenuEntryCampaign, id)
	menu_add_entry_caption("Back", callback_menu_back)
}

with menu_add_entry_caption("Endless") {
	menu_entry_set_delegate_back(callback_menu_back)
	menu_add_entry_caption("Back", callback_menu_back)
}

with menu_add_entry_caption("Setting") {
	menu_entry_set_delegate_back(callback_menu_back)
	with menu_add_entry_caption("BGM Volume", -1, predicate_volume_music) {
		menu_entry_set_delegate_back(callback_menu_back)
		with menu_add_other(oMenuEntrySlider, id) {
			value = setting_get_value("volume_music")
			value_min = 0
			value_max = 10
			callback = callback_set_music_volume
		}
		menu_add_entry_caption("Back", callback_menu_back)
	}
	with menu_add_entry_caption("SFX Volume", -1, predicate_volume_sfx) {
		menu_entry_set_delegate_back(callback_menu_back)
		with menu_add_other(oMenuEntrySlider, id) {
			value = setting_get_value("volume_sfx")
			value_min = 0
			value_max = 10
			callback = callback_set_sfx_volume
		}
		menu_add_entry_caption("Back", callback_menu_back)
	}
	if global.flag_is_desktop {
		with menu_add_entry_caption("Fullscreen", -1, predicate_fullscreen) {
			menu_entry_set_delegate_back(callback_menu_back)
			with menu_add_other(oMenuEntrySlider, id) {
				value = setting_get_value("fullscreen")
				value_min = 0
				value_max = 1
				callback = callback_set_fullscreen
				iterate_predicate = predicate_slider_fullscreen
				can_wrap = true
			}
			menu_add_entry_caption("Back", callback_menu_back)
		}
	}

	if !global.flag_is_mobile {
		with menu_add_entry_caption("Keyboard Controls") {
			menu_entry_set_delegate_back(callback_menu_back)
		
			menu_add_entry_caption("Back", callback_menu_back)
		}
	}
	if gamepad_is_supported() {
		with menu_add_entry_caption("Gamepad Controls") {
			menu_entry_set_delegate_back(callback_menu_back)
			
			menu_add_entry_caption("Back", callback_menu_back)
		}
	}

	with menu_add_entry_caption("Graphics", -1, predicate_graphics) {
		menu_entry_set_delegate_back(callback_menu_back)
		with menu_add_other(oMenuEntrySlider, id) {
			value = setting_get_value("graphics")
			value_min = 0
			value_max = 2
			callback = callback_set_graphics
			iterate_predicate = predicate_slider_graphics
		}
		menu_add_entry_caption("Back", callback_menu_back)
	}

	menu_add_entry_caption("Back", callback_menu_back)
}

with menu_add_entry_caption("Credit") {
	menu_entry_set_delegate_back(callback_menu_back)
	menu_add_entry_caption("Content")
	menu_add_entry_caption("Back", callback_menu_back)
	menu_choice(1)
}

menu_add_entry_caption("Exit", callback_menu_exit)

menu_choice(entry_choice_index)
