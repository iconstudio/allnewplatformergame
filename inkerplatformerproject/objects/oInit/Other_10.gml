/// @description 개체 상태 열거자 선언
enum entity_states {
	normal = 0,
	stunned = 90,
	dead
}

enum mob_swimming {
	never = -1,
	drown = 0,
	water,
	lava
}

enum mob_category {
	none				= 0,
	human				= 1,		//0x00000000001
	insect			= 2,		//0x00000000010
	animal			= 16,		//0x00000010000, 동물 대분류
	reptile			= 20,		//0x00000010100, 동물
	beastary		= 17,		//0x00000010001, human & animal
	statue			= 32,		//0x00000100000
	elemental		= 64,		//0x00001000000
	chaos				= 128,	//0x00010000000
	undead			= 256,	//0x00100000000
	holy				= 512,	//0x01000000000
	demon				= 1028, //0x10000000000
}

enum mob_intelligences {
	no_brain = -1,
	natural = 0,
	stupid,
	dull, // 둔함
	normal = 40, // 대다수 몹
	good = 50, // 플레이어
	smart = 60,
	clever = 80,
	omniscent = 100 // 전지, 일부 몹만 해당
}

enum mob_ai_movings { // 몹 평상시 이동 유형
	nothing = -1,
	trap = 0,
	statue = 1,
	roaming, // 배회
	roaming_natural, // 비선공, 추적 및 배회
	roaming_tracking, // 선공, 추적 및 배회
	guard_static, // 선공, 정지
	guard_roaming, // 선공, 배회
	guard_tracking, // 선공, 추적
	guard_patrol, // 선공, 왕복
	tracking_always, // 항상 정확하게 플레이어 추적
	tracking_natural, // 항상 플레이어를 추적하지만 발견 전까진 무작위로 이동함
}

enum mob_ai_attack_patterns {
	none = 0, // 공격 안함
	normal, // 보통
	hover, // 공격하면서 이동하기
	charger, // 항상 몸통 박치기
	suicidal, // 자살 공격
	stay_away, // 거리 유지를 시도함
	stay_away_always, // 항상 도망가서 거리 유지
}
