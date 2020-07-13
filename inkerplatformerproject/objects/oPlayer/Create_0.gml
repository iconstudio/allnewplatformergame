/// @description HUD 생성
event_inherited()

hud = noone
if !instance_exists(oPlayerHUD)
	hud = instance_create(oPlayerHUD, 0, 0, "Interface")
else
	hud = instance_find(oPlayerHUD, 0)
hud.parent = id
