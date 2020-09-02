/// @description 주 메뉴 초기화
event_user(10)
event_user(11)
event_user(12)

mode_change(mode_menu)
//mode_change(mode_menu)

key_pick = NONE
key_duration_pick = seconds(0.4)
key_duration_continue = seconds(0.12)
key_tick = new Countdown();

function key_lockon(dir) {
	key_tick.set(key_duration_pick)
	key_pick = dir
}

function key_goon() {
	key_tick.set(key_duration_continue)
}

function key_lockoff() {
	key_pick = NONE
	key_tick.finish()
}

function key_on_tick() {
	return (key_tick.get() == 0)
}

function key_is_free() {
	return (key_pick = NONE)
}

show_debug_message("\n")
// 14개
test_predicate = function(Val) {return Val < 10}
test1 = new List(4, 2, 8, 13, 11, 9)
test2 = new List(3, 3.5, 26, 7, 10, 15, 5, 4.5)
test_sum = new List()

//test1.sort(test1.ibegin(), test1.iend())
//test2.sort(test2.ibegin(), test2.iend())
//test_sum.merge(test1, test1.ibegin(), test1.iend(), test2, test2.ibegin(), test2.iend(), test_sum.ibegin())
//test.insertion_sort(test.ibegin(), test.iend())
//test.merge_sort(test.ibegin(), test.iend())

//test.partition(test.ibegin(), test.iend(), test_predicate)
//var part_point = test.nth_element(test.ibegin(), test.ibegin() + 3, test.iend())
//var is_parted = test.is_partitioned(test.ibegin(), test.iend(), rpred)
//show_debug_message("Parted: " + string(part_point))


test_sum.foreach(test_sum.ibegin(), test_sum.iend(), show_debug_message)


