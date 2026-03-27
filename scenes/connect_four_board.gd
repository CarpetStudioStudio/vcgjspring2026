class_name ConnectFourBoard
extends Node2D

var board : Board

func _ready() -> void:
	board = Board.new()

func drop_piece() -> void:
	create_tween()
	print("DROPPED")
	
func get_mouse_pos() -> Vector2:
	return $TileMap.get_local_mouse_position()

func grid_to_position(pos : Vector2i) -> Vector2:
	return $TileMap.map_to_local(pos)+$TileMap.global_position
	
func position_to_grid(pos : Vector2) -> Vector2i:
	return $TileMap.local_to_map(pos)

func snap(pos : Vector2) -> Vector2:
	return grid_to_position(position_to_grid(pos))
