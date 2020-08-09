/// @description 메뉴 속성 선언
global.menu_focused = id
global.menu_title_height = global.client.height * 0.4 // 대략 200
global.menu_caption_width = global.client.width * 0.3
global.menu_caption_height = 52

push = new Countdown()
children = []
child_focused = -1
number = 0

function update() {
	push.update()
	if 0 < number {
		for (var i = 0; i < number; ++i)
			get(i).update()
	}
}

function draw_menu() {
	if 0 < number {
		var oalpha = draw_get_alpha()
		var dx = x, dy = y, temp = []
		for (var i = 0; i < number; ++i) {
			temp = get(i).draw(dx, dy)
			dx += temp[0]
			dy += temp[1]
		}
		draw_set_alpha(oalpha)
	}
}

function add_general(item) {
	children[number++] = item
	return item
}

function add(title, description, predicate) {
	var result = new MenuItem()
	result.text = title
	result.tip = description
	result.predicate = predicate
	return add_general(result)
}

function focus(item) {
	child_focused = item
}

function get(index) {
	return children[index]
}

function get_number() {
	return number
}

function select(item) {
	
}

function init() {
	if 0 < number {
		for (var i = 0; i < number; ++i) {
			with get(i) {
				//push.finish()
				parent = other.id
			}
		}
	}
}

/*
function MainMenuDepth(): MenuGroup() constructor {
	x = 0
	y = 0

	function draw() {
		if 0 < size {
			var dx = x, dy = y
			for (var i = 0; i < size; ++i) {
				entries[i].x = dx
				entries[i].y = dy
				temp = entries[i].draw()
				dy += temp
			}
		}
	}
}

group_main = new MainMenuDepth()
menu_before = group_main
menu_current = group_main
push = new Countdown()
push_predicate = global.ease.linear

function select_group(group) {
	menu_before = menu_current
	menu_current = group
}

function menu_back() {
	select_group(menu_before)
}

title = new MenuItem()
with title {
	focusable = false

	function draw() {
		return [0, global.menu_title_height]
	}
}

entry_campaign = new MenuCaption("Campaign", "Play the story mode.", function() {
	select_group(group_campaign)
})
entry_log = new MenuCaption("Log", "View the played log.", function() {
	select_group(group_log)
})
entry_setting = new MenuCaption("Setting", "Options for game.", function() {
	select_group(group_setting)
})
entry_exit = new MenuCaption("Exit", "End the game.", function() {
	select_group(group_exit)
})
group_main.add(title).add(entry_campaign).add(entry_log).add(entry_setting).add(entry_exit)
group_main.focus_item(entry_campaign)

group_campaign = new MenuGroup(group_main)
with group_campaign {
	add_caption("Start", "Start the game.", -1)
	add_caption("Back", "", other.menu_back)
	focus_item(first)
}

group_log = new MenuGroup(group_main)
with group_log {
	add_caption("LOG", "", -1)
	add_caption("Back", "", other.menu_back)
	focus_item(last)
}

group_setting = new MenuGroup(group_main)
with group_setting {
	add_caption("Start", "Start the single game.", -1)
	add_caption("Back", "", other.menu_back)
	focus_item(first)
}

group_exit = new MenuGroup(group_main)
with group_exit {
	add_caption("Yes", "Start the single game.", -1)
	add_caption("No", "", other.menu_back)
	focus_item(last)
}

function select_item(entry) {
	
}

function select_next_item() {
	
}

function select_before_item() {
	
}
*/
