/// @description 상호작용 개체 데이터베이스 초기화
(new RawEntity("")).register(-1)

var entity_new
entity_new = new RawEntity("player-default")
entity_new.set_name("Player").set_title("The Unbreakable")
.set_flyable(true)
.set_category(mob_category.human)
.set_intelligence(mob_intelligences.good)
.set_ai_move_type(mob_ai_move_types.none)
.set_ai_track_type(mob_ai_track_types.none)
.set_ai_attack_type(mob_ai_attack_types.none)
.set_health_max(10).set_mana_max(0)
.register(oPlayer)

entity_new = new RawEntity("ent-orc-pawn")
entity_new.set_name("Orc").set_health_max(3)
.set_intelligence(mob_intelligences.stupid)
.set_ai_move_type(mob_ai_move_types.guard_track)
.set_ai_track_type(mob_ai_track_types.to_range)
.set_ai_attack_type(mob_ai_attack_types.normal)
.register(oOrc)

entity_new = new RawEntity("ent-elemental-fire-small")
entity_new.set_name("Fire Elemental")
.set_intelligence(mob_intelligences.natural)
.set_ai_move_type(mob_ai_move_types.roaming)
.set_ai_track_type(mob_ai_track_types.to_range)
.set_ai_attack_type(mob_ai_attack_types.normal)
.set_flyable(true)
.set_movable_through_blocks(true)
.set_flying(true)
.set_health_max(2)
.register(oFireElemental)
