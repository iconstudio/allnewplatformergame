/// @description 초기화
application_surface_enable(true)
application_surface_draw_enable(false)
device_mouse_dbclick_enable(false)

global.client = {
	width: 960,
	height: 608,
	
	game_width: 960,
	game_height: 480,

	view_width: 480,
	view_height: 240,

	border: 5
}

window_set_size(global.client.width, global.client.height)
surface_resize(application_surface, global.client.game_width, global.client.game_height)
//display_set_gui_size(global.client.width, global.client.height)

#macro NONE -1
#macro LEFT 0
#macro RIGHT 2
#macro UP 1
#macro DOWN 3

global.timescale = 1.00

global.gravity_normal = 20 / seconds(1)
global.friction_air = 5 / seconds(1)
global.friction_ground = 95 / seconds(1)
global.yvel_max = 256 / seconds(1)
global.speed_interpolation = 1 / sqrt(2)

global.playerpos = [0, 0]
global.playerpos_visible = [0, 0]

global.__function_null = function() {}
#macro FUNC_NULL global.__function_null
global.skills = {
	database: ds_map_create()
}

global.__lengthdir_cashed = array_create(361, [0, 0])
for (var i = 0; i <= 360; ++i) {
	global.__lengthdir_cashed[i][0] = lengthdir_x(1, i)
	global.__lengthdir_cashed[i][1] = lengthdir_y(1, i)
}

enum entity_state {
	normal = 0,
	stunned = 90,
	dead
}

globalvar ease;
ease = new (function() constructor {
	static c1 = 1.70158
	static c2 = c1 * 1.525
	static c3 = c1 + 1
	static c4 = 2 * pi / 3
	static c5 = 2 * pi / 4.5
	static n1 = 1 / 2.75
	static n2 = 2 / 2.75
	static n3 = 2.5 / 2.75
	static d1 = 1.5 / 2.75
	static d2 = 2.25 / 2.75
	static d3 = 2.625 / 2.75

	function linear(x) { return x; }

	/// sine
	function in_sine(x) { return 1 - cos(x * pi * 0.5); }
	function out_sine(x) { return sin(x * pi * 0.5); }
	function inout_sine(x) { return 0.5 - cos(x * pi) * 0.5; }

	// quad
	function in_quad(x) { return power(x, 2); };
	function out_quad(x) { return 1 - power(1 - x, 2); };
	function inout_quad(x) { return (x < 0.5) ? (2 * power(x,2)) : (1 - power(-2 * x + 2, 2) * 0.5); };

	// cubic
	function in_cubic(x) { return power(x, 3); };
	function out_cubic(x) { return 1 - power(1 - x, 3); };
	function inout_cubic(x) { return (x < 0.5) ? (4 * power(x,3)) : (1 - power(-2 * x + 2, 3) * 0.5); };

	// quart
	function in_quart(x) { return power(x, 4); };
	function out_quart(x) { return 1 - power(1 - x, 4); };
	function inout_quart(x) { return (x < 0.5)?(8 * power(x,4)):(1 - power(-2 * x + 2, 4) * 0.5); };

	// quint
	function in_quint(x) { return power(x, 5); };
	function out_quint(x) { return 1 - power(1 - x, 5); };
	function inout_quint(x) { return (x < 0.5)?(16 * power(x,5)):(1 - power(-2 * x + 2, 5) * 0.5); };

	// expo
	function in_expo(x) { return (x == 0)? 0 : (power(2, 10 * x - 10)); };
	function out_expo(x) { return (x == 1)? 1 : (1 - power(2, -10 * x)); };
	function inout_expo(x) { return (x == 0)? 0 :((x == 1)? 1 : ((x < 0.5)? (power(2, 20 * x - 10) * 0.5): (1 - power(2, -20 * x + 10) * 0.5))); };

	// circ
	function in_circ(x) { return 1 - sqrt(1 - power(x, 2)); };
	function out_circ(x) { return sqrt(1 - power(x - 1, 2)) };
	function inout_circ(x) { return (x < 0.5)?(0.5 - 0.5 * sqrt(1 - power(2 * x, 2))):(sqrt(1 - power(-2 * x + 2, 2)) * 0.5 + 0.5); };

	// back
	function in_back(x) { return c3 * power(x, 3) - c1 * power(x, 2) };
	function out_back(x) { return 1 + c3 * power(x - 1, 3) + c1 * power(x - 1, 2); };
	function inout_back(x) { return (x < 0.5)? ((power(2 * x, 2) * ((c2 + 1) * 2 * x - c2)) * 0.5): ((power(2 * x - 2, 2) * ((c2 + 1) * (x * 2 - 2) + c2) + 2) * 0.5); };

	// elastic
	function in_elastic(x) { return (x == 0)? 0: ((x == 1)? 1: (-power(2, 10 * x - 10) * sin((x * 10 - 10.75) * c4))); };
	function out_elastic(x) { return (x == 0)? 0: ((x == 1)? 1: (power(2, -10 * x) * sin((x * 10 - 0.75) * c4) + 1)); };
	function inout_elastic(x) { return (x == 0)? 0: ((x == 1)? 1: ((x < 0.5)? (-0.5 * power(2, 20 * x - 10) * sin((20 * x - 11.125) * c5)): (1 + 0.5 * power(2, -20 * x + 10) * sin((20 * x - 11.125) * c5)))) };

	// bounce
	function in_bounce(x) { return 1 - out_bounce(1 - x); }
	function out_bounce(x) {
		if (x < n1) {
			return 7.5625 * power(x, 2);
		} else if (t < n2) {
			x -= d1;
			return 7.5625 * power(x, 2) + 0.75;
		} else if (t < n3) {
			x -= d2;
			return 7.5625 * power(x, 2) + 0.9375;
		} else {
			x -= d3;
			return 7.5625 * power(x, 2) + 0.984375;
		}
	}
	function inout_bounce(x) { return (x < 0.5)? (0.5 - out_bounce(1 - 2 * x) * 0.5): (0.5 + out_bounce(2 * x - 1) * 0.5) }
})()

alarm[0] = 1
