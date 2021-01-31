
/// @function draw_transform_add_rotation_x(angle)
function draw_transform_add_rotation_x(Angle) {
	var c = dcos(Angle)
	var s = dsin(Angle)
	var m = matrix_build_identity()
	m[5] = c
	m[6] = -s
	m[9] = s
	m[10] = c

	var mw = matrix_get(matrix_world)
	var mr = matrix_multiply(mw, m)
	matrix_set(matrix_world, mr)
}

/// @function draw_transform_add_rotation_y(angle)
function draw_transform_add_rotation_y(Angle) {
	var c = dcos(Angle)
	var s = dsin(Angle)
	var m = matrix_build_identity()
	m[0] = c
	m[2] = s
	m[8] = -s
	m[10] = c

	var mw = matrix_get(matrix_world)
	var mr = matrix_multiply(mw, m)
	matrix_set(matrix_world, mr)
}

/// @function draw_transform_add_rotation_z(angle)
function draw_transform_add_rotation_z(Angle) {
	var c = dcos(Angle)
	var s = dsin(Angle)
	var m = matrix_build_identity()
	m[0] = c
	m[1] = -s
	m[4] = s
	m[5] = c

	var mw = matrix_get(matrix_world)
	var mr = matrix_multiply(mw, m)
	matrix_set(matrix_world, mr)
}

/// @function draw_transform_add_translation(xt, yt, zt)
function draw_transform_add_translation(Xt, Yt, Zt) {
	var m = matrix_build_identity()
	m[12] = Xt
	m[13] = Yt
	m[14] = Zt

	var mw = matrix_get(matrix_world)
	var mr = matrix_multiply(mw, m)
	matrix_set(matrix_world, mr)
}

/// @function draw_transform_set_identiy()
function draw_transform_set_identiy() {
	matrix_set(matrix_world, matrix_build_identity())
}

/// @function draw_transform_set_translation(xt, yt, zt)
function draw_transform_set_translation(Xt, Yt, Zt) {
	var m = matrix_build_identity()
	m[12] = Xt
	m[13] = Yt
	m[14] = Zt

	matrix_set(matrix_world, m)
}
