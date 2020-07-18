/// @description UI 초기화
if !instance_exists(oPlayer) {
	throw "플레이어 객체가 없습니다."
}

parent = oPlayer.id
property = parent.property
y = global.client.game_height
y_border = y + global.client.border
y_draw_begin = y_border + global.client.border

panel_bezel_pos_begin = [global.client.border, y_border]
panel_bezel_pos_end = [global.client.panel_width - global.client.border, y + global.client.panel_height]

// ** 스킬 아이콘 초기화 **
skill_icon = function(sp, si, nx, ny) constructor {
	sprite = sp
	skill_index = si
	x = nx
	y = ny
}
skill_icons = array_create(4, -1)

var sk_icon_org_width = 32
var sk_icon_border = 8
var sk_icon_width = sk_icon_org_width + sk_icon_border

var sk_icons_width = sk_icon_width * 4 - sk_icon_border
var sk_x_begin = (global.client.panel_width - sk_icons_width) * 0.5

var nx = sk_x_begin
for (var i = 0; i < 4; ++i) {
	skill_icons[i] = new skill_icon(sSkillIcon, -1, nx, y + 10)
	nx += sk_icon_width
}
