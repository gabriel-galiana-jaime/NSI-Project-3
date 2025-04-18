extends CharacterBody2D

var can_be_move : bool = false

#raycast
var damage : float = 0.5
var can_damage : bool = true
@onready var raycast_right = $raycast_side/RayCast2D_right
@onready var raycast_left = $raycast_side/RayCast2D_left
@onready var raycast_down = $raycast_side/RayCast2D_down
@onready var raycast_up = $raycast_side/RayCast2D_up
var speed : float = 600
func _process(delta: float) -> void:
	$AnimatedSprite2D.play("loop")
	can_damage = true
	if auto_main_autoload_script.player_data["action"] == "shield":
		can_damage = false
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
			can_damage = false
	if raycast_left.is_colliding():
		collide = raycast_left.get_collider()
		if collide.is_in_group("shield") and auto_main_autoload_script.player_data["look"] == "right" and  auto_main_autoload_script.player_data["moving_axis_x"] == 1:
			velocity = Vector2(speed*1,speed*0)
			can_damage = false
	if raycast_down.is_colliding():
		collide = raycast_down.get_collider()
		if collide.is_in_group("shield") and auto_main_autoload_script.player_data["look"] == "up" and  auto_main_autoload_script.player_data["moving_axis_y"] == -1:
			velocity = Vector2(speed*0,speed*-1)
			can_damage = false
	if raycast_up.is_colliding():
		collide = raycast_up.get_collider()
		if collide.is_in_group("shield") and auto_main_autoload_script.player_data["look"] == "down" and  auto_main_autoload_script.player_data["moving_axis_y"] == 1:
			velocity = Vector2(speed*0,speed*1)
			can_damage = false


func _on_hit_area_area_entered(area: Area2D) -> void:
	if can_damage == true and area.is_in_group("player_hit"):
		print("hit")
		auto_main_autoload_script.change_health(damage*-1)
		pass
	pass # Replace with function body.
