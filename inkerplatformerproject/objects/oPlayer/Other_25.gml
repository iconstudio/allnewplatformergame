event_inherited()

move_key_peek = RIGHT
move_dir = 0
move_spd_normal = 92 / seconds(1)
move_spd_fast = 142 / seconds(1)
move_spd = move_spd_normal
move_acc = move_spd / seconds(0.05)

jumping = false
jump_predicate = new timer(seconds(0.2), function() { // 2.5칸까지 점프
	yvel = -220 / seconds(1)
}, function() {
	yvel = -80 / seconds(1)
})

// ** 점프를 이르거나 늦게 눌렀을 때도 가능하게 **
jump_fore_predicate = new timer(seconds(0.08))
jump_fore_predicate.finish()

// ** 점프를 땅 위에서 내려가면서 눌렀을 때도 가능하게 **
jump_cliffoff_predicate = new timer(seconds(0.05))
jump_cliffoff_predicate.finish()

function jump() {
	jumping = true
	jump_predicate.reset()
	jump_fore_predicate.finish()
	jump_cliffoff_predicate.finish()
}

function jump_end() {
	jumping = false
	jump_predicate.finish()
	jump_fore_predicate.finish()
	jump_cliffoff_predicate.finish()
}

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
