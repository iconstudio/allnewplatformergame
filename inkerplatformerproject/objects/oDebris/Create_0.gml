/// @description 파편 초기화
event_inherited()

lifetime = -1

function set_life(duration) {
	if lifetime == -1 {
		lifetime = new Countdown(-1, function() {
			instance_destroy()
		})
	}
	lifetime.set(duration)
}

/* 바닥 부딫힘 */
thud = function() {
	if 0 < yvel {
		move_outside_solid(90, 1)
		if global.speed_debri_bounced < yvel
			yvel *= -0.5
		else
			yvel = 0
	}
}

