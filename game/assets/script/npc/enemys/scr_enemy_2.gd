extends CharacterBody2D

@export var pathfinding_reach : int = 30

@onready var navigation_agent = $NavigationAgent2D
@onready var marker = $"../player/Marker2D"
@onready var tilemap = $"../world/main_tilemap"
@onready var tilemap_obstacles = $"../world/main_tilemap/TileMapLayer_2"

# Set your desired speed and a threshold for proximity to each point.
var speed: float = 300.0
var proximity_threshold: float = 5.0
var path : Array
var next_position : Vector2

func _ready() -> void:
	# Set the initial target position for the navigation agent.
	navigation_agent.target_position = marker.global_position

func _process(delta: float) -> void:
	# Update the target position if the marker moves.
	"""
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
	"""
	path = pathfinding()
	next_position = tilemap_obstacles.map_to_local(path[1])
	var direction = (next_position - position).normalized()
	velocity = direction * speed * delta
	move_and_slide()
	

#> PATHFINDING PROTOTYPE
func get_tile():
	var tile_pos = tilemap_obstacles.local_to_map(global_position)
	var tile_data = tilemap_obstacles.get_cell_tile_data(tile_pos)
	#print("tile ", str(tile_pos))
	return Vector2i(tile_pos)

func get_adjacent_paths(tile_pos : Vector2i):
	var adjacent_positions = [
		tile_pos + Vector2i(1, 0),
		tile_pos + Vector2i(0, 1),
		tile_pos + Vector2i(-1, 0),
		tile_pos + Vector2i(0, -1)
		]
	var adjacent_paths = []
	for adj_pos in adjacent_positions:
		var tile_data = tilemap_obstacles.get_cell_tile_data(adj_pos)
		if tile_data:
			if tile_data.get_custom_data("obstacle"):
				adjacent_paths.append(adj_pos)
		else:
			adjacent_paths.append(adj_pos)

	return adjacent_paths

func pathfinding():
	var current_tile : Vector2i = get_tile()
	var paths : Array = [[current_tile]]
	var target_cell : Vector2i = tilemap_obstacles.local_to_map(marker.global_position)
	for i in range(pathfinding_reach):
		for path in paths:
			var path_end : Vector2i = path[-1]
			var new_branches : Array = get_adjacent_paths(path_end)
			for branch in new_branches:
				paths.append(path + [branch])
	for path in paths:
		if path[-1] != target_cell:
			paths.erase(path)
	var final_path : Array = paths[0]
	for path in paths:
		if len(final_path) > len(path):
			final_path = path
	return final_path
			
