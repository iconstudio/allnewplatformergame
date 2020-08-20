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

///@function MainEntryChapter(chapter)
function MainEntryChapter(ch): MenuItem() constructor {
	ch_index = ch
	serial = ch.get_serial_id()
	title = ch.get_title()
	subtitle = ch.get_description()
	width_real = parent.height_real - parent.border * 2 + global.menu_title_height
	width = width_real + 24
	height = width_real - global.menu_title_height
	ax = -width_real * 0.5

	///@function draw(x, y)
	function draw(dx, dy) {
		dx += ax
		draw_set_color($aeaeae)
		draw_rectangle(dx, dy, dx + width_real, dy + height, false)
		return get_size()
	}
}

///@function MainEntryCampaign(text)
function MainEntryCampaign(title): MenuEntry(title) constructor {
	border = global.menu_caption_height * 0.5
	width_real = global.menu_width
	width = 0
	height_real = global.menu_title_height + global.menu_caption_height
	height = height_real + global.menu_caption_height * 2
	focusable = true
	children_arrays = HORIZONTAL

	ch_number = chapter_get_number()
	for (var i = 0; i < ch_number; ++i) {
		var ch = chapter_get(i)
		var ch_entry = new MainEntryChapter(ch)
			
		add_general(ch_entry)
	}
	child_first.before = -1
	child_last.next = -1
	focus(child_first)

	function MainEntryCampaignPanel(): MenuItem() constructor {
		
	}
	panel = new MainEntryCampaignPanel()
	//add_general(panel)

	///@function draw_children(x, y)
	function draw_children(dx, dy) {
		draw_set_color($ffffff)
		draw_rectangle(0, dy, width_real, dy + height_real, false)
		if 0 < get_items_count() {
			var temp = []
			dy += border
			for (var i = 0; i < get_items_count(); ++i) {
				temp = get_child(i).draw(dx, dy)
				dx += temp[0]
			}
			dy += temp[1]
			dy = dy + height_real + global.menu_caption_height
		}
	}

	/*
	///@function draw(x, y)
	function draw(dx, dy) {
		dx += ax
		dy += ay
		var oalpha = draw_get_alpha()
		var dalpha = oalpha
		if opened
			dalpha = 1

		draw_set_alpha(dalpha * 0.2)
		draw_children(dx, dy)

		draw_set_alpha(oalpha)
		draw_set_color($ffffff)
		return get_size()
	}
	

	predicate = function() {
		panel.open()
	}*/
}
