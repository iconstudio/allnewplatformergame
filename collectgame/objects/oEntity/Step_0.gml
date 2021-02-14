/// @description Things Update
event_inherited()

if entity_status < ENTITY_STATES.STUNNED
	event_user(0)

if 0 < entity_status_duratution {
	if --entity_status_duratution <= 0 {
		entity_status = ENTITY_STATES.IDLE
		entity_status_duratution = 0
	}
}
