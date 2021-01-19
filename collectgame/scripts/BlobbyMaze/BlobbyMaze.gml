function BlobbyCell(row, col) constructor {
	state = "active"
	name = "r#{row}c#{col}"
	north = "r#{row-1}c#{col}"
	south = "r#{row+1}c#{col}"
	east = "r#{row}c#{col+1}"
	west = "r#{row}c#{col-1}"
}

function BlobbyRegion(): List() constructor {
	static add_cell = function(cell) {
		cell.name = cell
		cells.push(cell)
	}
}

function BlobbyMaze(maze) constructor {
	static stateAt = function(col, row) {
		var Name = "r#{row}c#{col}"
		cell = region[name]

		if cell
		    return cell.state
		else
		    return "blank"
	}

	static step = function() {
		switch state {
		    case START: startRegion() break
		    case PLANT: plantSeeds() break
		    case GROW: growSeeds() break
		    case WALL: drawWall() break
		}
	}

	static startRegion = function() {
		delete boundary
		region = stack.pop()

		if region {
			//for cell in region.cells { delete cell.state }
		    highlightRegion(region)
		    state = PLANT
		    return true
		} else {
		    return false
		}
	}

	static plantSeeds = function() {
		var indexes = irandom(region.cells.length)
		var subregions = {
			a: new BlobbyRegion(),
			b: new BlobbyRegion()
		}

		var A = region.cells[indexes[0]]
		var B = region.cells[indexes[1]]

		A.state = "a"
		B.state = "b"

		subregions.a.add_cell(A)
		subregions.b.add_cell(B)

		updateAt(A.col, A.row)
		updateAt(B.col, B.row)

		frontier = [A, B]
		state = GROW
		return true
	}

	static growSeeds = function() {
		growCount = 0
		while 0 < frontier.length and growCount < growSpeed {
		    index = rand.nextInteger(frontier.length)
		    cell = frontier[index]

		    n = region[cell.north()]
		    s = region[cell.south()]
		    e = region[cell.east()]
		    w = region[cell.west()]

		    var list = []
			if n && !n.state
				list.push(n)
			if s && !s.state
				list.push(s)
			if e && !e.state
				list.push(e)
			if w && !w.state
				list.push(w)

		    if list.length > 0 {
			    neighbor = rand.randomElement(list)
			    neighbor.state = cell.state
			    subregions[cell.state].add_cell(neighbor)
			    frontier.push(neighbor)
			    updateAt(neighbor.col, neighbor.row)
			    growCount++
			} else {
				frontier.splice(index, 1)
			}
		}

		if frontier.length == 0
			state = WALL
		else
			state = GROW

		return true
	}

	static findWall = function() {
		boundary = []

		for cell in subregions.a.cells {
		    n = region[cell.north()]
		    s = region[cell.south()]
		    e = region[cell.east()]
		    w = region[cell.west()]

		    if n && n.state != cell.state
			boundary.push { from = cell, to = n, dir = Maze.Direction.N }
		    if s && s.state != cell.state
		    boundary.push { from = cell, to = s, dir = Maze.Direction.S }
		    if e && e.state != cell.state
		    boundary.push { from = cell, to = e, dir = Maze.Direction.E }
		    if w && w.state != cell.state
		    boundary.push { from = cell, to = w, dir = Maze.Direction.W }
		}

		rand.removeRandomElement(boundary)
	}

	static drawWall = function() {
		if !boundary
			findWall()

		wallCount = 0
		while boundary.length > 0 && wallCount < wallSpeed
		    wall = rand.removeRandomElement(boundary)

		    maze.uncarve(wall.from.col, wall.from.row, wall.dir)
		    maze.uncarve(wall.to.col, wall.to.row, Maze.Direction.opposite[wall.dir])
		    updateAt wall.from.col, wall.from.row
		    wallCount += 1

		if boundary.length == 0 {
		    cell.state = "blank" for cell in region.cells

		    if subregions.a.cells.length >= threshold || (subregions.a.cells.length > 4 && rand.nextInteger() % 10 < 5)
		    stack.push subregions.a
		    else
		    cell.state = "in" for cell in subregions.a.cells

		    if subregions.b.cells.length >= threshold || (subregions.b.cells.length > 4 && rand.nextInteger() % 10 < 5)
		    stack.push subregions.b
		    else
		    cell.state = "in" for cell in subregions.b.cells

		    highlightRegion subregions.a
		    highlightRegion subregions.b

		    state = START
		}

		return true
	}

	START = 1
	PLANT = 2
	GROW  = 3
	WALL  = 4

	threshold = 6 // large
	growSpeed = 5
	wallSpeed = 2

	stack = new List()
	region = new BlobbyRegion()

	for (var row = 0; row < maze.height; ++row) {
	    for (var col = 0; col < maze.width; ++col) {
		    var cell = new BlobbyCell(row, col)
		    region.add_cell(cell)

		    if row > 0 {
		        maze.carve(col, row, Maze.Direction.N)
		        maze.carve(col, row-1, Maze.Direction.S)
			}

		    if col > 0 {
		        maze.carve(col, row, Maze.Direction.W)
		        maze.carve(col-1, row, Maze.Direction.E)
			}
		}
	}

	stack.push_back(region)
	state = START

}

highlightRegion = function(region) {
	for (var i = 0; i < region.cells.length; ++i) {
		var cell = region.cells[i]
	    updateAt(cell.col, cell.row)
	}
}