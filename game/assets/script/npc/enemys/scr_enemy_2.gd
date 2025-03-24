extends CharacterBody2D

var direction : Vector2 = Vector2(0,-1)
var speed : float = 900
var raycast_len : float = 9
func _process(delta: float) -> void:
	velocity = basic_move_patrol(delta)
	#$RayCast2D.target_position = Vector2(raycast_len,raycast_len) * direction
	move_and_slide()


func basic_move_patrol(delta):
	return speed * direction * delta
