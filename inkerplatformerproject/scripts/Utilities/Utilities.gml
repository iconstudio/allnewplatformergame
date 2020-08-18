function integral(condition, value_true, value_false) {
	return condition ? value_true : value_false
}

function select_argument(arg, def) {
	return integral(is_undefined(arg), def, arg)
}

/*
/// scptAimTo(param_1relative, param_, param_3, param_4)
/// @description Aim to certain point with minimum speed
/// @x relative x coordinate
/// @y relative y coordinate
/// @g gravity acceleration
/// @w gravity angle
//Argument 0: relative x coordinate
//Argument 1: relative y coordinate
//Argument 2: gravity acceleration
//Argument 3: gravity angle
argument1 *= -1;
var xx = argument0;
var yy = argument1;
if(argument3 != -90){
    xx = dcos(-argument3 - 90) * argument0 - dsin(-argument3 - 90) * argument1;
    yy = dsin(-argument3 - 90) * argument0 + dcos(-argument3 - 90) * argument1;
}
var dist = point_distance(0,0,xx,yy);
var spd = sqrt(argument2 / (2*dist) * (xx * xx + (yy + dist) * (yy + dist)));
var dir = darctan2((yy + dist) , xx) + argument3 + 90;
var A = global.commander;
A.data[0] = spd * dcos(dir);    // X speed
A.data[1] = - spd * dsin(dir);    // Y speed
//A.data[2] = abs(spd * dsin(dir) * 2 / argument2);
A.data[2] = xx / (spd * dcos(dir - argument3 - 90));
//A.data[2] = spd * (dsin(dir) + sqrt(sqr(A.data[1])+4*argument2*yy))/(-argument2);
A.data[3] = spd;    // Speed
A.data[4] = dir;    // Direction

// A
var gy;
yMove += gy;
y += yMove + gy/ 2;
y += yMove;
x += xMove;


*/

///@function Timer(duration, [predicate], [destructor])
function Timer(duration, proc, dest) constructor {
	parent = other
	running = false
	time = 0
	period = duration
	predicate = select_argument(proc, -1)
	destructor = select_argument(dest, -1)

	set =	function(count) {
		running = false
		time = count
		return self
	}

	get =	function() {
		if period < 0
			return 1
		return time / period
	}

	update = function() {
		if predicate != -1 and instance_exists(parent) {
			var proc = predicate
			with parent
				proc()
		}

		if period <= 0 {
			finish()
		} else if time < period {
			running = true
			time++
			if period <= time
				finish()
		} else {
			time = period
		}

		return get()
	}

	reset =	function() {
		set(0)
		return self
	}

	finish = function() {
		if running or period <= 0 {
			if destructor != -1 and instance_exists(parent) {
				var proc = destructor
				with parent
					proc()
			}
		}

		set(period)
		return self
	}
}

///@function Countdown([predicate], [destructor])
function Countdown(proc, dest) constructor {
	parent = other
	time = 0
	time_max = 1
	closing = false
	predicate = select_argument(proc, -1)
	destructor = select_argument(dest, -1)

	set =	function(count) {
		time = count
		time_max = count
		return self
	}

	get_time = function() {
		return time
	}

	get_max =	function() {
		return time_max
	}

	get =	function() {
		return time / time_max
	}

	update = function() {
		if 0 < time {
			if predicate != -1 and instance_exists(parent) {
				var proc = predicate
				with parent
					proc()
			}

			time--
			if time <= 0 {
				time = 0
				closing = true
			}
		} else if closing {
			finish()
		}

		return get()
	}

	reset =	function() {
		set(time_max)
		return self
	}

	finish = function() {
		if destructor != -1 and instance_exists(parent) {
			var proc = destructor
			with parent
				proc()
		}

		time = -1
		closing = false
		return self
	}

	function toString() {
		return "Countdown"
	}
}

function seconds(time) {
	return max(1, time * room_speed)
}

function color_get_random() {
	return make_color_rgb(irandom(255), irandom(255), irandom(255))
}

function struct_exists(struct) {
	return is_struct(struct) //!is_undefined(instanceof(struct))
}

///@function select_more(index, ...)
function select_more(index) {
	if index + 1 < argument_count
		return argument[index + 1]
	else 
		throw "인자의 갯수가 부족합니다."
}

function io_check_ok() {
	return keyboard_check_pressed(vk_enter)
	or keyboard_check_pressed(vk_space)
}

///@function dice(side, [number])
function dice(side, number) {
	var count = select_argument(number, 1)
	return irandom_range(count, side * count)
}

///@function lx(angle, [length])
function lx(angle, length) {
	while angle < 0
		angle += 360
	if 360 <= angle
		angle = angle mod 360
	return global.__lengthdir_cashed[angle][0] * select_argument(length, 1)
}

///@function ly(angle, [length])
function ly(angle, length) {
	while angle < 0
		angle += 360
	if 360 <= angle
		angle = angle mod 360
	return global.__lengthdir_cashed[angle][1] * select_argument(length, 1)
}

///@function instance_create(obj, [x], [y], [layer])
function instance_create(obj, nx, ny, nlayer) {
	return instance_create_layer(select_argument(nx, 0), select_argument(ny, 0), select_argument(nlayer, layer), obj)
}

function make_percent_caption(title, value, value_max) {
	return title + ": " + string(value) + " / " + string(value_max)
}

function bresenham() {
	// arguments : 0x1, 1y1, 2x2, 3y2, 4execute<func(x, y, [arg])>, [5argument]
	var dx = abs(argument2 - argument0);
	var dy = abs(argument3 - argument1);
	var sx = select(argument0 < argument2, -1, 1);
	var sy = select(argument1 < argument3, -1, 1);
	var err = dx - dy;
	var e2;

	while (1) {
	 script_execute(argument4, argument0, argument1, argument5);

	 if (argument0 = argument2 && argument1 = argument3)
	  break;

	 e2 = err * 2;
 
	 if (e2 > -dy) {
	  err -= dy;
	  argument0 += sx;
	 }
 
	 if (e2 < dx) {
	  err += dx;
	  argument1 += sy;
	 }
	}
}

function string_cap(str, ratio) {
	var length = string_length(str)
	var length_output = ceil(length * ratio)
	return string_copy(str, 1, length_output)
}

function string_mutation(str, ratio) {
	var length = string_length(str)
	var dlen = ceil(length * 1.5 * ratio)
	var olen = ceil(dlen - (length / 2))

	if dlen > length
		dlen = length
	if olen > length
		olen = length
	if olen < 0
		olen = 0

	var result = string_copy(str, 1, olen)
	for (var i = olen; i < dlen; i += 1)
		result += chr(irandom_range(32, 127))

	return result
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
