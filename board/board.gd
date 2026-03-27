class_name Board
extends Resource

signal piece_transition_finished

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

func trans_surroundings(x : int, y : int) -> void:
	assert(get_piece(x,y) != null,"no piece exists here")
	for i in range(-1,2,1):
		for j in range(-1,2,1):
			if i == 0 and j == 0:
				continue
			var did_it : bool = match_line(x,y,i,j)
			if not did_it:
				match_line(x,y,i,j,3)
			
	print("test2")
	
	piece_transition_finished.emit()

func match_line(x : int, y : int, i : int, j : int, length : int = 2) -> bool:
	var piece : Piece = get_piece(x,y)
	var color : Piece.PColor = piece.color
	
	var opp_x : int = x+length*i
	var opp_y : int = y+length*j
	if not in_bounds(opp_x,opp_y):
		return false
		
	var opp_piece : Piece = get_piece(opp_x,opp_y)
	if opp_piece == null:
		return false
	if opp_piece.color != color:
		return false
	
	for k in range(1,length):
		if get_piece(x+k*i,y+k*j) == null:
			return false
		
	for k in range(1,length):
		var trans_piece : Piece = get_piece(x+k*i,y+k*j)
		if color == trans_piece.color:
			trans_piece.trans(Piece.PColor.UNSET)
		else:
			trans_piece.trans(color)
	
	return true

func remove_piece(x : int, y : int) -> Piece:
	var removed_piece : Piece = get_piece(x,y)
	assert(removed_piece != null, "Trying to remove empty piece")
	return removed_piece
