class_name Piece
extends Sprite2D
enum PColor {
	UNSET,
	RED,
	YELLOW
}
var color : PColor = PColor.UNSET

func _ready() -> void:
	assert(color != PColor.UNSET, "Please set the color")
