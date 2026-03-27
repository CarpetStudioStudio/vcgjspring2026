class_name ConnectFourBoard
extends Node2D

var board : Board 

func _ready() -> void:
	board = Board.new()
