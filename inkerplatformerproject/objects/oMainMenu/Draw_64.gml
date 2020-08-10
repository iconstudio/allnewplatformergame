/// @description 메뉴 그리기
draw_set_color($ffffff)

var ratio = push.get() / push.get_max()
var alpha = ratio
draw_set_alpha(alpha)

draw_set_alpha(1 - alpha)
draw(x, y)
draw_set_font(fontMainMenu)
