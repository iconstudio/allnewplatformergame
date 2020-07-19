/// @description 피해 입히기
if other.is_awake() {
	with other {
		do_knockback(sign(x - other.x) * 2)
		do_hurt(other.damage)
	}
}
