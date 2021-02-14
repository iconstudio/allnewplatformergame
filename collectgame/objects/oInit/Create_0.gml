#region Generals
#macro SECOND_TO_STEP 100 // room_speed (fps)
#macro STEP_TO_SECOND 0.01

globalvar configuration;
configuration = os_get_config()
switch configuration {
	case "Default":
	case "Desktop":
		audio_channel_num(128)
	break

	case "Mobile":
		audio_channel_num(16)
	break

	case "Web":
		audio_channel_num(16)
	break

	default:
	break
}

#macro NONE 0
#macro LEFT -1
#macro RIGHT 1
#macro UP -1
#macro DOWN 1
#endregion

#region Physics
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
#macro COYOTE_WALL_PERIOD seconds(0.05)
#macro COYOTE_GROUND_PERIOD seconds(0.06)

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
enum ENTITY_STATES {
	IDLE = 0, STUNNED = 90, DEAD = 99
}

enum PLAYER_ACTION_MODES {
	IDLE, SPRING, LADDER, HANG
}

enum TAG_TYPES { CIRCLE, EYE, GLYPH, FIRE, DIAMOND }
#endregion

#region Game Logic
enum GAME_MANAGER_MODES {
	READY = 0,
	START_NEW_GAME,
	LOAD_SAVED,
	GENERATE_MAZE,
	GENERATE_ROOM,
	SAVE_GAME,
	ABANDON_GAME
}

enum ROOM_CATEGORY { NOTHING = 0, NORMAL = 1, SHOP, VILLAGE, TOWN, LAIR, }

enum BOARD_CELL_STATES { NOTHING = -1, DISABLED, ENABLED }

enum BOARD_CELL_CATEGORIES { NOTHING = -1, NORMAL, TRAP, SHOP, LAIR, BORDER = 99 }

#macro BLOCK_FINE_SIZE 8
#macro BLOCK_FINE_W 40
#macro BLOCK_FINE_H 40
#macro BLOCK_SIZE 16
#macro BLOCKS_H_NUMBER 20
#macro BLOCKS_V_NUMBER 15
#macro XELL_WIDTH BLOCKS_H_NUMBER * BLOCK_SIZE
#macro XELL_HEIGHT BLOCKS_V_NUMBER * BLOCK_SIZE

#macro GAME_BOARD_NUMBER_S 35
#macro GAME_BOARD_NUMBER_H 17
#macro GAME_BOARD_NUMBER GAME_BOARD_NUMBER_S * GAME_BOARD_NUMBER_S
globalvar game_scene;
global.game_board_chunks = ds_map_create()

#macro DIFFICULTY_MAX 10
global.diff_board_distribution = array_create(DIFFICULTY_MAX, 2)
global.diff_board_distribution[7] = 3
global.diff_board_distribution[6] = 3
//diff_board_distribution[3] = 1

global.board_default = ds_grid_create(GAME_BOARD_NUMBER_S, GAME_BOARD_NUMBER_S)
var range = GAME_BOARD_NUMBER_H + 3
ds_grid_clear(global.board_default, DIFFICULTY_MAX) // 10

var idiff = DIFFICULTY_MAX - 1, i
for (i = 0; 0 < idiff and i < DIFFICULTY_MAX and 0 < range; ++i) {
	ds_grid_add_disk(global.board_default, GAME_BOARD_NUMBER_H, GAME_BOARD_NUMBER_H, range, -1)
	range -= global.diff_board_distribution[idiff]
	idiff--
}
ds_grid_set(global.board_default, GAME_BOARD_NUMBER_H, GAME_BOARD_NUMBER_H, 0)
#endregion

#region Editor
enum EDITOR_STATE {
	READY_1 = 0,
}

#macro BLK 10

global.GAME_LAYER_NUMBER = 7
global.GAME_LAYERS = [
	["Background", "BG"],
	["Block_1", "Blocks Below"],
	["Traps", "Traps"],
	["Block_2", "Blocks"],
	["Instances", "Instances"],
	["interactions", "interactions"],
	["Player", "Player"],
	["Block_3", "Blocks Above"]
]
#endregion

#region Resoultions
#macro VIEW_WIDTH 320
#macro VIEW_HEIGHT 240
#macro PORT_SCALE 1
#macro PORT_WIDTH VIEW_WIDTH * PORT_SCALE
#macro PORT_HEIGHT VIEW_WIDTH * PORT_SCALE
#macro APP_WIDTH PORT_WIDTH * 1.5
#macro APP_HEIGHT PORT_HEIGHT * 1.5
window_set_size(APP_WIDTH, APP_HEIGHT)
global.app_position = [
	PORT_WIDTH * 0.25, //(APP_WIDTH - PORT_WIDTH) * 0.5,
	PORT_HEIGHT * 0.125 //APP_HEIGHT - PORT_HEIGHT) * 0.25
]

#macro GUI_WIDTH APP_WIDTH
#macro GUI_HEIGHT APP_HEIGHT

var i, cam
for (i = room_first; room_exists(i); i = room_next(i)) {
	room_set_view_enabled(i, true)

	cam = camera_create_view(0, 0, VIEW_WIDTH, VIEW_HEIGHT, 0, oPlayer, -1, -1, VIEW_WIDTH * 0.5, VIEW_HEIGHT * 0.5)
	room_set_camera(i, 0, cam)
	room_set_viewport(i, 0, true, 0, 0, PORT_WIDTH, PORT_HEIGHT)
}
//room_set_width(roomGame, GAME_BOARD_NUMBER_S * XELL_WIDTH)
//room_set_height(roomGame, GAME_BOARD_NUMBER_S * XELL_HEIGHT)
#endregion

#region Graphics
surface_depth_disable(false)

application_surface_enable(true)
application_surface_draw_enable(false)
surface_resize(application_surface, XELL_WIDTH, XELL_HEIGHT)

global.shGlow_sample = shader_get_sampler_index(shaderGlow, "s_glow_surface")
global.shGlow_pw = shader_get_uniform(shaderGlow, "u_glow_blur_sigma")
global.shGlow_resolution = shader_get_uniform(shaderGlow, "u_glow_resolution")
shader_set(shaderGlow)

shader_reset()
#endregion

randomize()

alarm[0] = 1
