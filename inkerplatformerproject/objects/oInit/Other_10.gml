/// @description 개체 상태 열거자 선언
enum mob_status {
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
	tested			= 8,		//0x00000001000
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

enum mob_ai_states {
	none = -1,
	stop = 0,
	idle,
	normal,
	tracking,
	attacking,
	retreat
}

enum mob_ai_move_types { // 몹의 평상시 이동 방식
	none = -1,
	stand = 0, // 가만히 있음
	roaming, // 배회
	guard, // 지역 방어, 정지, 추적하다 돌아감
	guard_roam, // 지역 배회
	guard_track, // 한번 추적하면 계속 함
	guard_roam_track, // 지역 배회, 한번 추적하면 계속 함
	guard_patrol, // 지역 왕복
	tracking_always // 항상 정확하게 플레이어 추적
}

enum mob_ai_track_types { // 몹이 적 발견시 이동 방식
	none = -1, // 추적 안함
	stop, // 공격 시엔 정지
	to_range, // 사정거리까지만 이동
	close, // 무조건 타일 한칸 거리까지 이동
	suicidal, // 무조건 돌격 (겹침)
	roaming, // 배회
	stay_away, // 거리 유지를 시도함
	retreat, // 반대편으로 도망감
	tracking_always // 항상 정확하게 플레이어 추적, 공격 상태가 풀리지 않음.
}

enum mob_ai_attack_types { // 몹의 공격 방식
	none = -1, // 공격 안함
	normal, // 보통
	close, // 항상 가까이 접근
	suicidal // 자살 공격 (겹침)
}
