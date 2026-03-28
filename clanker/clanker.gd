class_name Clanker
extends Resource

func pick_move(board : Board) -> void:
	print("eval:", Board.evaluate(board))
