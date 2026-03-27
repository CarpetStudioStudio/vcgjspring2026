class_name Piece
extends Sprite2D

signal finished_trans

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

func trans(color : PColor) -> void:
	assert(self.color != color, "cannot transition to self")
	
	self.color = color
	await get_tree().create_timer(0.25).timeout
	finished_trans.emit()
