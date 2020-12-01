#macro SECOND_TO_STEP 100 // room_speed (fps)
#macro STEP_TO_SECOND 0.01

#macro MILLISECOND 0.000001
#macro METER_TO_PIXEL 8 // 1m == 8px

/*
		1000m / 3600s == 10 / 36 = 5 / 18;
		5 / 18 * 8px = 40 / 18 = 20 / 9;
*/
#macro KILOMETER_PER_MILLISECOND 0.00002 / 9

#macro GRAVITY (3)

globalvar FRICTION_HORIZONTAL;
FRICTION_HORIZONTAL = [
	(10),
	(5),
	(1),
	(40),
	(50)
]

globalvar FRICTION_VERTICAL;
FRICTION_VERTICAL = [
	0,
	0,
	0,
	GRAVITY * 0.5,
	GRAVITY * 0.9
]

#macro TERMINAL_SPEED_VERTICAL (120)

enum TERRAIN_TYPE {
	GROUND = 0,
	GLASS = 1,
	AIR = 2,
	WATER = 3,
	VISCOSITY = 4
}

instance_create_layer(0, 0, layer, oGlobal)

alarm[0] = 1
