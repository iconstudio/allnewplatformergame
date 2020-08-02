/// @description 기본 속성 초기화
property_init()

prop_invincible = new countdown(-1, function() {
	invincible_alpha = 0
	show_debug_message("invincible end")
})
invincible_alpha = 0

prop_stun = new countdown(-1, function() {
	set_status(mob_status.normal)
	show_debug_message("stun end")
})

function update() {
	event_user(14)

	var sk = get_skills()
	if sk != -1 and struct_exists(sk) {
		sk.update()
	}
}
