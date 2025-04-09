extends Node2D
@export var path_color: Color = Color.RED
@export var point_color: Color = Color.YELLOW
@export var line_width: float = 2.0
@export var point_radius: float = 4.0

var path_points: Array[Vector2] = []

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
	#print("New Path: ", new_path)
	path_points = []
	for pos in new_path:
		if pos is Vector2i:
			var world_pos = tilemap.map_to_local(pos)
			#print("Converted Pos: ", world_pos)
			path_points.append(world_pos)
	queue_redraw()
