extends Node

func _onready() ->void:
	pass
func _on_p1_pressed():
	gameplay_area.set_type(Type.PLAYER)
	pass
func _on_p2_pressed():
	print("I was pressed too")
	pass
func _on_credit_pressed():
	print("I was pressed as well")
	pass

	
	
func button_pressed() -> void:
	print("I got pressed!!!!")
	pass
