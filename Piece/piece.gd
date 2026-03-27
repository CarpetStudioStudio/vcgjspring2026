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
static var sprites : Array[Texture] = [
	preload("res://Piece/white_dot.png"),
	preload("res://Piece/red_dot.png"),
	preload("res://Piece/yellow_dot.png")
]
