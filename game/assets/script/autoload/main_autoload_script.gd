extends Node


func round_position_player(position : Vector2):
	return (round(position/16) * 16)  - Vector2(8,8)
