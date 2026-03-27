class_name Board
extends Resource

enum GamePiece{
	EMPTY,
	RED,
	YELLOW
}

const ROWS : int = 6
const COLS : int = 7

var board : Array[GamePiece]

func _init() -> void:
	for i in 7*6:
		board.append(GamePiece.EMPTY)

func in_bounds(x : int, y : int) -> bool:
	if x < 0 || y < 0:
		return false
	if x >= COLS || y >= ROWS:
		return false
	return true

func get_piece(x : int, y : int) -> GamePiece:
	assert(in_bounds(x,y), "Out of bounds get")
	return board[y*COLS+x]

func set_piece(piece : GamePiece, x : int, y : int) -> void:
	assert(get_piece(x,y) == GamePiece.EMPTY, "trying to set a piece that's not empty!")
	board[y*COLS+x] = piece

##Finds the lowest empty from the top of the board
func find_lowest_empty(x : int) -> int:
	return find_lowest_empty_xy(x,0)


func find_lowest_empty_xy(x : int, y : int) -> int:
	for i in range(y,ROWS):
		if get_piece(x,i) != GamePiece.EMPTY:
			return i-1
	
	return -1

func remove_piece(x : int, y : int) -> GamePiece:
	var removed_piece : GamePiece = get_piece(x,y)
	assert(removed_piece != GamePiece.EMPTY, "Trying to remove empty piece")
	return removed_piece
