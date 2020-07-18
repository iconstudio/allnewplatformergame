/// @description 속성 선언
enum damage_types {
	physical,
	magical
}

enum elements {
	none = 0, // 0, 무속성 (기본 방어율)
	fire,
	cold,
	air,
	electricity,
	poison, // 5, 독
	acid,
	warp, // 7, 왜곡
	negative, // 8, 음에너지
	positive // 9, 양에너지 
} // 10개

// ** 이름 **
global.__element_names = ds_map_create()
global.__element_names[? elements.none] = "physical"
global.__element_names[? elements.fire] = "fire"
global.__element_names[? elements.cold] = "cold"
global.__element_names[? elements.air] = "air"
global.__element_names[? elements.electricity] = "electricity"
global.__element_names[? elements.poison] = "poison"
global.__element_names[? elements.acid] = "acid"
global.__element_names[? elements.warp] = "warp"
global.__element_names[? elements.negative] = "negative"
global.__element_names[? elements.positive] = "positive"

// ** 저항 **
global.__element_resist = array_create(10)
global.__element_resist[elements.none] = 0.0
global.__element_resist[elements.fire] = [-1.0, -0.65, -0.30, 0.0, 0.5, 0.666, 0.8, 1.0]
global.__element_resist[elements.cold] = global.__element_resist[elements.fire]
global.__element_resist[elements.air] = global.__element_resist[elements.fire]

global.__element_resist[elements.electricity] = [-1.0, -0.75, -0.333, -0.1, 0.35, 0.65, 0.95, 1.0]
global.__element_resist[elements.poison] = global.__element_resist[elements.electricity]
global.__element_resist[elements.acid] = global.__element_resist[elements.electricity]

global.__element_resist[elements.warp] = [-1.5, -1.0, -0.5, -0.25, 0.0, 0.25, 0.75, 1.0]

global.__element_resist[elements.negative] = [-2.0, -1.3, -0.6, 0.0, 0.333, 0.666, 1.0, 1.0]
global.__element_resist[elements.positive] = global.__element_resist[elements.negative]


