/// @description 초기화
damage = 1
type = damage_types.physical
element = elements.none

// ** 피해 입히기 (기본 함수) **
function do_hit(target) {
	if hit_try(target, damage, type, element) {
		with target {
			do_invincible(seconds(0.5))
			do_knockback(sign(x - other.x) * 2)
		}
		return true
	}
	return false
}
