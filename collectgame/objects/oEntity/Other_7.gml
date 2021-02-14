/// @description Change animation
if sprite_index != -1 {
	var Length = sprite_queue.get_size()
	if 0 < Length {
		var Sprite = sprite_queue.pop_front()
		if !sprite_exists(Sprite)
			throw "Cannot found the sprite of object " + object_get_name(object_index)
		sprite_index = Sprite
	}
}
