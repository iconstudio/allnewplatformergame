/// @description 피해 입히기
if other.is_awake() {
	with other {
		stun(seconds(0.5))
		xvel = sign(x - other.x) * 2
		yvel = -140 / seconds(1)
	}
}
