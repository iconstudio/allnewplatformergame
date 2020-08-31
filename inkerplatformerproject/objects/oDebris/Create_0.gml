/// @description 파편 초기화
event_inherited()

bounce_y = 0.4
bounce_y_threshold = global.speed_debri_bounced

lifetime = -1

function set_life(duration) {
	if lifetime == -1 {
		lifetime = new Countdown(-1, function() {
			instance_destroy()
		})
	}
	lifetime.set(duration)
}
