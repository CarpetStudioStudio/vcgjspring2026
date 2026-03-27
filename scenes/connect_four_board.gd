class_name ConnectFourBoard
extends Node2D

var board : Board

func _ready() -> void:
	board = Board.new()

func get_mouse_position() -> Vector2:
	return $TileMap.get_local_mouse_position() 

func grid_to_position(pos : Vector2i) -> Vector2:
	return $TileMap.map_to_local(pos)
	
func position_to_grid(pos : Vector2) -> Vector2i:
	return $TileMap.local_to_map(pos)

func drop_piece(piece : Piece, xpos : int) -> void:
	
	var ypos : int = board.find_lowest_empty(xpos)
	board.set_piece(piece, xpos, ypos)
	var tween : Tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(piece, "position:y", grid_to_position(Vector2i(xpos, ypos)).y,1.0)
	pass
