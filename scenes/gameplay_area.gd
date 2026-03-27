extends Node2D

func _process(delta: float) -> void:
	var mouse_position : Vector2 = $Board.get_mouse_position()
	#$Dummy.position.x = 

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		pass
