/// @description 스테이지 정보 초기화
enum chapter_identity {
	intro = 0,
	dungeon,
	underworld,
	volcano,
	forest,
	city,
	factory,
	mountain,
	underworld_hell
}

global.__ch_infos = new List()

function chapter_info(sn, caption, desc) constructor {
	serial = sn
	title = caption
	description = desc
}

function chapter_info_add(sn, caption, desc) {
	var result = new chapter_info(sn, caption, desc)
	global.__ch_infos.add(result)
}

chapter_info_add(chapter_identity.intro, "The Introduction", "")
chapter_info_add(chapter_identity.dungeon, "The Dungeon of Sorrow", "")
chapter_info_add(chapter_identity.underworld, "The Underworld Plain", "")
