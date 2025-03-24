extends Node2D



func _process(delta: float) -> void:
	if auto_main_autoload_script.story_line["sword?"] == true:
		$sand_sword_replacement.show()
	else:
		$sand_sword_replacement.hide()
	






func _on_check_sword_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		auto_main_autoload_script.story_line["sword?"] = true
	pass # Replace with function body.
