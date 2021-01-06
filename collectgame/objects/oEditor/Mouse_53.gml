/// @description Set to use a tool
var tool_info = tools.at(selected_tool_index)
if is_undefined(tool_info)
	throw "Editor error!: Cannot found the tool at index " + string(selected_tool_index)

var condition = tool_info.kit_condition
if condition()
	mode = tool_info
else
	show_debug_message("Mode changed: " + string(mode))

show_debug_message("Condition: " + string(condition))
