

///@function DataStructure([items...])
function DataStructure(items) constructor {
	type = undefined
	data_raw = undefined
	param_values_count = argument_count
	if 0 < param_values_count {
		param_values = array_create(param_values_count, 0)
		for (var i = 0; i < param_values_count; ++i)
			param_values[i] = argument[i]
	} else {
		param_values = undefined
	}

	virtual_add = -1
	virtual_get_size = -1
	virtual_destroy = -1

	///@function get_size()
	function get_size() {
		return virtual_get_size(data_raw)
	}

	///@function destroy()
	function destroy() {
		try {
			if check_reliability() {
				virtual_destroy(data_raw)
			}
		} finally {
			data_raw = undefined
		}
	}

	///@function check_reliability()
	function check_reliability() {
		if is_undefined(data_raw) or !ds_exists(data_raw, type) {
			throw "DS does not exist: \n" + string(debug_get_callstack())
			return false
		} else {
			return true
		}
	}

	function init() {
		if 0 < param_values_count and virtual_add != -1 {
			for (var i = 0; i < param_values_count; ++i) {
				virtual_add(param_values[i])
			}
		}
	}
}

///@function Stack([items...])
function Stack(items): DataStructure(items) constructor {
	type = ds_type_stack
	data_raw = ds_stack_create()

	top = function() { return ds_stack_top(data_raw) }
  pop = function() { return ds_stack_pop(data_raw) }
  push = function(val) { ds_stack_push(data_raw, val) }
	virtual_add = push
	virtual_get_size = ds_stack_size
	virtual_destroy = ds_stack_destroy
	init()
}

///@function Queue([items...])
function Queue(items): DataStructure(items) constructor {
  type = ds_type_queue
  data_raw = ds_queue_create()

  top = function() { return ds_queue_head(data_raw) }
  pop = function() { return ds_queue_dequeue(data_raw) }
  push = function(val) { ds_queue_enqueue(data_raw,val) }
	virtual_add = push
	virtual_get_size = ds_queue_size
	virtual_destroy = ds_queue_destroy
	init()
}

///@function PriorityQueue()
function PriorityQueue(): DataStructure() constructor {
  type = ds_type_priority
  data_raw = ds_priority_create()

  clear = function() { ds_priority_clear(data_raw) }
  add = function(val,priority) { ds_priority_add(data_raw,val,priority) } 
  get_min = function() { return ds_priority_find_min(data_raw) }
  get_max = function() { return ds_priority_find_max(data_raw) }
  delete_min = function() { return ds_priority_delete_min(data_raw) }
  delete_max = function() { return ds_priority_delete_max(data_raw) }
	virtual_add = -1
	virtual_get_size = ds_priority_size
	virtual_destroy = ds_priority_destroy
}

///@function Grid(width, height)
function Grid(_width, _height): DataStructure() constructor {
	type = ds_type_grid
	data_raw = ds_grid_create(_width, _height)
	__width = _width
	__height = _height

	function set_width(value) {
		resize(value, __height)
		return self
	}

	function set_height(value) {
		resize(__width, value)
		return self
	}

	function get_width() {
		return __width
	}

	function get_height() {
		return __height
	}

	///@function resize(width, height)
	function resize(_w,_h) {
		__width = _w
		__height = _h
		ds_grid_resize(data_raw,_w,_h)
	}

	///@function clear([value])
	function clear(value) {
		var value_clear = select_argument(value, 0)
		ds_grid_clear(data_raw, value_clear)
	}

  shuffle = function() { ds_grid_shuffle(data_raw) }
  sort = function(column,ascending) { ds_grid_sort(data_raw,column,ascending) }
  set = function(x,y,v) { data_raw[# x,y] = v; }
  get = function(x,y) { return data_raw[# x,y]; }
  get_max = function(x1,y1,x2,y2) { return ds_grid_get_max(data_raw,x1,y1,x2,y2) }
  get_min = function(x1,y1,x2,y2) { return ds_grid_get_min(data_raw,x1,y1,x2,y2) }
  get_mean = function(x1,y1,x2,y2) { return ds_grid_get_mean(data_raw,x1,y1,x2,y2) }
  get_sum = function(x1,y1,x2,y2) { return ds_grid_get_sum(data_raw,x1,y1,x2,y2) }
  get_max_disk = function(x,y,r) { return ds_grid_get_disk_max(data_raw,x,y,r) }
  get_min_disk = function(x,y,r) { return ds_grid_get_disk_min(data_raw,x,y,r) }
  get_mean_disk = function(x,y,r) { return ds_grid_get_disk_mean(data_raw,x,y,r) }
  get_sum_disk = function(x,y,r) { return ds_grid_get_disk_sum(data_raw,x,y,r) }

	///@function filter(predicate)
	filter = function (cb) {
		var _nds = new Grid(__width,__height)
		for (var _x=0;_x<__width;_x++) {
			for (var _y=0;_y<__width;_y++) {
				if (cb(data_raw[# _x,_y],_x,_y,self)) {
					_nds.set(_x,_y,data_raw[# _x,_y])
				} else {
					_nds.set(_x,_y,undefined)
				}
			}
		}
		return _nds;
	}

	///@function map(predicate)
	map = function(cb){
		var _nds = new Grid(__width,__height)
		for (var _x=0;_x<__width;_x++) {
			for (var _y=0;_y<__width;_y++) {
				_nds.set(_x,_y,cb(data_raw[# x,y],_x,_y,self))
			}
		}
		return _nds;
	}

	///@function foreach(predicate)
	foreach = function(cb) {
		var _br = false;
		for (var _x=0;_x<__width;_x++) {
			for (var _y=0;_y<__width;_y++) {
				if (cb(data_raw[# _x,_y],_x,_y,self) == false) {
					_br = true;
					break;
				}
			}
			if (_br) {
				break;	
			}
		}
	}

	virtual_add = -1
	virtual_get_size = -1
	virtual_destroy = ds_grid_destroy
}

function Map(): DataStructure() constructor {
	type = ds_type_map;
	data_raw = ds_map_create()
	destroy = function(cleanup) {
		if (cleanup = undefined) {
			cleanup = false;	
		}
		if is_undefined(data_raw) {
			show_error("Map does not exist: " + debug_get_callstack(), false)
		} else {
			if cleanup {
				var _iter = new Iterator(self)
				while (_iter.next() != undefined) {
					var _item = _iter.value()
					if (is_struct(_item)) {
						switch (instanceof(_item)) {
							case "List":
							case "Map":
							case "Grid":
							case "Queue":
							case "Priority":
							case "Stack":
								_item.destroy()
							break;
						}
					}
				}
			}
			ds_map_destroy(data_raw)
		}
		data_raw = undefined
	}
	get = function(key) { return data_raw[? key]; }
	set = function(key,val) { data_raw[? key] = val; }
	clear = function() { ds_map_clear(data_raw) }
	remove = function(key) { ds_map_delete(data_raw,key) }

	foreach = function() {
		var _k = ds_map_find_first(data_raw)
		while (_k != undefined) {
			if (cb(data_raw[? _k], _k, data_raw) == true) {
				break;
			}
			k = ds_map_find_next(data_raw,_k)
		}
	}
	map = function(cb,remove) {
		if (remove == undefined) {
			remove = false;	
		}
		var _k = ds_map_find_first(data_raw)
		var _nds = Map()
		while (_k != undefined) {
			_nds.set(_k,cb(data_raw[? _k], _k, self))
			k = ds_map_find_next(data_raw,_k)
		}
		if remove {
			self.destroy()	
		}
		return _nds;
	}
	filter = function(cb) {
		var _k = ds_map_find_first(data_raw)
		var _nds = new Map()
		while (_k != undefined) {
			if (cb(data_raw[? _k],_k,self)) {
				_nds[? _k] = data_raw[? _k];
			}
		}
		return _nds;
	}

	virtual_add = -1
	virtual_get_size = ds_map_size
	virtual_destroy = ds_map_destroy
}


function Iterator(bds) constructor {
	data = bds;
	type = data.type;
	key = undefined
	next = undefined
	value = undefined
	last = function() {
		if (type == ds_type_list) {
			return data.get_size()-1;
		} else if (type == ds_type_map) {
			return ds_map_find_last(data.data_raw)
		}
	}
	_next_list = function() {
		if (key==undefined) {
			key = 0;
			return key;
		}
		if (key+1 < ds_list_size(data_raw.data_raw)) {
			return ++key;
		} else {
			return undefined	
		}
	}
	_next_map = function() {
        if (key == undefined) {
            key = ds_map_find_first(data_raw.data_raw)
        } else {
            key = ds_map_find_next(data_raw.data_raw,key)
        }
        return key;
	}
    _value_list = function() {
        return data_raw.data_raw[| key];
    }
    _value_map = function() {
        return data_raw.data_raw[? key];
    }
	if (type == ds_type_list) {
		key = undefined
		next = _next_list;
		value = _value_list;
	} else if (type == ds_type_map) {
		key = undefined
		next = _next_map;
		value = _value_map;
	}
}


/*
function Surface(_width,_height) constructor {
	width = width;
	height = height;
	buffer_size = width*height*4;
	surface = surface_create(width,height)
	buffer = new Buffer(buffer_size,buffer_fixed,1)	
}
*/