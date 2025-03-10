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
	position = auto_main_autoload_script.round_position(position)
func _physics_process(delta: float) -> void:
	input_axis_()
	state_machine()
	animation_player()
	velocity = input_axis * 3000 * delta
	#velocity =  velocity * delta
	move_and_slide()
	pass

func input_axis_():
	input_axis =  Vector2(Input.get_action_raw_strength("right") - Input.get_action_raw_strength("left"),Input.get_action_raw_strength("down") - Input.get_action_raw_strength("up"))
	input_axis = floor(input_axis)
	pass

func state_machine():
	if Input.get_action_raw_strength("action_b") >= 1:
		state_player["action"] = "shield"
	elif Input.get_action_raw_strength("action_a") >= 1:
		state_player["action"] = "swin"
	else:
		state_player["action"] = "idle"
	if input_axis.y >= 1:
		state_player["look"] = "down"
	if input_axis.y <= -1:
		state_player["look"] = "up"
	if input_axis.x >= 1:
		state_player["look"] = "right"
	if input_axis.x <= -1:
		state_player["look"] = "left"
	print(state_player)
	pass

func animation_player():
	if state_player["action"] == "idle":
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
	elif state_player["action"] == "shield":
		anim_pl.flip_h = false
		if state_player["look"] == "right":
			if abs(input_axis.x) >= 1:
				anim_pl.play("shield_run_right")
			else:
				anim_pl.play("shield_idle_right")
		if state_player["look"] == "left":
			anim_pl.flip_h = true
			if abs(input_axis.x) >= 1:
				anim_pl.play("shield_run_right")
			else:
				anim_pl.play("shield_idle_right")
		if state_player["look"] == "up":
			if abs(input_axis.y) >= 1:
				anim_pl.play("shield_run_up")
			else:
				anim_pl.play("shield_idle_up")
		if state_player["look"] == "down":
			if abs(input_axis.y) >= 1:
				anim_pl.play("shield_run_down")
			else:
				anim_pl.play("shield_idle_down")
	elif state_player["action"] == "swin":
		anim_pl.flip_h = false
		if state_player["look"] == "right":
			if abs(input_axis.x) >= 1:
				anim_pl.play("water_run_right")
			else:
				anim_pl.play("water_idle_right")
		if state_player["look"] == "left":
			anim_pl.flip_h = true
			if abs(input_axis.x) >= 1:
				anim_pl.play("water_run_right")
			else:
				anim_pl.play("water_idle_right")
		if state_player["look"] == "up":
			if abs(input_axis.y) >= 1:
				anim_pl.play("water_run_up")
			else:
				anim_pl.play("water_idle_up")
		if state_player["look"] == "down":
			if abs(input_axis.y) >= 1:
				anim_pl.play("water_run_down")
			else:
				anim_pl.play("water_idle_down")
