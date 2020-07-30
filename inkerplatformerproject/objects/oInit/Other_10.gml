/// @description 개체 상태 열거자 선언
enum entity_states {
	normal = 0,
	stunned = 90,
	dead
}

enum swimming {
	never = -1,
	drown = 0,
	water,
	lava
}

enum mob_category {
	none				= 0,
	human				= 1,		//0x00000000001
	insect			= 2,		//0x00000000010
	animal			= 16,		//0x00000010000, big category
	reptile			= 20,		//0x00000010100, under animal
	beastary		= 17,		//0x00000010001, human * animal
	statue			= 32,		//0x00000100000
	elemental		= 64,		//0x00001000000
	chaos				= 128,	//0x00010000000
	undead			= 256,	//0x00100000000
	holy				= 512,	//0x01000000000
	demon				= 1028, //0x10000000000
}

enum ai_patterns {
	statue = -1,
	
}
