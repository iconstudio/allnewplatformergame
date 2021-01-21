/// @function BlobbyCell(row, column)
function BlobbyCell(Row, Col) constructor {
	x = Col
	y = Row

	state = "blank"
	marked = false
}

function BlobbyMaze(Width, Height) constructor {
	static region_orgarnizate = function() {
		delete boundary

		territory = ds_stack_pop(region_preceed_stack)
		if !is_undefined(territory) {
			with territory {
				foreach(0, get_size(), function(Cell) {
					Cell.state = "blank"
				})
			}
			state_methods = plant
		} else {
			state_methods = undefined
			exit
		}
		
	}

	static plant = function() {
		var Size = territory.get_size()
		fields.a = new List()
		fields.b = new List()

		var A = territory.at(irandom(Size - 1))
		var B = territory.at(irandom(Size - 1))
		A.state = "a"
		B.state = "b"

		fields.a.push_back(A)
		fields.b.push_back(B)

		pot = [A, B]

		state_methods = growth
	}

	static growth = function() {
		var cultivation_time = 0
		var Thresh = array_length(pot)
		while 0 < Thresh and cultivation_time < self.cultivation_max {
		    var Front_Index = irandom(Thresh - 1)
		    var Xell = pot[Front_Index]

		    var N = undefined, S = undefined, E = undefined, W = undefined
			var Sprout_list = []
			if 0 < Xell.y {
				N = territory[get_xell_index_on(Xell.x, Xell.y - 1)]
				if !N.marked
					array_push(Sprout_list, N)
			}
			if Xell.x < width - 1 {
				E = territory[get_xell_index_on(Xell.x + 1, Xell.y)]
				if !E.marked
					array_push(Sprout_list, E)
			}
			if 0 < Xell.x {
				W = territory[get_xell_index_on(Xell.x - 1, Xell.y)]
				if !W.marked
					array_push(Sprout_list, W)
			}
			if Xell.y < height - 1 {
				S = territory[get_xell_index_on(Xell.x, Xell.y + 1)]
				if !S.marked
					array_push(Sprout_list, S)
			}

			var Sprout_size = array_length(Sprout_list)
			if 0 < Sprout_size {
				var neighbor = Sprout_list[irandom(Sprout_size - 1)]
				neighbor.state = Xell.state
				neighbor.marked = true
				array_push(pot, neighbor)

				fields[$ Xell.state].push_back(neighbor) // "a" or "b"
			    cultivation_time++
			} else {
				var Subfield = pot[Front_Index]
				delete Subfield
				array_delete(pot, Front_Index, 1)
			}
			Thresh = array_length(pot)
		}

		if Thresh == 0
			state_methods = findWall
		else
			state_methods = growth
	}

	static findWall = function() {
		boundary = new List()

		with fields.a {
			foreach(0, get_size(), function(Xell) {
				var N = undefined, S = undefined, E = undefined, W = undefined
				if 0 < Xell.y {
					N = territory[get_xell_index_on(Xell.x, Xell.y - 1)]
					if N.state != Xell.state
						array_push(boundary, { from: Xell, to: N, dir: Maze.Direction.N })
				}
				if Xell.x < width - 1 {
					E = territory[get_xell_index_on(Xell.x + 1, Xell.y)]
					if E.state != Xell.state
						array_push(boundary, { from: Xell, to: E, dir: Maze.Direction.E })
				}
				if 0 < Xell.x {
					W = territory[get_xell_index_on(Xell.x - 1, Xell.y)]
					if W.state != Xell.state
						array_push(boundary, { from: Xell, to: W, dir: Maze.Direction.W })
				}
				if Xell.y < height - 1 {
					S = territory[get_xell_index_on(Xell.x, Xell.y + 1)]
					if S.state != Xell.state
						array_push(boundary, { from: Xell, to: S, dir: Maze.Direction.S })
				}
			})
		}

		boundary.erase_at(irandom(boundary.get_size() - 1))
		state_methods = dirt_cover
	}

	static dirt_cover = function() {
		if is_undefined(boundary)
			findWall()

		var Csize = boundary.get_size(), wallCount = 0
		while 0 < Csize and wallCount < wallSpeed {
		    var Wall = boundary.erase_at(irandom(boundary.get_size() - 1))

		    uncarve(Wall.from.x, Wall.from.y, Wall.dir)
		    uncarve(Wall.to.x, Wall.to.y, Maze.Direction.opposite[Wall.dir])

		    wallCount++
		}

		Csize = boundary.get_size()
		if Csize == 0 {
			var Asize = fields.a.get_size()
		    if threshold <= Asize or (4 < Asize and irandom(10) < 5) {
				ds_stack_push(region_preceed_stack, fields.a)
			} else {
				with fields.a {
					foreach(0, Asize, function(Cell) {
						Cell.marked = true
					})
				}
			}

		    var Bsize = fields.b.get_size()
			if threshold <= Bsize or (4 < Bsize && irandom(10) < 5) {
				ds_stack_push(region_preceed_stack, fields.b)
			} else {
				with fields.b {
					foreach(0, Bsize, function(Cell) {
						Cell.marked = true
					})
				}
			}

			state_method = region_orgarnizate
		}
	}

	static get_xell_index_on = function(X, Y) { return X + Y * width }

	static carve = function(X, Y, Bits) { maze[# X, Y] |= Bits }

	static uncarve = function(X, Y, Bits) { maze[# X, Y] &= ~Bits }

	static isMarked = function(X, Y, Bits) { return ((maze[# X, Y] & Bits) == Bits) }

	N = 0x01
	S = 0x02
	E = 0x04
	W = 0x08
	U = 0x10
	DIRT_MASK = (N | S |  E | W | U)

	width = Width
	height = Height
	threshold = 6 // large
	cultivation_max = 5
	wallSpeed = 2

	maze = ds_grid_create(Width, Height)
	ds_grid_clear(maze, 0)

	state_method = region_orgarnizate
	region_preceed_stack = ds_stack_create()
	territory = undefined
	fields = { a: undefined, b: undefined }
	pot = -1
	boundary = undefined
	ds_stack_push(region_preceed_stack, new List())

	var Col, Row, Xell
	for (var row = 0; Row < Height; ++Row) {
	    for (var Col = 0; Col < Width; ++Col) {
		    var Xell = new BlobbyCell(Row, Col)
		    territory.push_back(Xell)

		    if 0 < Row {
		        carve(Col, Row, Maze.Direction.N)
		        carve(Col, Row-  1, Maze.Direction.S)
			}

		    if 0 < Col {
		        carve(Col, Row, Maze.Direction.W)
		        carve(Col-  1, Row, Maze.Direction.E)
			}
		}
	}
}
