class_name Board
extends Resource

signal piece_transition_finished(did_anything : bool)

const ROWS : int = 6
const COLS : int = 7


var board : Array[Piece] = []

func _init() -> void:
	for i in COLS*ROWS:
		board.append(null)
	


func in_bounds(x : int, y : int) -> bool:
	if x < 0 || y < 0:
		return false
	if x >= COLS || y >= ROWS:
		return false
	return true

func get_piece(x : int, y : int) -> Piece:
	assert(in_bounds(x,y), "Out of bounds get")
	return board[y*COLS+x]

func set_piece(piece : Piece, x : int, y : int) -> void:
	assert(get_piece(x,y) == null, "trying to set a piece that's not empty!")
	board[y*COLS+x] = piece

##Finds the lowest empty from the top of the board
func find_lowest_empty(x : int) -> int:
	return find_lowest_empty_xy(x,0)


func find_lowest_empty_xy(x : int, y : int) -> int:
	for i in range(y,ROWS):
		if get_piece(x,i) != null:
			return i-1
	
	return ROWS-1

func trans_surroundings(x : int, y : int, wait : bool = true) -> void:
	assert(get_piece(x,y) != null,"no piece exists here")
	var did_something : bool = false
	for i in range(-1,2,1):
		for j in range(-1,2,1):
			if i == 0 and j == 0:
				continue
			
			for k in range(7,2,-1):
				if i == 0 and k == 3:
					continue
				var line : Array[Piece] = get_line(x,y,i,j,k)
				var did_it : bool = await mutate_line(line)
				
				if did_it:
					did_something = true
					break
	print("a")
	piece_transition_finished.emit(did_something)

func get_line(x : int, y : int, i : int, j : int, length : int = 3) -> Array[Piece]:
	if length < 3:
		return []
	
	var result : Array[Piece] = []
	for k in range(0,length):
		var kx : int =  x+k*i
		var ky : int = y+k*j
		if not in_bounds(kx,ky):
			return []
		result.append(get_piece(kx,ky))
	return result

func mutate_line(line : Array[Piece]) -> bool:
	if line.size() < 3:
		return false
	
	if line.has(null):
		return false
	
	var line_color : Array[Piece.PColor] = []
	for p : Piece in line:
		line_color.append(p.color)
	
	var color : Piece.PColor = line_color[0]
	var opp_color : Piece.PColor = Piece.swap_color(color)
	
	if color != line_color[-1]:
		return false
	
	##All same color = punished
	if line_color.count(color) == line_color.size():
		for i in range(1,line.size()-1):
			line[i].trans(Piece.PColor.UNSET)
			await line[i].get_tree().create_timer(0.1).timeout
		return true
	
	if line_color.count(color) == 2:
		for i in range(1,line.size()-1):
			line[i].trans(color)
			await line[i].get_tree().create_timer(0.1).timeout
		return true
	return false
	

func remove_piece(x : int, y : int) -> Piece:
	var removed_piece : Piece = get_piece(x,y)
	assert(removed_piece != null, "Trying to remove empty piece")
	return removed_piece


##Returns a number representing the evaluation of the current position
static func evaluate(board : Board) -> int:
	var score : int = 0
	for x in COLS:
		for y in ROWS:
			var piece : Piece = board.get_piece(x,y)
			if piece == null:
				continue
			match piece.color:
				Piece.PColor.YELLOW:
					score += 1
				Piece.PColor.RED:
					score -= 1
				_:
					pass
	
	return score

func create_copy() -> Board:
	var new_board : Board = Board.new()
	for piece : Piece in board:
		if piece != null:
			new_board.board.append(piece.duplicate())
		else:
			new_board.board.append(null)
		
	return new_board

func destroy() -> void:
	for i in board.size():
		if board[i] != null:
			board[i].queue_free()
			board[i] = null
	board = []
