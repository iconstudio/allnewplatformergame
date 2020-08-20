///@function draw_transform_set_identiy()
function draw_transform_set_identity() {
	matrix_set(matrix_world, matrix_build_identity())
}

/// @function draw_transform_set_translation(x, y, z)
function draw_transform_set_translation(xt, yt, zt) {
	var m = matrix_build_identity()
	m[12] = xt
	m[13] = yt
	m[14] = zt
	matrix_set(matrix_world, m)
}

/// @function draw_transform_add_translation(x, y, z)
function draw_transform_add_translation(xt, yt, zt) {
	var m = matrix_build_identity()
	m[12] = xt
	m[13] = yt
	m[14] = zt

	var mw = matrix_get(matrix_world)
	var mr = matrix_multiply(mw, m)
	matrix_set(matrix_world, mr)
}

/// @function draw_transform_set_scaling(x, y, z)
function draw_transform_set_scaling(xt, yt, zt) {
	var m = matrix_build_identity()
	m[0] = xt
	m[5] = yt
	m[10] = zt
	matrix_set(matrix_world, m)
}

/// @function draw_transform_add_scaling(x, y, z)
function draw_transform_add_scaling(xt, yt, zt) {
	var mT = matrix_build_identity()
	mT[0] = xt
	mT[5] = yt
	mT[10] = zt
	var m = matrix_get(matrix_world)
	var mR = matrix_multiply(m, mT)
	matrix_set(matrix_world, mR)
}
