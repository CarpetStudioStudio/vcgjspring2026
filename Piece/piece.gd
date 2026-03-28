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
	preload("res://Piece/piece_grey.png"),
	preload("res://Piece/piece_red.png"),
	preload("res://Piece/piece_yellow.png")
]

static func swap_color(color : PColor) -> PColor:
	match color:
		PColor.UNSET:
			return PColor.UNSET
		PColor.RED:
			return PColor.YELLOW
		PColor.YELLOW:
			return PColor.RED
		_:
			return PColor.UNSET

func trans_alternate() -> void:
	match color:
		PColor.RED:
			color = PColor.YELLOW
		PColor.YELLOW:
			color = PColor.RED
	await get_tree().create_timer(0.25).timeout
	finished_trans.emit()
	
func trans(color : PColor) -> void:
	assert(self.color != color, "cannot transition to self")
	
	self.color = color
	await get_tree().create_timer(0.25).timeout
	finished_trans.emit()
