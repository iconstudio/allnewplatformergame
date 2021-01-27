/// @function MazeRoute(x, y)
function MazeRoute(X, Y) constructor {
	static toString = function() { return "Route(" + string(x) + ", " + string(y) + "): " + string(level) }

	x = X
	y = Y

	finished = false
	derivations = undefined
	level = 0

	color = 0
	category = ROOM_CATEGORY.NORMAL
	type = 0
	bit = 0
}

/// @function MazeGenerator(width, height)
function MazeGenerator(Width, Height) constructor {
	/// @function mt_random(value)
	static mt_random = function(Value) { return engine.make_integer(Value) }

	/// @function mt_range(start, end)
	static mt_range = function(Start, End) { return Start + mt_random(End - Start) }

	/// @function carve(x, y, data)
	static carve = function(X, Y, Bits) { maze[Y, X] |= Bits }

	/// @function plant()
	static plant = function() {
		var territory_size = territory.get_size()

		// Preparing two sub regions
		var Point_A, Point_B, Check_A, Check_B, Sub_derive, Result = []
		territory.shuffle(0, territory_size)
		Point_A = territory.at(0)
		Point_B = territory.at(1)

		Check_A = !is_undefined(Point_A)
		if Check_A and !Point_A.finished {
			Point_A.finished = true
			Point_A.level++

			Sub_derive = new List()
			Point_A.derivations = Sub_derive
			Sub_derive.push_back(Point_A)
			sub_fields.push_back(Point_A)
			array_push(Result, Point_A)
		}

		Check_B = !is_undefined(Point_B)
		if Check_B and !Point_B.finished {
			Point_B.finished = true
			Point_B.level++

			Sub_derive = new List()
			Point_B.derivations = Sub_derive
			Sub_derive.push_back(Point_B)
			sub_fields.push_back(Point_B)
			array_push(Result, Point_B)
		}

		if !Check_A and !Check_B
			throw MSG_COMPLETE

		return Result
	}

	/// @function growth()
	/// @description Slice the half of region
	static growth = function() {
		var Result = plant()

		var expand_time, expand_time_max
		var Seed, SeedLvl, N, E, W, S
		var Sub_derive, Sprout_list, Sprout_size, Neighbor, Sub_size = sub_fields.get_size()

		show_debug_message("Growth")
		while 0 < Sub_size {
			sub_fields.shuffle(0, Sub_size)

			expand_time = 0
			expand_time_max = irandom_range(expand_min, expand_max)

			Seed = sub_fields.front()
			if is_undefined(Seed) {
				sub_fields.pop_front()
				break
			}

			show_debug_message(string(Seed))
			SeedLvl = Seed.level
			Sub_derive = Seed.derivations // #org_derive

			while expand_time < expand_time_max {
				Sprout_list = []

				if 0 < Seed.y {
					N = maze[Seed.y - 1][Seed.x]
					if !N.finished and (is_undefined(N.derivations) or (Sub_derive != N.derivations and N.level < irandom(SeedLvl + 1) + 1))
						array_push(Sprout_list, N)
				}
				if Seed.x < maze_width - 1 {
					E = maze[Seed.y][Seed.x + 1]
					if !E.finished and (is_undefined(E.derivations) or (Sub_derive != E.derivations and E.level < irandom(SeedLvl + 1) + 1))
						array_push(Sprout_list, E)
				}
				if 0 < Seed.x {
					W = maze[Seed.y][Seed.x - 1]
					if !W.finished and (is_undefined(W.derivations) or (Sub_derive != W.derivations and W.level < irandom(SeedLvl + 1) + 1))
						array_push(Sprout_list, W)
				}
				if Seed.y < maze_height - 1 {
					S = maze[Seed.y + 1][Seed.x]
					if !S.finished and (is_undefined(S.derivations) or (Sub_derive != S.derivations and S.level < irandom(SeedLvl + 1) + 1))
						array_push(Sprout_list, S)
				}

				Sprout_size = array_length(Sprout_list)
				if 0 < Sprout_size {
					var Sub_derive_size = Sub_derive.get_size()
					var Limit = irandom_range(blob_size_min, blob_size_max)
					var Check_on_limit = (Limit <= Sub_derive_size)

					Neighbor = Sprout_list[irandom(Sprout_size - 1)]
					Neighbor.level = Seed.level
					Neighbor.derivations = Sub_derive // #org_derive
					Sub_derive.push_back(Neighbor)
					sub_fields.push_back(Neighbor)
					Seed = Neighbor
					if Check_on_limit {
						sub_fields.pop_front()
						break
					}

					expand_time++
				} else {
					sub_fields.pop_front()
					break
				}

				Sub_size = sub_fields.get_size()
				if 0 == Sub_size
					break
			}

			Sprout_list = 0
		}
		return Result
	}

	static fence = function() {
		show_debug_message("Fence")
		var i, Field, Subfield, SibV, Siblings = growth()
		var SibNum = array_length(Siblings)
		for (i = 0; i < SibNum; ++i) {
			Field = Siblings[i]

			Subfield = Field.derivations
			if !is_undefined(Subfield) {
				Subfield.foreach(0, Subfield.get_size(), method(self, function(Cell) {
					territory.remove(0, territory.get_size(), Cell)
				}))
			}
		}
	}

	static cleanup = function() {
		show_debug_message("Cleanup")
		var X, Y, N, E, W, S, Cell, Sub_derive, Sub_size, Refer_list, Refer_count, Refer_max, Result = 0
		for (Y = 0; Y < maze_height; ++Y) {
		    for (X = 0; X < maze_width; ++X) {
				//if irandom(9) == 0 continue

			    Refer_list = []
				Refer_count = 0
				Refer_max = 4
				Cell = maze[Y][X]
				Sub_derive = Cell.derivations
				Sub_size = Sub_derive.get_size()
				if blob_size_min <= Sub_size
					continue

				if 0 < Y {
					N = maze[Y - 1][X]
					if N.derivations != Sub_derive {
						array_push(Refer_list, N)
						Refer_count++
					}
				} else {
					Refer_max--
				}

				if X < maze_width - 1 {
					E = maze[Y][X + 1]
					if E.derivations != Sub_derive {
						array_push(Refer_list, E)
						Refer_count++
					}
				} else {
					Refer_max--
				}

				if 0 < X {
					W = maze[Y][X - 1]
					if E.derivations != Sub_derive {
						array_push(Refer_list, E)
						Refer_count++
					}
				} else {
					Refer_max--
				}

				if Y < maze_height - 1 {
					S = maze[Y + 1][X]
					if S.derivations != Sub_derive {
						array_push(Refer_list, S)
						Refer_count++
					}
				} else {
					Refer_max--
				}

				if 2 < Refer_count and Refer_max == Refer_count {
					Result++
					var Choosen = Refer_list[irandom(Refer_count - 1)]
					var Target = Choosen.derivations
					show_debug_message("Choosen: " + string(Choosen))

					var Sub_cell, Sub_to_delete = false, Add_size = Sub_size
					for (var i = 0; i < Add_size;) {
						Sub_cell = Sub_derive.at(i)
						Sub_cell.derivations = Target
						Target.push_back(Sub_cell)

						i++
						Sub_size++
						if blob_size_max <= Sub_size {
							if Add_size <= i
								Sub_to_delete = true
							break
						}
					}

					if Sub_to_delete {
						Sub_derive.clear()
						delete Sub_derive
					}
				}
			}
			show_debug_message("Doing: " + string(Result))
		}
		Refer_list = 0

		return Result
	}

	/// @function generate()
	static generate = function() {
		do {
			fence()
		} until territory.get_size() == 0

		var Dup_count = 0
		do {
			Dup_count = cleanup()
		} until Dup_count <= 50

		var X, Y, Field, Subfield
		for (Y = 0; Y < maze_height; ++Y) {
		    for (X = 0; X < maze_width; ++X) {
			    Field = maze[Y][X]

				Subfield = Field.derivations
				if !is_undefined(Subfield) {
					var SibProc = {
						Parent: other,
						SibReal: 0,
						SibSat: 128 + irandom(31),
						SibValue: 192 + irandom(63),
						Call: function(Cell) {
							Cell.finished = true
							Cell.color = make_color_hsv(SibReal, SibSat, SibValue - (Cell.level - 1) * 28)
						}
					}

					var threshold = maze_width * 0.5
					if X < threshold * 0.5 {
						SibProc.SibReal = X * 2 + irandom(40)
					} else if X < threshold {
						SibProc.SibReal = X * 2.5 + irandom(50)
					} else {
						SibProc.SibReal = X * 3.5 + irandom(30)
					}

					Subfield.foreach(0, Subfield.get_size(), SibProc.Call)

					Subfield.clear()
					delete Subfield
				}
			}
		}
	}

	maze_width = Width
	maze_height = Height
	maze_count = Width * Height
	maze = array_create(Height)
	for (var i = 0; i < Height; ++i)
		maze[i] = array_create(Width, 0)
	MSG_COMPLETE = 6000

	territory = new List()
	sub_fields = new List()
	territory_coloring = 0

	var Col, Row, Cell
	for (Row = 0; Row < Height; ++Row) {
	    for (Col = 0; Col < Width; ++Col) {
		    Cell = new MazeRoute(Col, Row)
			maze[Row][Col] = Cell
		    territory.push_back(Cell)
		}
	}
	
	seed = random_get_seed()
	engine = new MersenneTwister(seed)

	static blob_size_min = 12
	static blob_size_max = 20
	static expand_min = 10
	static expand_max = 15
}
