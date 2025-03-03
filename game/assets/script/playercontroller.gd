extends CharacterBody2D
var input = Vector2(0,0)

func _process(delta: float) -> void:
	input = Input.get_action_raw_strength("right") - Input.get_action_raw_strength("left")
	velocity.x = input * 6000 * delta
	move_and_slide()
	pass
