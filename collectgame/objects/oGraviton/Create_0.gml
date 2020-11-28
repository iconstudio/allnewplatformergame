// 8 픽셀 == 1 미터
phy_mess = 8.0 / 1
phy_velocity = (((1000.0 / 60) / 60) * phy_mess)

var xdist = delta_velocity(self.xVel) * frame_time
var xc = xdist + sign(xdist)
phy_collide = {}
if place_free(xc, y)
    x += xdist
else
    phy_collide(xdist)
		
global.gravity_normal = phy_velocity * 100
