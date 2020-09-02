///@function List([id] or [items...])
function List(items) constructor {
	type = ds_type_list
	raw = ds_list_create()
	_Nth_iter = 0
	_Nth_comp = -1

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

	///@function assign_from(list_id, begin, end)
  function assign_from(Other, Begin, End) {
		var result = ibegin()
		while Begin != End {
			if is_array(Other)
				set(result, Other[Begin])
			else
				set(result, Other.get(Begin))
			Begin++
			result++
		}
	}

	///@function push_back(value)
	function push_back(v) { add(v) }

	///@function insert(iterator, value)
  function insert(It, Val) {
		ds_list_insert(raw, It, Val)
		return It
	}

	///@function insert_from(iterator, source, begin, end)
  function insert_from(It, Src, Begin, End) {
		var result = It
		while Begin != End {
			insert(It++, Src.get(Begin))
			Begin++
		}

		return result
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
  function iend() { return size() }

	///@function check_all(begin, end, predicate)
	function check_all(Begin, End, Pred) {
		var pred = method(other, Pred)
		while Begin != End {
			if !pred(get(Begin))
				return false
			Begin++
		}
		return true
	}

	///@function check_any(begin, end, predicate)
	function check_any(Begin, End, Pred) {
		var pred = method(other, Pred)
		while Begin != End {
			if pred(get(Begin))
				return true
			Begin++
		}
		return false
	}

	///@function check_none(begin, end, predicate)
	function check_none(Begin, End, Pred) {
		var pred = method(other, Pred)
		while Begin != End {
			if pred(get(Begin))
				return false
			Begin++
		}
		return true
	}

	///@function foreach(begin, end, predicate)
	function foreach(Begin, End, Pred) {
		var pred = method(other, Pred)
		while Begin != End {
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
			while Begin != End {
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
		while Begin != End {
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
	function erase(It) { 
		var temp = get(It)
		ds_list_delete(raw, It)
		return temp
	}

	///@function pop_back()
	function pop_back() { erase(size() - 1) }

	///@function swap(iterator_1, iterator_2)
	function swap(ItA, ItB) {
		var temp = get(ItA)
		set(ItA, get(ItB))
		set(ItB, temp)
	}

	///@function move(begin, end, output)
	function move(Begin, End, Output) {
		copy(Begin, End, Output)
		remove_all(Begin, End)
	}

	///@function fill(begin, end, value)
	function fill(Begin, End, Val) {
		while Begin != End {
			set(Begin, Val)
			Begin++
		}
	}

	///@function copy(begin, end, output)
	function copy(Begin, End, Output) {
		while Begin != End {
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

	///@function copy_to_n(begin, number, destination, destination_begin)
	function copy_to_n(Begin, Number, Dst, DstBgn) {
		repeat Number {
			Dst.set(DstBgn++, get(Begin++))
		}
		return DstBgn
	}

	///@function copy_if(begin, end, output, predicate)
	function copy_if(Begin, End, Output, Pred) {
		var pred = method(other, Pred), val = 0
		while Begin != End {
			val = get(Begin)
			if pred(val)
				set(Output++, val)
			Begin++
		}
		return Output
	}

	///@function replace(begin, end, old_value, new_value)
	function replace(Begin, End, OldVal, NewVal) {
		while Begin != End {
			if get(Begin) == OldVal
				set(Begin, NewVal)
			Begin++
		}
	}

	///@function replace_if(begin, end, predicate, new_value)
	function replace_if(Begin, End, Pred, NewVal) {
		var pred = method(other, Pred)
		while Begin != End {
			if pred(get(Begin))
				set(Begin, NewVal)
			Begin++
		}
	}

	///@function replace_copy(begin, end, output, old_value, new_value)
	function replace_copy(Begin, End, Output, OldVal, NewVal) {
		while Begin != End {
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
		while Begin != End {
			if get(Begin) == OldVal
				Dst.set(DstBgn++, NewVal)
			else
				Dst.set(DstBgn++, get(Begin))
			Begin++
		}
		return DstBgn
	}

	///@function transform(begin, end, output, predicate)
	function transform(Begin, End, Output, Pred) {
		var pred = method(other, Pred)
		while Begin != End {
			set(Output++, pred(get(Begin)))
			Begin++
		}
		return Output
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
	function resize(Size, Fv) {
		var osz = size()
		if 0 < Size and Size != osz {
			if Size < osz {
				while size() != Size
					pop_back()
			} else {
				var fv = select_argument(Fv, 0)
				while size() != Size
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

	///@function min_element(begin, end, [comparator])
	function min_element(Begin, End, Comparator) {
		var comp = select_argument(Comparator, comparator_less)
		if Begin == End
			return End

		var result = Begin
	  while ++Begin != End {
	    if comp(get(Begin), get(result))
	      result = Begin
		}
	  return result
	}

	///@function max_element(begin, end, [comparator])
	function max_element(Begin, End, Comparator) {
		var comp = select_argument(Comparator, comparator_less)
		if Begin == End
			return End

		var result = Begin
	  while ++Begin != End {
	    if comp(get(result), get(Begin))
	      result = Begin
		}
	  return result
	}

	///@function lower_bound(begin, end, value, [comparator])
	///@description THE ELEMENT SEQUENCE MUST HAVE BEEN SORTED OR AT LEAST GOT PARTITIONED WITH VALUE.
	function lower_bound(Begin, End, Val, Comparator) { // return the first and largest element which less than value.
		var comp = select_argument(Comparator, comparator_less)
		var It, Step, count = iterator_distance(Begin, End)
	  while 0 < count {
	    It = Begin
			Step = count * 0.5
			iterator_advance(It, Step)

	    if comp(get(It), Val) {
	      Begin = ++It
	      count -= Step + 1
	    } else {
				count = Step
			}
	  }
	  return Begin
	}

	///@function upper_bound(begin, end, value, [comparator])
	///@description THE ELEMENT SEQUENCE MUST HAVE BEEN SORTED OR AT LEAST GOT PARTITIONED WITH VALUE.
	function upper_bound(Begin, End, Val, Comparator) { // return a greater element to the value.
		var comp = select_argument(Comparator, comparator_less)
		var It, Step, count = iterator_distance(Begin, End)
	  while 0 < count {
	    It = Begin
			Step = count * 0.5
			iterator_advance(It, Step)

	    if !comp(Val, get(It)) {
	      Begin = ++It
	      count -= Step + 1
	    } else {
				count = Step
			}
	  }
	  return Begin
	}

	///@function sort_all(ascending)
  function sort_all(Ascending) { ds_list_sort(raw, Ascending) }

	///@function sort(begin, end, [comparator])
  function sort(Begin, End, Comparator) {
		if End <= 1
			exit

		var comp = select_argument(Comparator, comparator_less)
		var pivot = Begin
		for (var it = Begin + 1; it < Begin + End; ++it) {
			if comp(get(it), get(pivot)) {
				var temp = get(it)
				set(it, get(pivot + 1))
				set(pivot + 1, get(pivot))
				set(pivot, temp)

				pivot++
			}
		}

		sort(Begin, pivot - Begin, comp)
		if pivot < Begin + End
			sort(pivot + 1, End - (pivot - Begin) - 1, comp)
	}

	///@function selection_sort(begin, end, [comparator])
	function selection_sort(Begin, End, Comparator) {
		var comp = select_argument(Comparator, comparator_less)
		while Begin != End {
	    var selection = min_element(Begin, End, comp)
	    swap(selection, Begin)
			Begin++
	  }
	}

	///@function insertion_sort(begin, end, [comparator])
	function insertion_sort(Begin, End, Comparator) {
		var comp = select_argument(Comparator, comparator_less)

		Begin++
		while Begin != End {
			var Value = get(Begin)
			for(var it = Begin - 1; 0 <= it and comp(Value, get(it)); --it) {
	      set(it + 1, get(it))
	    }
			set(it + 1, Value)

			Begin++
		}
	}

	///@function merge_sort(begin, end, [comparator])
	function merge_sort(Begin, End, Comparator) {
		var comp = select_argument(Comparator, comparator_less)
		var Dist = iterator_distance(Begin, End)
    if Dist <= 1
			exit

		var Middle = iterator_advance(Begin, Dist * 0.5)
    merge_sort(Begin, Middle, comp)
    merge_sort(Middle, End, comp)
    inplace_merge(Begin, Middle, End, comp)
	}

	///@function is_sorted(begin, end, [comparator])
	function is_sorted(Begin, End, Comparator) {
		var comp = select_argument(Comparator, comparator_less)
		if Begin == End
			return true

	  var Next = Begin
	  while ++Next != End {
	    if comp(Next, Begin)
	      return false
	    Begin++
	  }
	  return true
	}

	///@function partition(begin, end, predicate)
	function partition(Begin, End, Pred) {
		var pred = method(other, Pred)
		while Begin != End {
	    while pred(get(Begin)) {
	      ++Begin
	      if Begin == End
					return Begin
	    }

	    do {
	      --End
	      if Begin == End
					return Begin
	    } until pred(get(End))

	    swap(Begin, End)
	    Begin++
	  }
	  return Begin
	}

	///@function is_partitioned(begin, end, predicate)
	function is_partitioned(Begin, End, Pred) {		
		while Begin != End and Pred(get(Begin)) {
	    ++Begin
	  }

	  while Begin != End {
	    if Pred(get(Begin))
				return false
	    Begin++
	  }
	  return true
	}

	///@function nth_element(begin, nth, end, [comparator])
	function nth_element(Begin, Nth, End, Comparator) {
		_Nth_val = get(Nth)
		_Nth_comp = select_argument(Comparator, comparator_less)
		var pred = function(Val) {
			return _Nth_comp(_Nth_val, Val)
		}

		while Begin != End { // partition
	    while pred(get(Begin)) {
	      ++Begin
	      if Begin == End
					return Begin
	    }

	    do {
	      --End
	      if Begin == End
					return Begin
	    } until pred(get(End))

	    swap(Begin, End)
	    Begin++
	  }
	  return Begin
	}

	///@function merge(source_1, 1_begin, 1_end, source_2, 2_begin, 2_end, output, [comparator])
	function merge(Source_1, Src1_Begin, Src1_End, Source_2, Src2_Begin, Src2_End, Output, Comparator) {
		var comp = select_argument(Comparator, comparator_less)
		while true {
	    if Src1_Begin == Src1_End
				return Source_2.copy_to(Src2_Begin, Src2_End, self, Output)

			if Src2_Begin == Src2_End
				return Source_1.copy_to(Src1_Begin, Src1_End, self, Output)

	    set(Output, comp(Source_2.get(Src2_Begin), Source_1.get(Src1_Begin)) ? Source_2.get(Src2_Begin++) : Source_1.get(Src1_Begin++))
			Output++
	  }
		return Output
	}

	///@function inplace_merge(begin, middle, end, [comparator])
	function inplace_merge(Begin, Middle, End, Comparator) {
		var comp = select_argument(Comparator, comparator_less)
		var summary = new List()
		summary.resize(size())
		summary.merge(self, Begin, Middle, self, Middle, End, summary.ibegin(), comp)
		assign_from(summary, ibegin(), iend())
		delete summary
	}

	if 0 < argument_count and !is_undefined(argument[0]) {
		if argument_count == 1 {
			var item = argument[0]

			if ds_exists(item, ds_type_list) {
				ds_list_copy(raw, item)
			} else if is_struct(item) and instanceof(item) == "List" {
				ds_list_copy(raw, item.data())
			} else if is_array(item) {
				assign(item, 0, array_length(item))
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

///@function iterator_distance(iterator_1, iterator_2)
function iterator_distance(ItA, ItB) {
	return abs(ItB - ItA)
}

///@function iterator_advance(iterator, distance)
function iterator_advance(It, Dist) {
	return It + floor(Dist)
}

function comparator_less(a, b) {
	return bool(a < b)
}

function comparator_greater(a, b) {
	return bool(a > b)
}