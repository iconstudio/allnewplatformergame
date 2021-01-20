/// @function BlobbyCell(row, column)
function BlobbyCell(Row, Col) constructor {
	x = Col
	y = Row

	marked = false
}

function BlobbyMaze(Width, Height) constructor {
	static get_xell_index_on = function(X, Y) {
		return X + Y * width
	}

	static region_orgarnizate = function() {
		delete boundary

		territory = ds_stack_pop(region_preceed_stack)
		if !is_undefined(territory) {
			with territory {
				foreach(0, get_size(), function(Cell) {
					Cell.marked = false
				})
			}
			state_methods = plant
		} else {
			state_methods = undefined
			exit
		}
		
	}

	static plant = function() {
		var indexes = irandom(territory.get_size() - 1)
		fields.a = new List()
		fields.b = new List()

		var A = territory.at(indexes[0])
		var B = territory.at(indexes[1])
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
				}
				if Xell.x < width - 1 {
					E = territory[get_xell_index_on(Xell.x + 1, Xell.y)]
				}
				if 0 < Xell.x {
					W = territory[get_xell_index_on(Xell.x - 1, Xell.y)]
				}
				if Xell.y < height - 1 {
					S = territory[get_xell_index_on(Xell.x, Xell.y + 1)]
				}

			    if n && n.state != Cell.state
					boundary.push({ from: Cell, to: n, dir: Maze.Direction.N })
			    if s && s.state != Cell.state
					boundary.push({ from: Cell, to: s, dir: Maze.Direction.S })
			    if e && e.state != Cell.state
					boundary.push({ from: Cell, to: e, dir: Maze.Direction.E })
			    if w && w.state != Cell.state
					boundary.push({ from: Cell, to: w, dir: Maze.Direction.W })
			})
		}

		boundary.erase_at(irandom(boundary.get_size() - 1))
		state_methods = dirt_cover
	}

	static dirt_cover = function() {
		if is_undefined(boundary)
			findWall()

		var wallCount = 0
		while boundary.length > 0 && wallCount < wallSpeed {
		    wall = rand.removeRandomElement(boundary)

		    maze.uncarve(wall.from.col, wall.from.row, wall.dir)
		    maze.uncarve(wall.to.col, wall.to.row, Maze.Direction.opposite[wall.dir])

		    wallCount++
		}

		if boundary.length == 0 {
			//for cell in territory.cells cell.state = "blank"

		    if fields.a.cells.length >= threshold || (fields.a.cells.length > 4 && rand.nextInteger() % 10 < 5) {
				ds_stack_push(region_preceed_stack, fields.a)
			} else {
				with fields.a {
					foreach(0, get_size(), function(Cell) {
						Cell.marked = true
					})
				}
			}

		    if fields.b.cells.length >= threshold || (fields.b.cells.length > 4 && rand.nextInteger() % 10 < 5) {
				ds_stack_push(region_preceed_stack, fields.b)
			} else {
				with fields.b {
					foreach(0, get_size(), function(Cell) {
						Cell.marked = true
					})
				}
			}

		    state_method = startRegion
		}

		return true
	}

	width = Width
	height = Height
	threshold = 6 // large
	cultivation_max = 5
	wallSpeed = 2

	state_method = startRegion
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
		        //maze.carve(Col, Row, Maze.Direction.N)
		        //maze.carve(Col, Row-1, Maze.Direction.S)
			}

		    if 0 < Col {
		        //maze.carve(Col, Row, Maze.Direction.W)
		        //maze.carve(Col-1, Row, Maze.Direction.E)
			}
		}
	}
}
