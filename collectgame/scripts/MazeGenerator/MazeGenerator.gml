/// @function MazeRoute(x, y)
function MazeRoute(X, Y) constructor {
	//static toString = function() { return "Route(" + string(x) + ", " + string(y) + "): " + string(level) }

	x = X
	y = Y

	color = 0
	derivations = undefined
	finished = false
	level = 0
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
		var Point_A, Point_B, Check_A, Check_B, Result = []
		while true {
			territory.shuffle(0, territory_size)
			Point_A = territory.at(0)
			Point_B = territory.at(1)

			Check_A = !is_undefined(Point_A)
			if Check_A {
				if Point_A.finished
					continue
				Point_A.finished = true
				Point_A.level++
				Point_A.derivations = new List()
				sub_fields.push_back(Point_A)
				array_push(Result, Point_A)
			}

			Check_B = !is_undefined(Point_B)
			if Check_B {
				if Point_B.finished
					continue
				Point_B.finished = true
				Point_B.level++
				Point_B.derivations = new List()
				sub_fields.push_back(Point_B)
				array_push(Result, Point_B)
			}
			break
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
		var Seed, SeedLvl, N, E, W, S, Sub_derive, Sprout_list, Sprout_size, Neighbor, Sub_size = sub_fields.get_size()
		var Front_index = 0

		while 0 < Sub_size and Front_index <= Sub_size - 1 {
			sub_fields.shuffle(0, Sub_size)

			expand_time = 0
			expand_time_max = irandom_range(expand_min, expand_max)

			Seed = sub_fields.at(Front_index++) // #at_zero
			if is_undefined(Seed)
				continue

			SeedLvl = Seed.level
			Sub_derive = Seed.derivations // #org_derive
			while expand_time < expand_time_max {
				Sprout_list = []

				if 0 < Seed.y {
					N = maze[Seed.y - 1][Seed.x]
					if !N.finished and (N.level) < SeedLvl and (N.derivations != Sub_derive)
						array_push(Sprout_list, N)
				}
				if Seed.x < maze_width - 1 {
					E = maze[Seed.y][Seed.x + 1]
					if !E.finished and (E.level) < SeedLvl and (E.derivations != Sub_derive)
						array_push(Sprout_list, E)
				}
				if 0 < Seed.x {
					W = maze[Seed.y][Seed.x - 1]
					if !W.finished and (W.level) < SeedLvl and (W.derivations != Sub_derive)
						array_push(Sprout_list, W)
				}
				if Seed.y < maze_height - 1 {
					S = maze[Seed.y + 1][Seed.x]
					if !S.finished and (S.level) < SeedLvl and (S.derivations != Sub_derive)
						array_push(Sprout_list, S)
				}

				Sprout_size = array_length(Sprout_list)
				if 0 < Sprout_size {
					var Sub_derive_size = Sub_derive.get_size()
					var Limit = irandom_range(blob_size_min, blob_size_max)
					var Check_on_limit = (Limit <= Sub_derive_size)
					
					if Check_on_limit {
						sub_fields.erase_at(0) // #at_zero
						break
					} else {
						Neighbor = Sprout_list[irandom(Sprout_size - 1)]
						Neighbor.level = Seed.level
						Neighbor.derivations = Sub_derive // #org_derive
						Sub_derive.push_back(Neighbor)
						sub_fields.push_back(Neighbor)
						Seed = Neighbor
					}

					expand_time++
				} else {
					sub_fields.erase_at(0) // #at_zero
				}

				Sub_size = sub_fields.get_size()
				if 0 == Sub_size
					break
			}

			Front_index = 0
			//Sub_derive.foreach(0, Sub_derive.get_size(), function(Cell) { Cell.finished = true })
			Sprout_list = 0
		}
		return Result
	}

	static fence = function() {
		var i, Field, Subfield, SibV, Siblings = growth()
		var SibNum = array_length(Siblings)
		for (i = 0; i < SibNum; ++i) {
			Field = Siblings[i]
			territory.remove(0, territory.get_size(), Field)

			Subfield = Field.derivations
			if !is_undefined(Subfield) {
				var SibProc = {
					Parent: other,
					SibReal: 0,
					SibSat: 64 + irandom(191),
					SibValue: 128 + irandom(127),
					Call: function(Cell) {
						Cell.finished = true
						Cell.color = make_color_hsv(SibReal, SibSat, SibValue)
						show_debug_message(Cell.color)
						with Parent
							territory.remove(0, territory.get_size(), Cell)
					}
				}
				SibV = real(Subfield)
				SibProc.SibReal = territory_coloring++ * 20

				Subfield.foreach(0, Subfield.get_size(), SibProc.Call)
				Subfield.clear()
				delete Subfield
			} else {
				//Field.color = $ff
			}
		}
	}

	/// @function generate()
	static generate = function() {
		do {
			fence()
		} until territory.get_size() == 0
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

	static blob_size_min = 16
	static blob_size_max = 20
	static expand_min = 10
	static expand_max = 15
}
