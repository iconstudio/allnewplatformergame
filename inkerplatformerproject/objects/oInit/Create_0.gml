/// @description 초기화
global.timescale = 1.00

global.gravity_normal = 20 / seconds(1)
global.friction_air = 5 / seconds(1)
global.friction_ground = 95 / seconds(1)
global.yvel_max = 256 / seconds(1)

global.skills = {
	database: ds_map_create()
}

#macro NONE -1
#macro LEFT 0
#macro RIGHT 2
#macro UP 1
#macro DOWN 3

enum entity_state {
	normal = 0,
	stunned = 90,
	dead
}


alarm[0] = 1
