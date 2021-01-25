/// @function BlobbyCell(row, column)
function BlobbyCell(Row, Col) constructor {
	static toString = function() { return "Xell (" + string(x) + ", " + string(y) + ") - " + string(state) }

	x = Col
	y = Row

	state = "blank"
	marked = false
}

/// @function BlobbyMaze(width, height)
function BlobbyMaze(Width, Height) constructor {
	/// @function region_orgarnizate()
	static region_orgarnizate = function() {					show_debug_message("1. Pop a region")
		delete boundary

		territory = ds_stack_pop(region_preceed_stack)
		if !is_undefined(territory) {							show_debug_message("Territory: " + string(territory))
			with territory {									show_debug_message("Size" + string(get_size()))
				foreach(0, get_size(), function(Cell) {
					Cell.state = "blank"
				})
			}
			
			plant()
		} else {
			state_methods = undefined
			exit
		}
	}

	/// @function plant()
	static plant = function() {									show_debug_message("2. Choose two sub regions")
		var Size = territory.get_size()
		fields.a = new List()
		fields.b = new List()

		var A = territory.at(irandom(Size - 1))
		var B = territory.at(irandom(Size - 1))
		A.state = "a"											show_debug_message("The first is: " + string(A))
		B.state = "b"											show_debug_message("The second is: " + string(B))

		fields.a.push_back(A)
		fields.b.push_back(B)

		pot = [A, B]

		growth()
	}

	/// @function growth()
	static growth = function() {								show_debug_message("3. extend the subregions")
		var cultivation_time = 0
		var Thresh = array_length(pot)							show_debug_message("Number of the rest subregions: " + string(Thresh))
		while 0 < Thresh and cultivation_time < self.cultivation_max {
		    var Front_Index = irandom(Thresh - 1)
		    var Xell = pot[Front_Index]							show_debug_message("from " + string(Xell))

		    var N = undefined, S = undefined, E = undefined, W = undefined
			var Sprout_list = []
			if 0 < Xell.y {
				N = territory.at(get_xell_index_on(Xell.x, Xell.y - 1))
				if !N.marked {
					array_push(Sprout_list, N)					show_debug_message("to north")
				}
			}
			if Xell.x < width - 1 {
				E = territory.at(get_xell_index_on(Xell.x + 1, Xell.y))
				if !E.marked {
					array_push(Sprout_list, E)					show_debug_message("to east")
				}
			}
			if 0 < Xell.x {
				W = territory.at(get_xell_index_on(Xell.x - 1, Xell.y))
				if !W.marked {
					array_push(Sprout_list, W)					show_debug_message("to west")
				}
			}
			if Xell.y < height - 1 {
				S = territory.at(get_xell_index_on(Xell.x, Xell.y + 1))
				if !S.marked {
					array_push(Sprout_list, S)					show_debug_message("to south")
				}
			}

			var Sprout_size = array_length(Sprout_list)			show_debug_message("Number of chosen cell: " + string(Sprout_size))
			if 0 < Sprout_size {
				var neighbor = Sprout_list[irandom(Sprout_size - 1)]	show_debug_message("by neighbor " + string(neighbor))
				neighbor.state = Xell.state
				//neighbor.marked = true
				array_push(pot, neighbor)

				var Target = fields[$ Xell.state]				show_debug_message("Chosen neighbor is pushed to  " + string(Target))
				Target.push_back(neighbor) // "a" or "b"
			    cultivation_time++
			} else {
				var Subfield = pot[Front_Index]					show_debug_message("Cannot extend it so delete the " + string(Subfield))
				array_delete(pot, Front_Index, 1)
			}
			Thresh = array_length(pot)
		}

		if Thresh == 0
			findWall()
		else
			growth()
	}

	/// @function findWall()
	static findWall = function() {								show_debug_message("4. Find the boundary and make walls")
		boundary = new List()

		var First = fields.a
		with First {
			foreach(0, get_size(), function(Xell) {
				var Terrain = other.territory, Procedure = method(other, other.get_xell_index_on), Bound = other.boundary
				var Width = other.width, Height = other.height, Dirs = other.directions
				var N = undefined, S = undefined, E = undefined, W = undefined
				if 0 < Xell.y {
					N = Terrain.at(Procedure(Xell.x, Xell.y - 1))
					if N.state != Xell.state
						Bound.push_back({ from: Xell, to: N, dir: Dirs.N })
				}
				if Xell.x < Width - 1 {
					E = Terrain.at(Procedure(Xell.x + 1, Xell.y))
					if E.state != Xell.state
						Bound.push_back({ from: Xell, to: E, dir: Dirs.E })
				}
				if 0 < Xell.x {
					W = Terrain.at(Procedure(Xell.x - 1, Xell.y))
					if W.state != Xell.state
						Bound.push_back({ from: Xell, to: W, dir: Dirs.W })
				}
				if Xell.y < Height - 1 {
					S = Terrain.at(Procedure(Xell.x, Xell.y + 1))
					if S.state != Xell.state
						Bound.push_back({ from: Xell, to: S, dir: Dirs.S })
				}
			})
		}														show_debug_message("Status of the first subregion: " + string(First))

		boundary.erase_at(irandom(boundary.get_size() - 1))
		dirt_cover()
	}

	/// @function dirt_cover()
	static dirt_cover = function() {							show_debug_message("5. Update the maze from sub regions")
		if is_undefined(boundary)
			findWall()

		var Csize = boundary.get_size()							show_debug_message("Size of boundary: " + string(Csize))
		while 0 < Csize{
		    var Wall = boundary.erase_at(irandom(boundary.get_size() - 1))	show_debug_message("Proceed wall: " + string(Wall))

		    uncarve(Wall.from.x, Wall.from.y, Wall.dir)
		    uncarve(Wall.to.x, Wall.to.y, bit_opposite_dir[Wall.dir])
		}

		Csize = boundary.get_size()
		if Csize == 0 {
			var Asize = fields.a.get_size()						show_debug_message("Size of the first subregion: " + string(Asize))
		    if threshold <= Asize or (4 < Asize and irandom(10) < 5) {
				ds_stack_push(region_preceed_stack, fields.a)
			} else {
				with fields.a {
					foreach(0, Asize, function(Xell) {
						Xell.state = "in"
						Xell.marked = true // these cells would not be proceed
					})
				}
			}

		    var Bsize = fields.b.get_size()						show_debug_message("Size of the second subregion: " + string(Bsize))
			if threshold <= Bsize or (4 < Bsize && irandom(10) < 5) {
				ds_stack_push(region_preceed_stack, fields.b)
			} else {
				with fields.b {
					foreach(0, Bsize, function(Xell) {
						Xell.state = "in"
						Xell.marked = true // these cells would not be proceed
					})
				}
			}

			region_orgarnizate()
			//state_method = region_orgarnizate
			//state_method()
		}
	}

	/// @function get_xell_index_on(x, y)
	static get_xell_index_on = function(X, Y) { return X + Y * width }

	/// @function carve(x, y, data)
	static carve = function(X, Y, Bits) { maze[# X, Y] |= Bits }

	/// @function uncarve(x, y, data)
	static uncarve = function(X, Y, Bits) { maze[# X, Y] &= ~Bits }

	/// @function is_set_on(x, y, data)
	static is_set_on = function(X, Y, Bits) { return ((maze[# X, Y] & Bits) == Bits) }

	bit_dir = [0x01, 0x02, 0x04, 0x08]

	bit_opposite_dir = [0x08, 0x04, 0x02, 0x01]

	directions = {
		N: 0,
		E: 1,
		W: 2,
		S: 3,
		U: 4,
	}

	directions_opposites = {
		N: 3,
		E: 2,
		W: 1,
		S: 0,
		U: 4,
	}

	DIRT_MASK = (directions.N | directions.S | directions.E | directions.W | directions.U)

	width = Width
	height = Height
	threshold = 6 // large
	cultivation_max = 5

	maze = ds_grid_create(Width, Height)
	ds_grid_clear(maze, 0)

	state_method = region_orgarnizate
	region_preceed_stack = ds_stack_create()
	var Original = new List()
	territory = Original
	fields = { a: undefined, b: undefined }
	pot = -1
	boundary = undefined
	ds_stack_push(region_preceed_stack, Original)

	var Col, Row, Xell											show_debug_message("Creating " + string(Width * Height) + " cells")
	for (Row = 0; Row < Height; ++Row) {
	    for (Col = 0; Col < Width; ++Col) {
		    Xell = new BlobbyCell(Row, Col)						show_debug_message("New Xell: " + string(Xell))
		    Original.push_back(Xell)

		    if 0 < Row {
		        carve(Col, Row, directions.N)
		        carve(Col, Row - 1, directions.S)
			}

		    if 0 < Col {
		        carve(Col, Row, directions.W)
		        carve(Col - 1, Row, directions.E)
			}
		}
	}

	region_orgarnizate()
	//dirt_cover()
}
