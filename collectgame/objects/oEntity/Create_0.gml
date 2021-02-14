/// @description Initialization
event_inherited()

entity_status = ENTITY_STATES.IDLE
entity_status_duratution = -1

sprite_queue = new List()
img_xscale = 1
img_angle = 0

/// @function throttle_sprite(sprite)
function throttle_sprite(Sprite) {
	sprite_queue.push_back(Sprite)
}

/// @function pickup_sprite(sprite)
function pickup_sprite(Sprite) {
	sprite_queue.clear()
	sprite_index = Sprite
}
