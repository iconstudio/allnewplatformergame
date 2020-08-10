/// @description 메뉴 속성 선언
global.menu_opened = id
global.menu_depth = 0
global.menu_title_height = global.client.height * 0.4 // 대략 200
global.menu_caption_y = y + global.menu_title_height
global.menu_caption_width = global.client.width * 0.3
global.menu_caption_height = 52

menu_init_basic()
delete push
push = new Countdown();
opened = true

function draw() {
	if 0 < number {
		var dx = x, dy = y, temp = []
		for (var i = 0; i < number; ++i) {
			temp = get(i).draw(dx, dy)
			dx += temp[0]
			dy += temp[1]
		}
	}
}

function init() {
	if 0 < number {
		for (var i = 0; i < number; ++i) {
			with get(i) {
				push.finish()
				parent = other.id
			}
		}
	}
}
