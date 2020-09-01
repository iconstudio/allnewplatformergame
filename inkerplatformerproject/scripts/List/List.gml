///@function List([id] or [items...])
function List(items) constructor {
	type = ds_type_list
	raw = ds_list_create()

	function data() {
		return raw
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
  function ibegin() { return 0 }

	///@function iend()
  function iend() { return size() - 1 }

	///@function check_all(begin, end, predicate)
	function check_all(Begin, End, Pred) {
		var pred = method(other, Pred)
		while (Begin != End) {
			if !pred(get(Begin))
				return false
			Begin++
		}
		return true
	}

	///@function check_any(begin, end, predicate)
	function check_any(Begin, End, Pred) {
		var pred = method(other, Pred)
		while (Begin != End) {
			if pred(get(Begin))
				return true
			Begin++
		}
		return false
	}

	///@function check_none(begin, end, predicate)
	function check_none(Begin, End, Pred) {
		var pred = method(other, Pred)
		while (Begin != End) {
			if pred(get(Begin))
				return false
			Begin++
		}
		return true
	}

	///@function foreach(begin, end, predicate)
	function foreach(Begin, End, Pred) {
		var pred = method(other, Pred)
		while (Begin != End) {
			pred(get(Begin))
			Begin++
		}
		return pred
	}

	///@function find(begin, end, value)
	function find(Begin, End, Val) {
		var chk = ds_list_find_index(raw, Val)
		if chk == -1 {
			return End
		} else {
			while (Begin != End) {
				if get(Begin) == Val
					return Begin
				Begin++
			}
			return End
		}
	}

	///@function find_if(begin, end, predicate)
	function find_if(Begin, End, Pred) {
		var pred = method(other, Pred)
		while (Begin != End) {
			if pred(get(Begin))
				return Begin
			Begin++
		}
		return End
	}

	///@function count(begin, end, value)
	function count(Begin, End, Val) {
		var chk = ds_list_find_index(raw, Val)
		if chk == -1 {
			return 0
		} else {
			for (var it = Begin, result = 0; it != End; ++it) {
				if get(it) == Val
					result++
			}
			return result
		}
	}

	///@function count_if(begin, end, predicate)
	function count_if(Begin, End, Pred) {
		var pred = method(other, Pred)
		for (var it = Begin, result = 0; it != End; ++it) {
			if pred(get(it))
				result++
		}
		return result
	}

	///@function erase(iterator)
	function erase(i) { 
		var temp = get(i)
		ds_list_delete(raw, i)
		return temp
	}

	///@function pop_back()
	function pop_back() { erase(size() - 1) }

	///@function swap(a, b)
	function swap(ItA, ItB) {
		var temp = get(ItA)
		set(ItA, get(ItB))
		set(ItB, temp)
	}

	///@function remove(begin, end, value)
	function remove(Begin, End, Val) {
		for (var it = Begin, result = Begin; it != End; ++it) {
			if get(it) == Val {
				erase(result)
			} else {
				result++
			}
		}
		return result
	}

	///@function remove_if(begin, end, predicate)
	function remove_if(Begin, End, Pred) {
		var pred = method(other, Pred)
		for (var it = Begin, result = Begin; it != End; ++it) {
			if pred(get(result)) {
				erase(result)
			} else {
				result++
			}
		}
		return result
	}

	///@function remove_all(begin, end)
	function remove_all(Begin, End) {
		for (var it = Begin; it != End; ++it) {
			erase(Begin)
		}
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

	///@function nth_element(begin, nth, end, [comparator])
	function nth_element(Begin, Nth, End, Comparator) {
		var comp = select_argument(Comparator, comparator_default)
		for (var it = Begin; it != End; ++it) {
			
		}
	}

	///@function move(begin, end, output)
	function move(Begin, End, Output) {
		copy(Begin, End, Output)
		remove_all(Begin, End)
	}

	///@function replace(begin, end, old_value, new_value)
	function replace(Begin, End, OldVal, NewVal) {
		while (Begin != End) {
			if get(Begin) == OldVal
				set(Begin, NewVal)
			Begin++
		}
	}

	///@function replace_if(begin, end, predicate, new_value)
	function replace_if(Begin, End, Pred, NewVal) {
		var pred = method(other, Pred)
		while (Begin != End) {
			if pred(get(Begin))
				set(Begin, NewVal)
			Begin++
		}
	}

	///@function replace_copy(begin, end, output, old_value, new_value)
	function replace_copy(Begin, End, Output, OldVal, NewVal) {
		while (Begin != End) {
			if get(Begin) == OldVal
				set(Output, NewVal)
			else
				set(Output, get(Begin))
			Begin++
			Output++
		}
		return Output
	}

	///@function replace_copy_to(begin, end, destination, destination_begin, old_value, new_value)
	function replace_copy_to(Begin, End, Dst, DstBgn, OldVal, NewVal) {
		while (Begin != End) {
			if get(Begin) == OldVal
				Dst.set(DstBgn++, NewVal)
			else
				Dst.set(DstBgn++, get(Begin))
			Begin++
		}
		return DstBgn
	}

	///@function copy(begin, end, output)
	function copy(Begin, End, Output) {
		while (Begin != End) {
			set(Output++, get(Begin))
			Begin++
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

	///@function copy_if(begin, end, output, predicate)
	function copy_if(Begin, End, Output, Pred) {
		var pred = method(other, Pred), val = 0
		while (Begin != End) {
			val = get(Begin)
			if pred(val)
				set(Output++, val)
			Begin++
		}
		return Output
	}

	///@function fill(begin, end, value)
	function fill(Begin, End, Val) {
		while (Begin != End) {
			set(Begin, Val)
			Begin++
		}
	}

	///@function transform(begin, end, output, predicate)
	function transform(Begin, End, Output, Pred) {
		var pred = method(other, Pred)
		while (Begin != End) {
			set(Output++, pred(get(Begin)))
			Begin++
		}
		return Output
	}

	if 0 < argument_count {
		if argument_count == 1 and !is_undefined(argument[0]) {
			var item = argument[0]

			if ds_exists(item, ds_type_list) {
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

function comparator_default(a, b) {
	return bool(a < b)
}