///@function MainEntryIndicator(text, variable_name, [indicate_predicate], [predicate])
function MainEntryIndicator(caption, var_name, indic_pred, pred): MenuIndicator(caption, var_name, indic_pred, pred) constructor {
	function find_variable(str) {
		if variable_struct_exists(global.settings, str)
			return variable_struct_get(global.settings, str)
		else
			return undefined
	}
}

///@function MainEntryOption(text, [predicate])
function MainEntryOption(caption, pred): MenuEntry(caption, "", -1) constructor {
	option_method = pred

	predicate = function() {
		option_method(self.index)
		menu_goto_back()
	}
}

///@function MainEntryChapter(serial)
function MainEntryChapter(sn): MenuItem() constructor {
	serial = sn
	ch_index = 0
	title = ""
	subtitle = ""
}

///@function MainEntryCampaign()
function MainEntryCampaign(): MenuItem() constructor {
	width_real = global.menu_width
	width = 0
	height_real = global.menu_title_height + global.menu_caption_height
	height = height_real + global.menu_caption_height * 2
	focusable = true
	openable = false
	child_can_choice_unopened = true
	selection = 0

	///@function draw(x, y)
	function draw(dx, dy) {
		var oalpha = draw_get_alpha()
		var dalpha = oalpha
		if opened
			dalpha = 1

		draw_set_alpha(dalpha * 0.2)
		//draw_set_color(0)
		draw_set_color($ffffff)
		draw_rectangle(0, dy, width_real, dy + height_real, false)
		draw_set_alpha(dalpha)
		if 0 < get_items_count() {
			var temp = []
			dy += global.menu_caption_height
			for (var i = 0; i < get_items_count(); ++i) {
				temp = get_child(i).draw(dx, dy)
				dx += temp[0]
				dy += temp[1]
			}
			dy = dy + height_real + global.menu_caption_height
		}

		draw_set_alpha(oalpha)
		draw_set_color($ffffff)
		return get_size()
	}

	predicate = function() {
		
	}
}
