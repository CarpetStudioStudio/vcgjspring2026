extends Node2D

@onready var topchip : Sprite2D = $Dummy
var topchip_x : int = 3
var num_trans : int = 0
var queued_drop_x : int = -1

func _process(delta: float) -> void:
	var new_x : int = $Board.position_to_grid($Board.get_mouse_pos()).x
	new_x = clampi(new_x,0,$Board.board.COLS-1)
	if topchip_x != new_x:
		num_trans += 1
		var tween : Tween = get_tree().create_tween()
		tween.finished.connect(_trans_finished)
		tween.set_trans(Tween.TRANS_QUAD)
		var grid_pos : Vector2i = Vector2i(new_x,0)
		tween.tween_property(topchip,"global_position:x",$Board.grid_to_position(grid_pos).x,0.25)
		topchip_x = new_x

func _trans_finished() -> void:
	num_trans -= 1
	if num_trans == 0 and queued_drop_x != -1:
		$Board.drop_piece()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drop_piece"):
		if num_trans == 0:
			$Board.drop_piece()
		elif queued_drop_x == -1:
			queued_drop_x = topchip_x
