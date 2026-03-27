class_name Piece
extends Sprite2D

enum PColor {
	UNSET,
	RED,
	YELLOW
}
@export var color : PColor = PColor.UNSET
@export var sprites : Array[Texture]

func _ready() -> void:
	assert(color != PColor.UNSET, "Please set the color")
	
func set_color(color : PColor) -> void:
	self.color = color
	texture = sprites[int(color)]
