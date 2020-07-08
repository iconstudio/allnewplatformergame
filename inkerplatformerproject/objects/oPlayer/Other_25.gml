event_inherited()

move_key_peek = RIGHT
move_dir = 0
move_spd = 92 / seconds(1)
move_spd_fast = 92 / seconds(1)
move_acc = move_spd / seconds(0.05)

jumping = false
jump_predicate = new timer(seconds(0.2), function() { // 2.5칸까지 점프
	yvel = -220 / seconds(1)
}, function() {
	yvel = -90 / seconds(1)
})

function jump() {
	jumping = true
	jump_predicate.reset()
}

function jump_end() {
	jumping = false
	jump.finish()
}

// ** 점프를 이르거나 늦게 눌렀을 때도 가능하게 **
jump_fore_predicate = new timer(seconds(0.15))
jump_fore_predicate.finish()

// ** 점프를 땅 위에서 내려가면서 눌렀을 때도 가능하게 **
jump_cliffoff_predicate = new timer(seconds(0.08))
jump_cliffoff_predicate.finish()

if jump_fore_available {
	if jump_fore_period <= ++jump_fore_time {
		jump_fore_time = jump_fore_period
		jump_fore_available = false
	}
}

if jump_cliffoff_time < jump_cliffoff_period {
	if jump_cliffoff_period < ++jump_cliffoff_time
		jump_cliffoff_time = jump_cliffoff_period
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
