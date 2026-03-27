class_name ConnectFourBoard
extends Node2D

signal drop_resolved
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

func drop_piece(piece : Piece, xpos : int) -> void:
	var drop_pos : Vector2i = Vector2i(xpos,board.find_lowest_empty(xpos))
	assert(board.in_bounds(drop_pos.x, drop_pos.y),"not in bounts")
	print("Lowest", drop_pos.y)
	board.set_piece(piece, drop_pos.x, drop_pos.y)
	var tween : Tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(piece, "position:y", grid_to_position(drop_pos).y,1.0)
	await tween.finished
	board.piece_transition_finished.connect(func() -> void:
		drop_resolved.emit()
	)
	board.trans_surroundings(drop_pos.x,drop_pos.y)

  
func snap(pos : Vector2) -> Vector2:
	return grid_to_position(position_to_grid(pos))
