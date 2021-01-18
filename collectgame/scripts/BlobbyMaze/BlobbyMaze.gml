function BlobbyCell(row, col) constructor {
	static name = "r#{row}c#{col}"

	static north = "r#{row-1}c#{col}"
	static south = "r#{row+1}c#{col}"
	static east = "r#{row}c#{col+1}"
	static west = "r#{row}c#{col-1}"
}

function BlobbyRegion() constructor {
	cells = []

	static addCell = function(cell) {
		cell.name = cell
		cells.push(cell)
	}
}

function BlobbyMaze(maze) constructor {
	START = 1
	PLANT = 2
	GROW  = 3
	WALL  = 4

	threshold = 6
	growSpeed = 5
	wallSpeed = 2

	stack = []

	region = new BlobbyRegion()
	for (var row = 0; row < maze.height; ++row) {
	    for (var col = 0; col < maze.width; ++col) {
		    var cell = new BlobbyCell(row, col)
		    region.addCell(cell)

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

	stack.push(region)
	state = START

	static stateAt = function(col, row) {
		name = "r#{row}c#{col}"
		cell = region?[name]

		if cell
		    return cell.state ? "active"
		else
		    return "blank"
	}

	static step = function() {
		switch state
		    when START then startRegion()
		    when PLANT then plantSeeds()
		    when GROW  then growSeeds()
		    when WALL  then drawWall()
	}

	static startRegion = function() {
		delete boundary
		region = stack.pop()

		if region
		    delete cell.state for cell in region.cells
		    highlightRegion(region)
		    state = PLANT
		    return true
		else
		    return false
	}

	static plantSeeds = function() {
		indexes = rand.randomizeList([0...region.cells.length])

		subregions = { a = new BlobbyRegion, b = new BlobbyRegion }

		a = region.cells[indexes[0]]
		b = region.cells[indexes[1]]

		a.state = "a"
		b.state = "b"

		subregions.a.addCell a
		subregions.b.addCell b

		updateAt a.col, a.row
		updateAt b.col, b.row

		frontier = [a, b]

		state = GROW

		return true
	}

	static growSeeds = function() {
		growCount = 0
		while frontier.length > 0 && growCount < growSpeed {
		    index = rand.nextInteger(frontier.length)
		    cell = frontier[index]

		    n = region[cell.north()]
		    s = region[cell.south()]
		    e = region[cell.east()]
		    w = region[cell.west()]

		    list = []
		    list.push n if n && !n.state
		    list.push s if s && !s.state
		    list.push e if e && !e.state
		    list.push w if w && !w.state

		    if list.length > 0 {
			    neighbor = rand.randomElement(list)
			    neighbor.state = cell.state
			    subregions[cell.state].addCell neighbor
			    frontier.push neighbor
			    updateAt neighbor.col, neighbor.row
			    growCount += 1
			} else {
				frontier.splice(index, 1)
			}
		}

		state = if frontier.length == 0 then WALL else GROW
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
		findWall() if !boundary

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
}

highlightRegion = function(region) {
	for (var i = 0; i < region.cells.length; ++i) {
		var cell = region.cells[i]
	    updateAt cell.col, cell.row
	}
}