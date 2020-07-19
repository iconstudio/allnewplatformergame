/// @description 그리기
event_user(10)

var inv_count = prop_invincible.get()
if 0 < inv_count {
	var limit = ceil(prop_invincible.get_max())
	var base = limit + 1
	var pos = -base
	var time = limit - inv_count
	
	var moded = inv_count mod 5
	if moded < 3 or base - 3 < inv_count {
		invincible_alpha = logn(base, -time - pos) + 0.2
		//show_debug_message(invincible_alpha)
	} else if invincible_alpha != 0 {
		invincible_alpha *= 0.5
	}

	shader_set(shaderBleaching)
	draw_sprite_ext(sprite_index, -1, floor(x), round(y), img_xscale, 1, img_angle, $ffffff, invincible_alpha)
	shader_reset()
}
