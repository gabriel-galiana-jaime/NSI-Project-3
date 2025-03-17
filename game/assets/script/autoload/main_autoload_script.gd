extends Node


func round_position(position : Vector2):
	return (round(position/16) * 16)  #+ Vector2(8,8)



#runtimes stuff

var global_spawn_player_position : Vector2

var player_data : Dictionary
