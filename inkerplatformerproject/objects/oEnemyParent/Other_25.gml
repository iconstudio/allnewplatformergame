/// @description 적 초기화
event_inherited()

hierarchy = noone // 부모
target = noone

ai_pattern = -1
walk_speed = 48 / seconds(1)

thorny = false // 플레이어와 접촉으로 피해 입히기
thorns = -1

function get_thorny() {
	return thorny
}

///@function make_thorny([flag], [damage])
function make_thorny(flag, dmg) {
	var value = argument_select(flag, true)
	thorny = value

	if value {
		var value_dmg = argument_select(dmg, 1)
		if struct_exists(thorns) {
			thorns.damage = value_dmg
		} else {
			thorns = {
				type: elements.none,
				damage: value_dmg,
				consistency: false // 무적 시간을 주지 않고 지속적으로 피해를 주는가
			}
		}
		return thorns
	} else {
		if struct_exists(thorns) {
			delete thorns
		}
	}
}
