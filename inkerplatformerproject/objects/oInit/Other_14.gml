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

global.__ch_infos = ds_list_create()

function chapter_info(sn, caption, desc) constructor {
	serial = sn
	title = caption
	description = desc
}

chapter_info_add(chapter_identity.intro, "The Introduction", "")
chapter_info_add(chapter_identity.dungeon, "The Dungeon of Sorrow", "")
chapter_info_add(chapter_identity.underworld, "The Underworld Plain", "")
