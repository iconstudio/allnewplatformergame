/// @description 상호작용 개체 데이터베이스 초기화
var entity_default = new entity("")
entity_register("", entity_default)
var entity_new = new entity("Orc")
entity_new.set_health_max(3)
entity_register("ent-orc-pawn", entity_new)
