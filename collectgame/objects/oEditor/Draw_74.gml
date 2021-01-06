/// @description Drawing the using tools
if !is_undefined(mode) {
	var predicate = mode.drawer
	if !is_undefined(predicate)
		predicate()
}
