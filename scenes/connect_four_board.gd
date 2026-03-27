class_name ConnectFourBoard
extends Node2D

@onready var tile_map: TileMapLayer = $TileMap

var board : Board
var board_rows : int = 6
var board_col : int = 7
var arr2d : Array = []

func _ready() -> void:
	board = Board.new()
	make_arr2d()

# TODO: Make an array function of [7][6] & convert it to the position world
# Use the mapToLocal from tilemap to do so

func make_arr2d():
	for i in range(board_rows):
		var row = []
		for j in range(board_col):
			var tile_coord = Vector2i(i,j)
			var painted_tile = tile_map.get_cell_atlas_coords(tile_coord)
			print(painted_tile)
			row.append(painted_tile)
		arr2d.append(row)
