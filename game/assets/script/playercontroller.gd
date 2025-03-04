extends CharacterBody2D
var input_axis = Vector2(0,0)

func _process(delta: float) -> void:
	input_axis = input_axis_()
	velocity = input_axis * 6000 * delta
	move_and_slide()
	pass

func input_axis_():
	return Vector2(Input.get_action_raw_strength("right") - Input.get_action_raw_strength("left"),Input.get_action_raw_strength("down") - Input.get_action_raw_strength("up"))
