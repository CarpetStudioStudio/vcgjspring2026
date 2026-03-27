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
	var piece : Piece = get_piece(x,y)
	assert(piece != null,"no piece exists here")
	
	var color : Piece.PColor = piece.color
	for i in range(-1,2,2):
		for j in range(-1,2,2):
			if i == 0 and j == 0:
				continue
			var x2 : int = x+2*i
			var y2 : int = y+2*j
			if not in_bounds(x2,y2):
				continue
			
			var opp_piece : Piece = get_piece(x2,y2)
			if opp_piece == null:
				continue
			if opp_piece.color != color:
				continue
			
			var trans_piece : Piece = get_piece(x+i,y+j)
			if trans_piece == null:
				continue
			if trans_piece.color == color:
				continue
			trans_piece.trans(color)
			await trans_piece.finished_trans
	print("test2")
	
	piece_transition_finished.emit()

func remove_piece(x : int, y : int) -> Piece:
	var removed_piece : Piece = get_piece(x,y)
	assert(removed_piece != null, "Trying to remove empty piece")
	return removed_piece
