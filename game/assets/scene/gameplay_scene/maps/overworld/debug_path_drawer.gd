extends Node2D
@export var path_color: Color = Color.RED
@export var point_color: Color = Color.YELLOW
@export var line_width: float = 0.5
@export var point_radius: float = 1.0

var path_points: Array[Vector2] = []

func _ready() -> void:
	z_index = 100  # Any value higher than your tilemap's z-index

func _draw():
	if path_points.size() > 1:
		# Draw connecting lines
		for i in range(path_points.size() - 1):
			draw_line(path_points[i], path_points[i + 1], path_color, line_width)
		
		# Draw points
		for point in path_points:
			draw_circle(point, point_radius, point_color)
		
		# Highlight first/last points
		draw_circle(path_points[0], point_radius * 1.2, Color.GREEN)
		draw_circle(path_points[-1], point_radius * 1.2, Color.CYAN)

func update_path(new_path: Array, tilemap: TileMapLayer) -> void:
	# Clear previous path points
	path_points = []
	
	# Convert each tile position (Vector2i) to global/world coordinates
	for pos in new_path:
		if pos is Vector2i:
			# Convert tilemap coordinates to local coordinates
			var local_pos = tilemap.map_to_local(pos)
			
			# Convert local coordinates to global/world coordinates
			var world_pos = tilemap.to_global(local_pos)
			
			# Convert global coordinates to local coordinates relative to the path drawer
			var path_drawer_local_pos = to_local(world_pos)
			
			# Add to path points
			path_points.append(path_drawer_local_pos)
	
	# Redraw the path with updated positions
	queue_redraw()
