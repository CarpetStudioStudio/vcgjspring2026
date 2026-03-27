class_name Piece
extends Node
enum PieceColor {RED, YELLOW}
var pcolor : PieceColor = PieceColor.RED
@onready var pieceSprite = $Sprite2D

func set_color(color : int) -> void:
	pcolor = color
