extends CharacterBody2D

var input_axis = Vector2(0,0)
var state_player : Dictionary = {"looking":"down","action":"idle"}
func _ready() -> void:
	state_player = {"look":"down","action":"idle"}
func _process(delta: float) -> void:
	input_axis_()
	state_machine()
	print(state_player)
	velocity = input_axis * 6000 * delta
	move_and_slide()
	pass

func input_axis_():
	input_axis =  Vector2(Input.get_action_raw_strength("right") - Input.get_action_raw_strength("left"),Input.get_action_raw_strength("down") - Input.get_action_raw_strength("up"))
	input_axis = floor(input_axis)
	pass

func state_machine():
	if input_axis.y >= 1:
		state_player["look"] = "down"
	if input_axis.y <= -1:
		state_player["look"] = "up"
	if input_axis.x >= 1:
		state_player["look"] = "right"
	if input_axis.x <= -1:
		state_player["look"] = "left"
	
	pass
