/// @description 상호작용 개체 데이터베이스 초기화
var entity_default = new Entity("")
entity_register("", entity_default)

var entity_new = new Entity("Orc")
entity_new.set_health_max(3)
entity_register("ent-orc-pawn", entity_new)

entity_new = new Entity("Player", "The Unbreakable")
entity_new.set_health_max(10)
entity_new.set_mana_max(0)

entity_register("player-default", entity_new)
