class_name ConnectFourBoard
extends Node2D

var board : Board

func _ready() -> void:
	board = Board.new()
	
func get_mouse_pos() -> Vector2:
	return $TileMap.get_local_mouse_position()

func grid_to_position(pos : Vector2i) -> Vector2:
	var world_pos : Vector2i = $TileMap.map_to_local(pos)+$TileMap.global_position
	world_pos += Vector2i(-1,3)
	return world_pos
	
func position_to_grid(pos : Vector2) -> Vector2i:
	return $TileMap.local_to_map(pos)

func drop_piece(piece : Piece, xpos : int) -> Error:
	var ypos : int = board.find_lowest_empty(xpos)
	if not board.in_bounds(xpos, ypos):
		return ERR_INVALID_DATA
	print("Lowest", ypos)
	board.set_piece(piece, xpos, ypos)
	var tween : Tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(piece, "position:y", grid_to_position(Vector2i(xpos, ypos)).y,1.0)
	return OK

  
func snap(pos : Vector2) -> Vector2:
	return grid_to_position(position_to_grid(pos))
