extends Node2D

@export var temp_piece_packed : PackedScene
@export var follow_curve : Curve
@onready var topchip : Sprite2D = $Dummy

enum Turn {
	PLAYER,
	AI
}
var current_player : Turn

##THESE ARE ARRAY POSITIONS, NOT WORLD SPACE
var topchip_target_x : int = 0:
	set(new_val):
		topchip_target_x = new_val
		target_position_x_world = $Board.grid_to_position(Vector2i(topchip_target_x,0)).x
var target_position_x_world : int = 0
var queued_drop_x : int = -1

var dist : float = 0

func set_turn(turn: Turn) -> void:
	if turn == Turn.PLAYER:
		current_player = Turn.PLAYER
		$Dummy.texture = Piece.sprites[Piece.PColor.YELLOW]
	else:
		current_player = Turn.AI
		$Dummy.texture = Piece.sprites[Piece.PColor.RED]

func _ready() -> void:
	if randi() % Turn.size() == 0:
		set_turn(Turn.PLAYER)
	else:
		set_turn(Turn.AI)

func _process(delta: float) -> void:
	if queued_drop_x == -1:
		var new_x : int = $Board.position_to_grid($Board.get_mouse_pos()).x
		new_x = clampi(new_x,0,$Board.board.COLS-1)
		topchip_target_x = new_x
		
	dist = absf(topchip.position.x-target_position_x_world)
	print(dist)
	topchip.position.x = move_toward(topchip.position.x,target_position_x_world,follow_curve.sample(dist))
	
	if queued_drop_x != -1 and is_zero_approx(dist):
		initiate_drop(queued_drop_x)
		queued_drop_x = -1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drop_piece"):
		var dist : float = absf(topchip.position.x-target_position_x_world)
		if is_zero_approx(dist):
			initiate_drop(topchip_target_x)
		elif queued_drop_x == -1:
			queued_drop_x = topchip_target_x

func initiate_drop(x : int) -> void:
	var new_piece : Piece = temp_piece_packed.instantiate()	
	if(current_player == Turn.PLAYER):
		new_piece.color = Piece.PColor.YELLOW
	else:
		new_piece.color = Piece.PColor.RED
	add_child(new_piece)
	new_piece.global_position = $Board.grid_to_position(Vector2i(x,-1))
	var err = $Board.drop_piece(new_piece,x)
	
	if err == OK:
		if(current_player == Turn.PLAYER):
			set_turn(Turn.AI)
		else:
			set_turn(Turn.PLAYER)
	else:
		new_piece.queue_free()
