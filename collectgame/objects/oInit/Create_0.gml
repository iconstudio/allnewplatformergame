globalvar frame_global;
frame_global = 0

#macro SECOND_TO_STEP 100 // room_speed (fps)
#macro STEP_TO_SECOND 0.01

#macro MILLISECOND_TO_SECOND 0.000001
#macro METER_TO_PIXEL 8 // 1m == 8px
#macro KILOMETER_TO_PIXEL 8000 // 1km == 1000m

/*
	for delta time
		1. 1000m / 3600s = 10 / 36 = 5 / 18
		2. 5 / 18 * 8px = 40 / 18 = 20 / 9
		3. ms = 0.000001s
		4. 1km / 3600sec == 0.000001 * 20 / 9 [px / s]

		1. 0.000001 * 20 / 9 * KILOMETER_TO_PIXEL * SECOND_TO_STEP(100)
		2. 0.0001 * 20 / 9 * KILOMETER_TO_PIXEL(8000)
		3. 0.8 * 20 / 9
		4. (8 / 10) * (20 / 9) = (4 / 5) * (20 / 9)
		5. 80 / 45 == 16 / 9
*/
#macro DELTA_KILOMETER_PER_SECOND 0.000001 * 20 / 9
#macro DELTA_PIXEL_PER_STEP 16 / 9

/*
	for real time process
		1. v [km / h] = v [km / 60m] = v [km / 3600sec]
		2. v [1000m / 3600sec] = v [8000px / 3600sec]
		3. v * (8000 / 3600) [px / sec] == 1
		4. v [px / sec] = 3600 / 8000 = 36 / 80 = 9 / 20
*/
#macro PIXEL_PER_SECOND 9 / 20
#macro PIXEL_PER_STEP 9 / 2000
#macro KILOMETER_PER_HOUR /**/

globalvar FRICTION_HORIZONTAL;
globalvar FRICTION_VERTICAL;
#macro GRAVITY KILOMETER_PER_HOUR(8)
#macro TERMINAL_SPEED_VERTICAL KILOMETER_PER_HOUR(120)

FRICTION_HORIZONTAL = [
	KILOMETER_PER_HOUR(10),
	KILOMETER_PER_HOUR(5),
	KILOMETER_PER_HOUR(1),
	KILOMETER_PER_HOUR(40),
	KILOMETER_PER_HOUR(50)
]

FRICTION_VERTICAL = [
	0,
	0,
	0,
	GRAVITY * 0.5,
	GRAVITY * 0.9
]

enum TERRAIN_TYPE {
	GROUND = 0,
	GLASS = 1,
	AIR = 2,
	WATER = 3,
	VISCOSITY = 4
}

enum PHYSICS_MASS {
	TINY = -2,
	LIGHT = -1,
	NORMAL = 0,
	HEAVY = 1,
	GIANT = 2,
}

instance_create_layer(0, 0, layer, oGlobal)

alarm[0] = 1
