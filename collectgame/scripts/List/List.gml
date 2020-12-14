/// @function 
function _Container_Null() {}
#macro NULL _Container_Null

/// @function List()
function List() {
	/// @function data()
	static data = function() { return _Data }

	/// @function get_size()
	static get_size = function() { return _Size }

	/// @function get_capacity()
	static get_capacity = function() { return _Capacity }

	/// @function is_empty()
	static is_empty = function() { return (_Size == 0) }

	/// @function clear()
	static clear = function() { _Size = 0 }

	/// @function resize(size)
	static resize = function(Size) {
		if Size != _Size {
			if Size < _Size
				array_resize(_Data, Size)
			_Capacity_ensure(Size)
			_Size = Size
		}
	}

	/// @function reserve(size)
	static reserve = function(Size) { if _Capacity < Size _Capacity_ensure(Size) }

	/// @function shrink_to_fit()
	static shrink_to_fit = function() { _Capacity_set(_Size) }

	/// @function at(index)
	static at = function(Index) { return (0 < _Size and Index < _Size ? _Data[Index] : pointer_null) }

	/// @function front()
	static front = function() { return (0 < _Size ? _Data[0] : pointer_null) }

	/// @function back()
	static back = function() { return (0 < _Size ? _Data[_Size - 1] : pointer_null) }

	/// @function set_at(index, value)
	static set_at = function(Index, Value) {
		if _Size <= Index {
			resize(Index)
		}
		_Data[Index] = Value
		return self
	}

	/// @function push_back(value)
	static push_back = function(Value) {
		if 1 < argument_count {
			_Element_ensure(argument_count)
			for (var i = 0; i < argument_count; ++i)
				_Element_add(argument[i])
		} else {
			_Element_add(Value)
		}
		return self
	}

	/// @function pop_back()
	static pop_back = function() {
		if 0 < _Size {
			var Result = _Data[_Size - 1]
			_Size--
			return Result
		} else {
			return pointer_null
		}
	}

	/// @function 
	static _Capacity_set = function(Size) { array_resize(_Data, Size); _Capacity = Size }

	/// @function 
	static _Capacity_ensure = function(Size) { _Capacity_set(ceil(Size / 4) * 4 + 8) }

	/// @function 
	static _Element_ensure = function(Count) {
		var NewCap = _Size + Count
		if _Capacity <= NewCap
			_Capacity_ensure(NewCap)
	}

	/// @function 
	static _Element_add = function(Value) {
		if _Capacity <= _Size
			_Capacity_ensure(_Size)
		_Data[_Size++] = Value
	}

	/// @function 
	static _Initialize = function(Size) {
		if 1 < argument_count {
			
		}
		array_push(_Data, Value)
	}

	_Data = []
	_Capacity = 8
	_Size = 0
}
