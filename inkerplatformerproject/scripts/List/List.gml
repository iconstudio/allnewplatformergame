/*
function make_iterator(list_id, position) {
	var result = new Iterator(list_id)
	result.value = list_id.at(position)
	result.position = position
}

///@function Iterator(list_id)
function Iterator(ds) constructor {
	target = ds
	position = 0

	///@description Two have same values.
	function set(value) {
		return target.set(position, value)
	}

	///@description Two have same values.
	function get() {
		return target.at(position)
	}

	///@description Two have same values.
	function is_value_equals(it) {
		return (get() == it.get())
	}

	///@description Two have same positions and parent.
	function is_equivalent(it) {
		return (position == it.position and target == it.target)
	}

	function forward() {
		position++
		return self
	}

	///@function next([times])
	function next(cnt) {
		return make_iterator(ds, position + select_argument(cnt, 1))
	}

	function backward() {
		position--
		return self
	}

	///@function before([times])
	function before(cnt) {
		if 0 < position
			return make_iterator(ds, position - select_argument(cnt, 1))
		else
			return undefined
	}
}
*/

///@function List([id] or [items...])
function List(items) constructor {
	type = ds_type_list
	raw = ds_list_create()

	function data() {
		return raw
	}

	///@function copy(begin, end, output)
	function copy(Begin, End, Output) {
		for (var it = Begin; it != End; ++it) {
			set(Output++, get(it))
		}
		return Output
	}

	///@function copy_n(begin, number, output)
	function copy_n(Begin, Number, Output) {
		repeat Number {
			set(Output++, get(Begin++))
		}
		return Output
	}

	///@function copy_to(begin, end, destination, destination_begin)
	function copy_to(Begin, End, Dst, DstBgn) {
		for (var it = Begin; it != End; ++it) {
			Dst.set(DstBgn++, get(it))
		}
		return DstBgn
	}

	function duplicate() {
		return new List(self)
	}

	///@function set(iterator, value)
  function set(i, v) {
		ds_list_set(raw, i, v)
	}

	///@function add(value)
  function add(v) { ds_list_add(raw, v) }

	///@function assign(number, value)
  function assign(n, v) {
		repeat n
			add(v)
	}

	///@function push_back(value)
	function push_back(v) { add(v) }

	///@function insert(iterator, value)
  function insert(i, v) {
		ds_list_insert(raw, i, v)
		return i
	}

	///@function at(index)
  function at(i) { return ds_list_find_value(raw, i) }

	///@function get(iterator)
  function get(i) { return raw[| i] }

	///@function mark_list(iterator)
  function mark_list(i) { ds_list_mark_as_list(raw, i) }

	///@function mark_map(iterator)
  function mark_map(i) { ds_list_mark_as_map(raw, i) }

	///@function front()
  function front() { 
		if 0 < size() 
			return ds_list_find_value(raw, 0)
		else
			return undefined
	}

	///@function back()
  function back() {
		var sz = size()
		if 0 < sz
			return ds_list_find_value(raw, sz - 1)
		else
			return undefined
	}

	///@function ibegin()
  function ibegin() { 
		return 0//make_iterator(self, 0)
	}

	///@function iend()
  function iend() {
		return size() - 1//make_iterator(self, size() - 1)
	}

	///@function foreach(begin, end, predicate)
	function foreach(Begin, End, Pred) {
		var pred = method(other, Pred)
		for (var it = Begin; it != End; ++it) {
			pred(get(it))
		}
		return pred
	}

	///@function find(begin, end, value)
	function find(Begin, End, Val) {
		var chk = ds_list_find_index(raw, Val)
		if chk == -1 {
			return End
		} else {
			for (var it = Begin; it != End; ++it) {
				if get(it) == Val
					return it
			}
			return End
		}
	}

	///@function find_if(begin, end, predicate)
	function find_if(Begin, End, Pred) {
		var pred = method(other, Pred)
		for (var it = Begin; it != End; ++it) {
			if pred(get(it))
				return it
		}
		return End
	}

	///@function count(begin, end, value)
	function count(Begin, End, Val) {
		var chk = ds_list_find_index(raw, Val)
		if chk == -1 {
			return 0
		} else {
			var result = 0
			for (var it = Begin; it != End; ++it) {
				if get(it) == Val
					result++
			}
			return result
		}
	}

	///@function count_if(begin, end, predicate)
	function count_if(Begin, End, Pred) {
		var pred = method(other, Pred), result = 0
		for (var it = Begin; it != End; ++it) {
			if pred(get(it))
				result++
		}
		return result
	}

	///@function erase(index)
	function erase(i) { ds_list_delete(raw, i) }

	///@function pop_back()
	function pop_back() { erase(size() - 1) }

	///@function remove(begin, end)
	function remove(i) { 
		
	}

	///@function resize(size, [value_fill])
	function resize(sz, Fv) {
		var osz = size()
		if 0 < sz and sz != osz {
			if sz < osz {
				while size() != sz
					pop_back()
			} else {
				var fv = select_argument(Fv, 0)
				while size() != sz
					push_back(fv)
			}
			return true
		}
		return false
	}

	///@function size()
	function size() { return ds_list_size(raw) }

	///@function empty()
	function empty() { return ds_list_empty(raw) }

	///@function clear()
	function clear() { ds_list_clear(raw) }

	///@function shuffle()
  function shuffle() { ds_list_shuffle(raw) }

	///@function sort(ascending)
  function sort(ascending) { ds_list_sort(raw, ascending) }

	///@function fill(begin, end, value)
	function fill(Begin, End, Val) {
		for (var it = Begin; it != End; ++it) {
			set(it, Val)
		}
	}

	///@function transform(begin, end, output, predicate)
	function transform(Begin, End, Output, Pred) {
		var pred = method(other, Pred)
		for (var it = Begin; it != End; ++it) {
			set(Output++, pred(get(it)))
		}
		return Output
	}

	if 0 < argument_count {
		if argument_count == 1 {
			var item = argument[0]

			if is_undefined(item) {
			} else if ds_exists(item, ds_type_list) {
				ds_list_copy(raw, item)
			} else if is_struct(item) and instanceof(item) == "List" {
				ds_list_copy(raw, item.data())
			} else {
				ds_list_add(raw, item)
			}
		} else {
			for (var i = 0; i < argument_count; ++i) {
				push_back(argument[i])
			}
		}
	}
}