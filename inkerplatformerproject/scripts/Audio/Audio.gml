///@function audio_set_gain_bgm(level, [time])
function audio_set_gain_bgm(value, ms) {
	var time = select_argument(ms, 0)
	audio_group_set_gain(audio_bgm, value, time)
}
///@function audio_set_gain_sfx(level, [time])
function audio_set_gain_sfx(value, ms) {
	var time = select_argument(ms, 0)
	audio_group_set_gain(audio_sfx, value, time)
}
