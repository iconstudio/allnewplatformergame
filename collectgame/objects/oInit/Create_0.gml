globalvar frame_global;
frame_global = 0

#macro SECOND_TO_STEP 100 // room_speed (fps)
#macro STEP_TO_SECOND 0.01
#macro SECONDS *SECOND_TO_STEP
#macro MILLISECOND_TO_SECOND 0.000001
#macro METER_TO_PIXEL 10 // 1m == 10px

/*	for delta time
*/
#macro DELTA_KILOMETER_PER_SECOND 0.000001 * 25 / 9

/*	for real time process
		1. v [km / h] = v [km / 60m] = v [km / 3600sec]
		2. v [1000m / 3600sec] = v [10000px / 3600sec]
		3. v * (10000 / 3600) [px / sec] == 1
		4. v [px / sec] = 3600 / 10000 = 36 / 100 = 9 / 25
		5. 1 [km / h] == 25 / 9 [px / sec]
*/
#macro PIXEL_PER_SECOND 25 / 9
#macro PIXEL_PER_STEP 1 / 36
#macro KILOMETER_PER_HOUR /**/

globalvar FRICTION_HORIZONTAL, FRICTION_VERTICAL;

#macro GRAVITY KILOMETER_PER_HOUR(5)
#macro POP_SPEED_VERTICAL KILOMETER_PER_HOUR(80)
#macro TERMINAL_SPEED_VERTICAL KILOMETER_PER_HOUR(140)
#macro SLOPE_RATIO 0.7071067811 // sqrt(2) / 2
#macro SLOPE_MOUNT_VALUE 3

enum TERRAIN_TYPE {
	GROUND = 0,
	GLASS = 1,
	AIR = 2,
	WATER = 3,
	VISCOSITY = 4
}

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

#macro MASS_MAX 2
enum PHYSICS_MASS {
	TINY = -2,
	LIGHT = -1,
	NORMAL = 0,
	HEAVY = 1,
	GIANT = 2,
}

enum TAG_TYPES {
	CIRCLE, EYE, GLYPH, FIRE, DIAMOND
}

enum BOARD_CELL_CATEGORY {
	NOTHING = -1,
	NORMAL, TRAP, SHOP, LAIR,
	BORDER = 99
}

#macro NONE 0
#macro LEFT -1
#macro RIGHT 1
#macro UP -1
#macro DOWN 1

#macro GAME_BOARD_WIDTH_MAX 10
#macro GAME_BOARD_HEIGHT_MAX 10
#macro GAME_BOARD_SIZE 100
globalvar game_scene;

print = function(Container) {
	for (var i = 0; i < Container.get_size(); ++i)
		show_debug_message(Container.at(i))
}

TestList = new List()
repeat 10
	TestList.push_back(irandom(20))
TestSize = TestList.get_size()

show_debug_message("List: ")
show_debug_message("size: " + string(TestSize))
show_debug_message("get_capacity: " + string(TestList.get_capacity()))
print(TestList)

show_debug_message("Sorted: ")
TestList.sort(1, 6)
print(TestList)

show_debug_message("Popping: ")
repeat TestSize show_debug_message(TestList.pop_back())
show_debug_message(TestList.back())
show_debug_message("size: " + string(TestList.get_size()))


alarm[0] = 1
