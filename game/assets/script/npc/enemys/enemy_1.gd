extends CharacterBody2D

var can_be_move : bool = false

#raycast

@onready var raycast_right = $raycast_side/RayCast2D_right
@onready var raycast_left = $raycast_side/RayCast2D_left
@onready var raycast_down = $raycast_side/RayCast2D_down
@onready var raycast_up = $raycast_side/RayCast2D_up
var speed : float = 600
func _process(delta: float) -> void:
	if auto_main_autoload_script.player_data["action"] == "shield":
		can_be_move = true
		move_by_player(delta)
		velocity = velocity * delta
		move_and_slide()
	else:
		can_be_move = false
	

func move_by_player(delta):
	#right:
	velocity = Vector2(0,0)
	var collide
	if raycast_right.is_colliding():
		collide = raycast_right.get_collider()
		if collide.is_in_group("shield") and auto_main_autoload_script.player_data["look"] == "left" and  auto_main_autoload_script.player_data["moving_axis_x"] == -1:
			velocity = Vector2(speed*-1,speed*0)
		pass
	pass
