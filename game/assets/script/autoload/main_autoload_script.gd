extends Node


func round_position(position : Vector2):
	return (round(position/16) * 16)  #+ Vector2(8,8)



#runtimes stuff

var global_spawn_player_position : Vector2

var player_data : Dictionary
var player_max_health : float = 3
var player_health : float = 3
var player_is_damaged : bool = false
func change_health(damage):
	if player_data["can_damage"] == true:
		player_health += damage
	pass

func _process(delta: float) -> void:
	if player_health < 0:
		player_health = 0
