extends CharacterBody2D

@onready var navigation_agent = $NavigationAgent2D
@onready var marker = $"../Marker2D"

# Set your desired speed and a threshold for proximity to each point.
var speed: float = 300.0
var proximity_threshold: float = 5.0

func _ready() -> void:
	navigation_agent.target_position = marker.position

func _process(delta: float) -> void:
	# Update the target if the marker might move.
	navigation_agent.target_position = marker.position
	# Get the next point along the computed path.
	var next_point: Vector2 = navigation_agent.get_next_path_position()
# Calculate the vector connecting the character to the next navigation point.
	var direction_vector: Vector2 = next_point - global_position# If we're sufficiently far from the current target point, move toward it.
	if direction_vector.length() > proximity_threshold:
		velocity = direction_vector.normalized() * speed
	else:
		velocity = Vector2.ZERO  # Stop if very close (or let the agent pick the next path point)    
	move_and_slide()
