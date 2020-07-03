event_inherited()

move_key_peek = RIGHT
move_dir = 0
move_spd = 92 / seconds(1)
move_acc = move_spd / seconds(0.05)

jumping = false
jump = new timer(seconds(0.2), function() { // 2.5칸까지 점프
	yvel = -220 / seconds(1)
}, function() {
	yvel = -90 / seconds(1)
})

function update_friction(on_ground) {
	if on_ground {
		if move_dir != 0
			fric = 0
		else
			fric = global.friction_ground
	} else {
		fric = global.friction_air
	}
}
