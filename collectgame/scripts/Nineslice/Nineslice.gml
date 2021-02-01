/// @function Nineslice(sprite, border_width, border_height, [inner_is_tile=false], [border_is_tile=false])
function Nineslice(Sprite, Bwidth, Bheight) {
	sprite_index = Sprite
	size_x = sprite_get_width(Sprite)
	size_y = sprite_get_height(Sprite)
	inner_tiled = 2 < argument_count ? argument[2] : false
	border_tiled = 3 < argument_count ? argument[3] : false

	border_w = Bwidth
	border_h = Bheight

	part_inner_x = [Bwidth, size_x - Bwidth * 2]
	part_inner_y = [Bheight, size_x - Bheight * 2]
	part_lu_x = [0, Bwidth]
	part_lu_y = [0, Bheight]
	part_ru_x = [size_x - Bwidth, size_x]
	part_ru_y = [0, Bheight]
	part_ld_x = [0, Bwidth]
	part_ld_y = [size_y - Bheight, size_y]
	part_rd_x = [size_x - Bwidth, size_x]
	part_rd_y = [size_y - Bheight, size_y]

	static draw = function(Subimg, X, Y, Width, Height, Xscale, Yscale, Blend, Alpha) {
		if inner_tiled {
			
		} else {
			draw_sprite_part_ext(sprite_index, Subimg, part_inner_x[0], part_inner_y[0], part_inner_x[1], part_inner_y[1], X, Y, Xscale, Yscale, Blend, Alpha)
		}
	}
}
