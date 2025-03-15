extends Area2D
@export_group("change_scene",)

@export var scene_to_go : String
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Player touched the Area2D!")
		SceneManager.change_scene(auto_scene_index.scene_index[scene_to_go])
	pass # Replace with function body.
