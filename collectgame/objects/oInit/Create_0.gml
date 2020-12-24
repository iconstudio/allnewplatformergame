#region Generals
globalvar configuration;
configuration = os_get_config()
#endregion

#region Physics
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
#endregion

#region Game
enum SCENE_STATE {
	READY_1 = 0,
	READY_2 = 1,
	GAME = 10,
	SCORE = 50,
	END = 80,
	CLEAN = 90,
	EXIT_TO_MENU = 99
}

enum TAG_TYPES {
	CIRCLE, EYE, GLYPH, FIRE, DIAMOND
}

enum BOARD_CELL_CATEGORY {
	NOTHING = -1,
	NORMAL, TRAP, SHOP, LAIR,
	BORDER = 99
}

#macro BLOCK_SIZE 16
#macro BLOCK_W 20
#macro BLOCK_H 20

#macro GAME_BOARD_W 10
#macro GAME_BOARD_H 10
#macro GAME_BOARD_NUMBER 100
globalvar game_scene;
#endregion

#region Graphics
#macro GAME_WIDTH BLOCK_W * BLOCK_SIZE
#macro GAME_HEIGHT BLOCK_H * BLOCK_SIZE
#macro PORT_WIDTH 640
#macro PORT_HEIGHT 640

#macro WINDOW_WIDTH 640
#macro WINDOW_HEIGHT 480
#macro APP_SCALE 2.0
#macro APP_WIDTH WINDOW_WIDTH * APP_SCALE
#macro APP_HEIGHT WINDOW_HEIGHT * APP_SCALE
global.app_position = [
	(APP_WIDTH - PORT_WIDTH) * 0.5,
	(APP_HEIGHT - PORT_HEIGHT) * 0.25
]

window_set_min_width(WINDOW_WIDTH)
window_set_min_height(WINDOW_HEIGHT)
window_set_size(APP_WIDTH, APP_HEIGHT)

var i, cam
for (i = room_first; room_exists(i); i = room_next(i)) {
	room_set_view_enabled(i, true)

	cam = camera_create_view(0, 0, GAME_WIDTH, GAME_HEIGHT, 0, oPlayer, -1, -1, GAME_WIDTH * 0.5, GAME_HEIGHT * 0.5)
	room_set_camera(i, 0, cam)
	room_set_viewport(i, 0, true, 0, 0, PORT_WIDTH, PORT_HEIGHT)
}

application_surface_enable(true)
application_surface_draw_enable(false)
surface_resize(application_surface, GAME_WIDTH, GAME_HEIGHT)
#endregion

#macro NONE 0
#macro LEFT -1
#macro RIGHT 1
#macro UP -1
#macro DOWN 1

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
