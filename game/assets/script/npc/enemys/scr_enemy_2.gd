extends CharacterBody2D

@onready var navigation_agent = $NavigationAgent2D
@onready var marker = $"../player/Marker2D"

# Set your desired speed and a threshold for proximity to each point.
var speed: float = 300.0
var proximity_threshold: float = 5.0

func _ready() -> void:
	# Set the initial target position for the navigation agent.
	navigation_agent.target_position = marker.global_position

func _process(delta: float) -> void:
	# Update the target position if the marker moves.
	if navigation_agent.target_position != marker.global_position:
		navigation_agent.target_position = marker.global_position
	
	# Get the next position from the navigation agent.
	var next_position = navigation_agent.get_next_path_position()

	# Check if the character is close enough to the target position.
	if position.distance_to(navigation_agent.target_position) > proximity_threshold:
		# Calculate the direction to the next position.
		var direction = (next_position - position).normalized()
		# Move the character in the direction while avoiding obstacles.
		velocity = direction * speed * delta
		move_and_slide()
	else:
		# Stop the character when close to the target.
		velocity = Vector2.ZERO
