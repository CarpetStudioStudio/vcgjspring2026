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
