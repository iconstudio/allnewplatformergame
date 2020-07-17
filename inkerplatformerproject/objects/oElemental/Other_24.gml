/// @description 스텝 이벤트
if 0 <= prop_stun.get()
	exit

var dist = distance_to_point(global.playerpos[0], global.playerpos[1])

if dist < 8 {
	xvel = 0
	yvel = 0
} else {
	var dir = point_direction(x, y, global.playerpos[0], global.playerpos[1])
	xvel = lx(dir) * 0.3
	yvel = ly(dir) * 0.3
	/*//move_towards_point(oPlayer.x, oPlayer.y, 0.2)
	xvel = sign(global.playerpos[0] - x) * 0.3
	yvel = sign(global.playerpos[1] - y) * 0.3

	if xvel != 0 and yvel != 0 {
		xvel *= global.speed_interpolation
		yvel *= global.speed_interpolation
	}
	*/
}
