extends CharacterBody2D

#All the obj references:
@onready var anim_pl = $AnimatedSprite2D

var input_axis = Vector2(0,0)
var state_player : Dictionary = {"looking":"down","action":"idle"}

"""
!state_player! est utiliser pour pouvoir detecter l'état du joueur.
"""
func _ready() -> void:
	state_player = {"look":"down","action":"idle"}
func _process(delta: float) -> void:
	input_axis_()
	state_machine()
	animation_player()
	velocity = input_axis * 3500
	velocity =  velocity * delta
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

func animation_player():
	anim_pl.flip_h = false
	if state_player["look"] == "right":
		if abs(input_axis.x) >= 1:
			anim_pl.play("run_right")
		else:
			anim_pl.play("idle_right")
	if state_player["look"] == "left":
		anim_pl.flip_h = true
		if abs(input_axis.x) >= 1:
			anim_pl.play("run_right")
		else:
			anim_pl.play("idle_right")
	if state_player["look"] == "up":
		if abs(input_axis.y) >= 1:
			anim_pl.play("run_up")
		else:
			anim_pl.play("idle_up")
	if state_player["look"] == "down":
		if abs(input_axis.y) >= 1:
			anim_pl.play("run_down")
		else:
			anim_pl.play("idle_down")
