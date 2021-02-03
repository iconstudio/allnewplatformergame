/// @description Initialization
var Rectangler = function(): QuiEntry(false, true) constructor {
	x = 40 + irandom(820)
	y = 40 + irandom(820)
	size_x = 60
	size_y = 60

	static draw = function() {
		if self == global.qui_cursor
			draw_set_color($ff)
		else
			draw_set_color($ffffff)
		draw_rectangle(0, 0, size_x, size_y, true)
	}
}

MainEntryButton = function(Caption, Pred): QuiButton(Caption, 0, 0, Pred, 0.5, 0.5) constructor {
	
}

with global.qui_master {
	
}

show_qui_popup("Test Title", "Test Label")

menu_item_current = undefined
menu_item_previous = undefined

global.main_menu_id = id
