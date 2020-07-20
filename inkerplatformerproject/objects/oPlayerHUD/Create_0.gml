/// @description UI 초기화
if !instance_exists(oPlayer) {
	throw "플레이어 객체가 없습니다."
}

parent = oPlayer.id
property = parent.property
y = global.client.game_height
border = global.client.border
y_border = y + border
y_draw_begin = y_border + border

panel_bezel_pos_begin = [border, y_border]
panel_bezel_pos_end = [global.client.panel_width - border, y + global.client.panel_height]

// ** 스킬 아이콘 초기화 **
sk_icon_org_width = 64
sk_icon_org_height = 64
sk_icon_padding = 40
sk_icon_width = sk_icon_org_width + sk_icon_padding

sk_icons_width = sk_icon_width * 4 - sk_icon_padding
sk_x_begin = (global.client.panel_width - sk_icons_width) * 0.5

skill_icon = function(sp, si, nx, ny) constructor {
	sprite = sp
	skill_index = si
	x = nx
	y = ny
	width = other.sk_icon_org_width
	height = other.sk_icon_org_height

	function draw() {
		//draw_sprite(sprite, 0, x, y)
		draw_sprite(sSkillIcon, 0, x, y)

		draw_set_halign(1)
		draw_set_valign(0)
		draw_text(x + width * 0.5, y + height, skill_index.get_name())
	}
}
skill_icons = array_create(4, -1)

var nx = sk_x_begin
for (var i = 0; i < 4; ++i) {
	skill_icons[i] = new skill_icon(sSkillIcon, parent.skills[i], nx, y_draw_begin)
	nx += sk_icon_width
}
