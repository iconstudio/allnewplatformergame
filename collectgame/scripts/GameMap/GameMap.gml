/// @function GameMap
function GameMap() {

}

/// @function xell()
function xell() constructor {
	x = 0
	y = 0
	enable_phase = BOARD_CELL_STATES.NOTHING
	category = BOARD_CELL_CATEGORIES.NORMAL
	level = 0

	seed = random_get_seed()
	chunk = undefined // chunk would be a json struct

	static generate = function() {
		if is_undefined(chunk)
			exit

		var i, j, cx, cy, block_char, chk_length = string_length(chunk)
		for (i = 0; i < chk_length; ++i) {
			block_char = string_char_at(chunk, i + 1)
			if block_char == "\n" or block_char == " "
				continue

			cx = x + (i - floor(i / BLOCK_W) * BLOCK_W) * BLOCK_SIZE
			cy = y + floor(i / BLOCK_W) * BLOCK_SIZE
		}
	}

	static activate = function() {
		enable_phase = BOARD_CELL_STATES.ENABLED
		instance_activate_region(x, y, x + XELL_WIDTH, y + XELL_HEIGHT, true)
	}

	static deactivate = function() {
		enable_phase = BOARD_CELL_STATES.DISABLED
		instance_deactivate_region(x, y, x + XELL_WIDTH, y + XELL_HEIGHT, true, false)
		instance_activate_object(oPlayer)
	}

	static toString = function() { // json
		return "{\n"
		+ "\tseed: " + string(seed) + ", "
		+ "\tcategory: " + string(category) + ", "
		+ "\tlevel: " + string(level) + ", "
		+ "\tchunk: " + string(chunk)
		+ "\n}"
	}
}

/// @function make_xell(x_index, y_index)
function make_xell(U, V) {
	var thexell = new xell()
	thexell.x = U * XELL_WIDTH
	thexell.y = V * XELL_HEIGHT
	return thexell
}

/// @function make_special_xell(contents, x_index, y_index)
function make_special_xell(Content, U, V) {
	var thexell = new xell()
	thexell.x = U * XELL_WIDTH
	thexell.y = V * XELL_HEIGHT
	return thexell
}

/// @function xell_snap(x, y)
function xell_snap(X, Y) {
	return [floor(X / XELL_WIDTH) * XELL_WIDTH, floor(Y / XELL_HEIGHT) * XELL_HEIGHT]
}