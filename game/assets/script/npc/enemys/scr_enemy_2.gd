extends CharacterBody2D

@export var pathfinding_reach : int = 20
@export var debug : bool = true

@onready var navigation_agent = $NavigationAgent2D
@onready var path_drawer = $"../debug_path_drawer"
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
	
	if debug:
		if path_drawer:
			path_drawer.update_path(path, tilemap_obstacles)
	
	if path.size() > 1:  # Safety check
		next_position = tilemap_obstacles.map_to_local(path[1])

	next_position = tilemap_obstacles.map_to_local(path[1])
	var direction = (next_position - position).normalized()
	velocity = direction * speed * delta
	move_and_slide()
	

# Pathfinding Prototype with BFS (Fixed Set Implementation)
func get_tile() -> Vector2i:
	var tile_pos = tilemap_obstacles.local_to_map(global_position)
	return Vector2i(tile_pos)

func get_adjacent_paths(tile_pos: Vector2i) -> Array:
	var adjacent_positions = [
		tile_pos + Vector2i(1, 0),
		tile_pos + Vector2i(0, 1),
		tile_pos + Vector2i(-1, 0),
		tile_pos + Vector2i(0, -1)
	]
	var adjacent_paths = []
	for adj_pos in adjacent_positions:
		var tile_data = tilemap_obstacles.get_cell_tile_data(adj_pos)
		# Check if the tile is walkable (not an obstacle)
		if not tile_data or not tile_data.get_custom_data("obstacle"):
			adjacent_paths.append(adj_pos)
	return adjacent_paths

func pathfinding() -> Array:
	var start_tile: Vector2i = get_tile()
	var target_tile: Vector2i = tilemap_obstacles.local_to_map(marker.global_position)
	
	# BFS Initialization with path length tracking
	if start_tile != target_tile:
		var queue: Array = [[start_tile]]  # Stores paths as arrays of tiles
		var visited = {}
		
		while queue.size() > 0:
			var current_path: Array = queue.pop_front()
			var current_tile: Vector2i = current_path[-1]
			
			# Return path if target found
			if current_tile == target_tile:
				return current_path
			
			# Cap path length using pathfinding_reach
			if current_path.size() >= pathfinding_reach:
				return [start_tile, start_tile]  # Skip processing this path if beyond reach
			
			# Explore neighbors
			for neighbor in get_adjacent_paths(current_tile):
				if not visited.has(neighbor):
					visited[neighbor] = true
					queue.append(current_path + [neighbor] as Array)
	
	
	return [start_tile, start_tile]  # Fallback for edge cases
