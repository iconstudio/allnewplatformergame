/// @description 물리 초기화
xvel = 0
yvel = 0
grav = global.gravity_normal

was_on_ground = false
now_on_ground = false

function ground_at_beneath() {
	var fy = floor(y)
	return !place_free(x, fy + 1) or instance_place(x, fy + 1, oPlatform)
}

update = function() {
	if xvel != 0 {
		
	}

	if yvel != 0 {
		
	}
}


push = function() {
	
}

thud = function() {
	
}
