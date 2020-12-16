/// @description Initialization
event_inherited()

move_key_peek = RIGHT
move_dir = 0
move_speed = KILOMETER_PER_HOUR(40)
move_accel = KILOMETER_PER_HOUR(3)

jump_speed = KILOMETER_PER_HOUR(110)

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
