class_name Clanker
extends Resource

func pick_move(board : Board) -> void:
	print("eval:", Board.evaluate(board))
	var new_board : Board = board.create_copy()
	new_board.destroy()
	print(new_board.board)
