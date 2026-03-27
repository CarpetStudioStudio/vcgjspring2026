class_name Piece
extends Sprite2D

enum PColor {
	UNSET,
	RED,
	YELLOW
}
@export var color : PColor = PColor.UNSET:
	set(new_val):
		color = new_val
		texture = sprites[int(color)]
@export var sprites : Array[Texture]
