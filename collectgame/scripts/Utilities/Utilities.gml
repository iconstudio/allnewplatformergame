function Utilities(){}

/// @function duet
function duet(condition, value_true, value_false) {
	return condition ? value_true : value_false
}

/// @function string_split(string, seperator)
function string_split(String, Seperator) {
	var count = 0, result = [], temp = String

	var position = string_pos(Seperator, String)
	while true {
		if position == 0
			break
 
		array_set(result, count, string_copy(temp, 1, position - 1))
		array_push(result, string_copy(temp, position + 1, string_length(temp) - position))
 
		position = string_pos(Seperator, result[++count])
		temp = result[count]
	}

	return result
}
