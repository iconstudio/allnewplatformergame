/// @description 게임 초기화
with object_index	{
	if id != other.id
		instance_destroy()
}

hud = noone
if !instance_exists(oPlayerHUD)
	hud = instance_create(oPlayerHUD, 0, 0, "UI")
else
	hud = instance_find(oPlayerHUD, 0)
