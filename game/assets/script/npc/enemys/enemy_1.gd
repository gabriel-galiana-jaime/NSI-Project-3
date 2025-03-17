extends CharacterBody2D

var can_be_move : bool = false

func _process(delta: float) -> void:
	if auto_main_autoload_script.player_data["action"] == "shield":
		can_be_move = true
		move_by_player(delta)
	else:
		can_be_move = false
	

func move_by_player(delta):
	
	pass
